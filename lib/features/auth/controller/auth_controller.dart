import 'package:ass_blog_app/core/config/pallet.dart';
import 'package:ass_blog_app/core/helper/get_storage_helper.dart';
import 'package:ass_blog_app/core/routes/router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  final loginKey = GlobalKey<FormState>();
  final signUPKey = GlobalKey<FormState>();
  final TextEditingController signUpemailController = TextEditingController();
  final TextEditingController signUppasswordController =
      TextEditingController();
  final TextEditingController signUpconfirmPasswordController =
      TextEditingController();
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  RxBool isLoading = false.obs;
  RxBool isLoading1 = false.obs;

  // Sign Up Method
  Future<void> signUp() async {
    if (!signUPKey.currentState!.validate()) return;

    isLoading.value = true;

    try {
      // Check if email already exists in Firestore
      QuerySnapshot query = await _firestore
          .collection('blog_users')
          .where('email', isEqualTo: signUpemailController.text.trim())
          .get();

      if (query.docs.isNotEmpty) {
        Get.snackbar(
          'Error',
          'User with this email already exists.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red,
        );
        isLoading.value = false;
        return;
      }

      // Save user directly to Firestore
      String userId =
          _firestore.collection('blog_users').doc().id; // Generate unique ID
      await _firestore.collection('blog_users').doc(userId).set({
        'email': signUpemailController.text.trim(),
        'password': signUppasswordController.text.trim(),
        'uid': userId,
      });
      box.write("email", signUpemailController.text);
      box.write("uid", userId);

      Get.snackbar(
        'Success',
        'Account created successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );

      Get.offAllNamed(AppRoutes.dashboardScreen);
      box.write("is_logged_in", true);
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Login Method
  Future<void> login() async {
    if (!loginKey.currentState!.validate()) return;

    isLoading.value = true;

    try {
      // Check if the user exists in Firestore
      QuerySnapshot query = await _firestore
          .collection('blog_users')
          .where('email', isEqualTo: loginEmailController.text.trim())
          .get();

      if (query.docs.isEmpty) {
        Get.snackbar(
          'Error',
          'No account found with this email.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red,
        );
        isLoading.value = false;
        return;
      }

      // Verify password
      var user = query.docs.first;
      box.write("uid", user["uid"]);
      box.write("email", user["email"]);
      if (user['password'] != loginPasswordController.text.trim()) {
        Get.snackbar(
          'Error',
          'Incorrect password.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red,
        );
        isLoading.value = false;
        return;
      }

      Get.snackbar(
        'Success',
        'Login successful!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );

      Get.offAllNamed(AppRoutes.dashboardScreen);
      box.write("is_logged_in", true);
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    box.erase();
    Get.offAllNamed(AppRoutes.loginScreen);
  }

  void showLogoutPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Get.back(), // Close the dialog
              child: const Text(
                'Cancel',
                style: TextStyle(color: Palette.blue),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                logout();
                Get.back(); // Close the dialog after logout
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Palette.orange,
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  Future<void> signInWithGoogle() async {
    try {
      isLoading1.value = true;

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // User canceled Google Sign-In
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        // Check if the user exists in Firestore
        QuerySnapshot query = await _firestore
            .collection('blog_users')
            .where('email', isEqualTo: user.email)
            .get();

        if (query.docs.isEmpty) {
          // New user, create a record in Firestore
          String userId = user.uid;

          await _firestore.collection('blog_users').doc(userId).set({
            'email': user.email,
            'name': user.displayName ?? "No Name",
            'uid': userId,
            'auth_method': 'google',
          });

          Get.snackbar(
            'Success',
            'Google account linked and user created!',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.green,
          );
        } else {
          // Existing user, log them in
          Get.snackbar(
            'Welcome Back',
            'Logged in successfully with Google!',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.green,
          );
        }

        // Save user session
        box.write("email", user.email);
        box.write("uid", user.uid);
        box.write("is_logged_in", true);

        Get.offAllNamed(AppRoutes.dashboardScreen);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Google Sign-In failed: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    } finally {
      isLoading1.value = false;
    }
  }
}
