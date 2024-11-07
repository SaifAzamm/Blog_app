import 'dart:ui';
import 'package:ass_blog_app/core/config/pallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BlogCard extends StatelessWidget {
  final String title;
  final String description;
  final List<String> tags;
  final String imageUrl;

  const BlogCard({
    super.key,
    required this.title,
    required this.description,
    required this.tags,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 600;

    return Card(
      margin: EdgeInsets.symmetric(vertical: isWeb ? 12 : 10.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(isWeb ? 10 : 12.r),
      ),
      elevation: 3,
      color: Colors.grey[50], // Slight off-white background for better contrast
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(isWeb ? 10 : 12.r),
            child: Image.network(
              imageUrl,
              height: isWeb ? 220 : 200.h,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: isWeb ? 220 : 200.h,
                width: double.infinity,
                color: Palette.lightGrey,
                child: Icon(Icons.broken_image,
                    size: isWeb ? 48 : 40.sp, color: Palette.greyText),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(isWeb ? 10 : 12.r),
                bottomRight: Radius.circular(isWeb ? 10 : 12.r),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                child: Container(
                  padding: EdgeInsets.all(isWeb ? 16 : 12.w),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(isWeb ? 10 : 12.r),
                      bottomRight: Radius.circular(isWeb ? 10 : 12.r),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: isWeb ? 16 : 14.sp,
                                    color: Colors.white,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: isWeb ? 10 : 8.w),
                          Wrap(
                            spacing: isWeb ? 6 : 4.w,
                            children: tags
                                .map((tag) => Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: isWeb ? 8 : 6.w,
                                          vertical: isWeb ? 4 : 3.h),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(
                                            isWeb ? 6 : 6.r),
                                      ),
                                      child: Text(
                                        tag,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              fontSize: isWeb ? 12 : 10.sp,
                                              color: Colors.white,
                                            ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                      SizedBox(height: isWeb ? 6 : 4.h),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.white70,
                              fontSize: isWeb ? 14 : 12.sp,
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
