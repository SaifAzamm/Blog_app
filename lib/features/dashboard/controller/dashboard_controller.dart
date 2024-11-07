import 'package:get/get.dart';

class DashboardController extends GetxController {
  var currentIndex = 0.obs; // Tracks the current tab index

  void changeTabIndex(int index) {
    currentIndex.value = index;
  }
}
