import 'package:ass_blog_app/core/helper/get_storage_helper.dart';
import 'package:ass_blog_app/core/routes/router.dart';
import 'package:ass_blog_app/features/blogs/widgets/blog_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ass_blog_app/core/config/pallet.dart';
import 'package:get/get.dart';

class UserBlogsView extends StatelessWidget {
  const UserBlogsView({super.key});

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: isWeb
              ? const BoxConstraints(maxWidth: 800)
              : const BoxConstraints(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: isWeb ? 24 : 16.w),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("blogs")
                  .where('uid', isEqualTo: box.read('uid'))
                  .orderBy("created_at", descending: true)
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
                      description: blog["description"] ?? "No Description",
                      tags: List.from(blog["tags"] ?? []),
                      imageUrl: blog["image_url"] ??
                          "https://via.placeholder.com/150",
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(AppRoutes.createBlogScreen),
        backgroundColor: Palette.orange,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
