// ignore_for_file: unused_import

import 'package:ass_blog_app/core/config/pallet.dart';
import 'package:ass_blog_app/core/widgets/primary_button.dart';
import 'package:ass_blog_app/core/widgets/text_f.dart';
import 'package:ass_blog_app/features/blogs/controller/blog_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class CreateBlog extends StatelessWidget {
  const CreateBlog({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<BlogController>()) {
      Get.lazyPut<BlogController>(() => BlogController());
    }
    final BlogController controller = Get.find<BlogController>();

    final isWeb = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Create Blog',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: isWeb
              ? const BoxConstraints(maxWidth: 600)
              : const BoxConstraints(),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: isWeb ? 32 : 24.w),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isWeb) SizedBox(height: 8.h),
                  Text(
                    'Share your thoughts and ideas',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Palette.greyText,
                          fontSize: isWeb ? 16 : null,
                        ),
                  ),
                  SizedBox(height: isWeb ? 20 : 30.h),
                  TextF(
                    labelText: "Title",
                    controller: controller.titleController,
                    hintText: "Enter your blog title",
                    prefixIcon:
                        const Icon(Icons.title, color: Palette.greyText),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: isWeb ? 16 : 20.h),
                  TextF(
                    labelText: "Description",
                    controller: controller.descriptionController,
                    hintText: "Enter your blog description",
                    maxLine: 4,
                    prefixIcon: const Icon(Icons.description_outlined,
                        color: Palette.greyText),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: isWeb ? 16 : 20.h),
                  Obx(() => DropdownButtonFormField<String>(
                        value: controller.selectedCategory.value.isEmpty
                            ? null
                            : controller.selectedCategory.value,
                        onChanged: (value) {
                          controller.selectedCategory.value = value!;
                          if (controller.formKey.currentState != null) {
                            controller.formKey.currentState!.validate();
                          }
                        },
                        decoration: const InputDecoration(
                          labelText: 'Category',
                          labelStyle: TextStyle(fontSize: 15),
                          prefixIcon:
                              Icon(Icons.category, color: Palette.greyText),
                          border: OutlineInputBorder(),
                        ),
                        items: controller.categories
                            .map((category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(
                                    category,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ))
                            .toList(),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please select a category'
                            : null,
                      )),
                  SizedBox(height: isWeb ? 16 : 20.h),
                  Obx(() => Wrap(
                        spacing: isWeb ? 6 : 8.w,
                        children: controller.tags
                            .map((tag) => ChoiceChip(
                                  label: Text(tag),
                                  selected:
                                      controller.selectedTags.contains(tag),
                                  onSelected: (selected) {
                                    if (selected) {
                                      controller.selectedTags.add(tag);
                                    } else {
                                      controller.selectedTags.remove(tag);
                                    }
                                  },
                                ))
                            .toList(),
                      )),
                  SizedBox(height: isWeb ? 16 : 20.h),
                  Obx(() => GestureDetector(
                        onTap: () {
                          !isWeb
                              ? Get.bottomSheet(
                                  Container(
                                    height: isWeb ? 200 : 150.h,
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: const Icon(Icons.camera_alt),
                                          title: const Text('Camera'),
                                          onTap: () {
                                            controller
                                                .pickImage(ImageSource.camera);
                                            Get.back();
                                          },
                                        ),
                                        ListTile(
                                          leading: const Icon(Icons.photo),
                                          title: const Text('Gallery'),
                                          onTap: () {
                                            controller
                                                .pickImage(ImageSource.gallery);
                                            Get.back();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : controller.pickImage(ImageSource.gallery);
                        },
                        child: Container(
                          height: isWeb ? 200 : 150.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Palette.lightGrey),
                            borderRadius:
                                BorderRadius.circular(isWeb ? 8 : 12.r),
                            color: Palette.advertisementColor,
                          ),
                          child: controller.webImage.value != null
                              ? Image.memory(
                                  controller.webImage.value!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                )
                              : controller.pickedImage.value != null
                                  ? Image.file(
                                      controller.pickedImage.value!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.upload_file,
                                          size: isWeb ? 50 : 40.sp,
                                          color: Palette.greyText,
                                        ),
                                        SizedBox(height: isWeb ? 12 : 8.h),
                                        Text(
                                          'Upload Image',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                color: Palette.greyText,
                                              ),
                                        ),
                                      ],
                                    ),
                        ),
                      )),
                  SizedBox(height: isWeb ? 24 : 30.h),
                  Obx(() {
                    return controller.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : PrimaryButton(
                            buttonText: "Create Blog",
                            onPressed: () => controller.submitBlog(),
                          );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
