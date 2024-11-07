import 'package:ass_blog_app/core/config/pallet.dart';
import 'package:ass_blog_app/core/helper/get_storage_helper.dart';
import 'package:ass_blog_app/features/auth/controller/auth_controller.dart';
import 'package:ass_blog_app/features/blogs/view/blogs_view.dart';
import 'package:ass_blog_app/features/blogs/view/user_blogs_view.dart';
import 'package:ass_blog_app/features/dashboard/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DashboardView extends StatelessWidget {
  DashboardView({super.key});

  final List<Widget> screens = [
    const BlogsView(),
    const UserBlogsView(),
  ];

  final List<String> titles = ['All Blogs', 'My Blogs'];

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<AuthController>()) {
      Get.lazyPut<AuthController>(() => AuthController());
    }
    if (!Get.isRegistered<DashboardController>()) {
      Get.lazyPut<DashboardController>(() => DashboardController());
    }

    final AuthController authController = Get.find<AuthController>();
    final DashboardController controller = Get.find<DashboardController>();

    final isWeb = MediaQuery.of(context).size.width > 600;

    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: isWeb
              ? Row(
                  mainAxisAlignment: isWeb
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.center,
                  children: [
                    if (isWeb)
                      Text(
                        box.read("email") ?? "User Email",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Palette.greyText,
                        ),
                      ),
                    Text(
                      titles[controller.currentIndex.value],
                      style: TextStyle(
                        fontSize: isWeb ? 22 : 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(),
                  ],
                )
              : Text(
                  titles[controller.currentIndex.value],
                  style: TextStyle(
                    fontSize: isWeb ? 22 : 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          centerTitle: !isWeb,
          backgroundColor: Palette.backGround,
          elevation: 0,
          actions: isWeb
              ? [
                  TextButton(
                    onPressed: () => controller.changeTabIndex(0),
                    child: const Text('All Blogs',
                        style: TextStyle(color: Palette.blue)),
                  ),
                  TextButton(
                    onPressed: () => controller.changeTabIndex(1),
                    child: const Text('My Blogs',
                        style: TextStyle(color: Palette.blue)),
                  ),
                  if (isWeb)
                    IconButton(
                      icon: const Icon(Icons.logout),
                      color: Palette.blue,
                      tooltip: "Logout",
                      onPressed: () => authController.showLogoutPopup(context),
                    ),
                ]
              : null,
        ),
        drawer: !isWeb
            ? Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      decoration: const BoxDecoration(
                        color: Palette.orange,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(
                              'https://via.placeholder.com/150',
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            box.read("email") ?? "User Email",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.home),
                      title: const Text('Home'),
                      onTap: () => controller.changeTabIndex(0),
                    ),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('My Blogs'),
                      onTap: () => controller.changeTabIndex(1),
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text('Logout'),
                      onTap: () => authController.showLogoutPopup(context),
                    ),
                  ],
                ),
              )
            : null,
        body: screens[controller.currentIndex.value],
        bottomNavigationBar: isWeb
            ? null
            : BottomNavigationBar(
                currentIndex: controller.currentIndex.value,
                onTap: controller.changeTabIndex,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'All Blogs',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'My Blogs',
                  ),
                ],
              ),
      );
    });
  }
}
