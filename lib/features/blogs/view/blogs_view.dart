import 'package:ass_blog_app/features/auth/controller/auth_controller.dart';
import 'package:ass_blog_app/features/blogs/widgets/blog_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ass_blog_app/core/config/pallet.dart';
import 'package:get/get.dart';

class BlogsView extends StatefulWidget {
  const BlogsView({super.key});

  @override
  State<BlogsView> createState() => _BlogsViewState();
}

class _BlogsViewState extends State<BlogsView> {
  final List<String> categories = [
    'All',
    'Technology',
    'Lifestyle',
    'Education',
    'Health'
  ];
  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<AuthController>()) {
      Get.lazyPut<AuthController>(() => AuthController());
    }

    final isWeb = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: isWeb
              ? const BoxConstraints(maxWidth: 800)
              : const BoxConstraints(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: isWeb ? 24 : 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: isWeb ? 20 : 16.h),
                _buildCategoryChips(),
                SizedBox(height: isWeb ? 20 : 16.h),
                Expanded(
                  child: StreamBuilder(
                    stream: selectedCategory == 'All'
                        ? FirebaseFirestore.instance
                            .collection("blogs")
                            .orderBy("created_at", descending: true)
                            .snapshots()
                        : FirebaseFirestore.instance
                            .collection("blogs")
                            .where("category", isEqualTo: selectedCategory)
                            .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Text(
                            'No blogs found!',
                            style: TextStyle(
                              fontSize: isWeb ? 20 : 18.sp,
                              color: Palette.greyText,
                            ),
                          ),
                        );
                      }

                      final blogDocs = snapshot.data!.docs;
                      return ListView.builder(
                        itemCount: blogDocs.length,
                        itemBuilder: (context, index) {
                          final blog = blogDocs[index];
                          return BlogCard(
                            title: blog["title"] ?? "No Title",
                            description:
                                blog["description"] ?? "No Description",
                            tags: List.from(blog["tags"] ?? []),
                            imageUrl: blog["image_url"] ??
                                "https://via.placeholder.com/150",
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          final bool isSelected = selectedCategory == category;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ChoiceChip(
              label: Text(
                category,
                style: TextStyle(
                  color: isSelected ? Colors.white : Palette.blackText,
                  fontWeight: FontWeight.bold,
                ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  selectedCategory = category;
                });
              },
              selectedColor: Palette.orange,
              backgroundColor: Palette.lightGrey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: isSelected ? Palette.orange : Palette.lightGrey,
                  width: 2,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          );
        }).toList(),
      ),
    );
  }
}
