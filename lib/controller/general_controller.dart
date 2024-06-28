import 'package:get/get.dart';

class GeneralController extends GetxController {
  static GeneralController get to => Get.find();

  RxInt selectedIndex = 1.obs;

  // Function to change the selected index
  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
