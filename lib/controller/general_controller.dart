import 'package:get/get.dart';

class GeneralController extends GetxController {
  static GeneralController get to => Get.find();

  RxInt selectedIndex = 1.obs;

  var selectedDate = DateTime.now().obs;
  var startDate = DateTime.now().subtract(const Duration(days: 3)).obs;

  // Function to change the selected index
  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
  }

  void moveDateRange(int days) {
    startDate.value = startDate.value.add(Duration(days: days));
  }
}
