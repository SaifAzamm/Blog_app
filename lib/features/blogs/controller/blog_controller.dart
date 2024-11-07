import 'package:ass_blog_app/core/helper/get_storage_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;

class BlogController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  RxString selectedCategory = ''.obs;
  RxList<String> selectedTags = <String>[].obs;
  Rxn<File> pickedImage = Rxn<File>();
  Rxn<Uint8List> webImage = Rxn<Uint8List>();
  Rxn<String> imageUrl = Rxn<String>();
  RxBool isLoading = false.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<String> categories = [
    'Technology',
    'Lifestyle',
    'Education',
    'Health'
  ];
  final List<String> tags = ['Flutter', 'Dart', 'GetX', 'Firebase', 'UI/UX'];

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      if (kIsWeb) {
        webImage.value = await pickedFile.readAsBytes();
      } else {
        pickedImage.value = File(pickedFile.path);
      }
    } else {
      Get.snackbar(
        'Error',
        'No image selected!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.2),
        colorText: Colors.red,
      );
    }
  }

  Future<String> uploadImageToFirebase(Uint8List bytes) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('blogs/${DateTime.now().millisecondsSinceEpoch}.jpg');
    final uploadTask = await storageRef.putData(bytes);
    return await uploadTask.ref.getDownloadURL();
  }

  Future<void> submitBlog() async {
    if (formKey.currentState!.validate()) {
      if (selectedTags.isEmpty) {
        Get.snackbar(
          'Error',
          'Select at least 1 tag.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.2),
          colorText: Colors.red,
        );
      } else if (pickedImage.value == null && webImage.value == null) {
        Get.snackbar(
          'Error',
          'Upload image first.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.2),
          colorText: Colors.red,
        );
      } else {
        try {
          isLoading.value = true;
          String? downloadUrl;

          if (kIsWeb && webImage.value != null) {
            downloadUrl = await uploadImageToFirebase(webImage.value!);
          } else if (pickedImage.value != null) {
            downloadUrl = await uploadImageToFirebase(
                await pickedImage.value!.readAsBytes());
          }

          String blogId = _firestore.collection('blogs').doc().id;

          await _firestore.collection('blogs').doc(blogId).set({
            'blog_id': blogId,
            'uid': box.read('uid'),
            'title': titleController.text.trim(),
            'description': descriptionController.text.trim(),
            'category': selectedCategory.value,
            'tags': selectedTags,
            'image_url': downloadUrl ?? '',
            'created_at': FieldValue.serverTimestamp(),
          });

          Get.back();
          Get.snackbar(
            'Success',
            'Blog created successfully!',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.2),
            colorText: Colors.green,
          );
          clearForm();
        } catch (e) {
          Get.snackbar(
            'Error',
            'Failed to create blog: $e',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.2),
            colorText: Colors.red,
          );
        } finally {
          isLoading.value = false;
        }
      }
    }
  }

  void clearForm() {
    titleController.clear();
    descriptionController.clear();
    selectedCategory.value = '';
    selectedTags.clear();
    pickedImage.value = null;
    webImage.value = null;
    imageUrl.value = null;
  }
}
