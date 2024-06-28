import 'package:crm/model/employee.dart';
import 'package:crm/model/side.dart';
import 'package:get/get.dart';

class SiteController extends GetxController {
  static SiteController get to => Get.find();
  var selectedDate = DateTime.now().obs;
  var startDate = DateTime.now().subtract(const Duration(days: 3)).obs;
  RxList isShowMoreSite = [0].obs;

  var sites = <Site>[].obs;
  var employee = <Employee>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchSites();
  }

  void fetchSites() {
    sites.assignAll([
      Site(
          ownerName: 'Shruti',
          ownerNumber: '+91 98765 43210',
          supervisorName: 'Supervisor Name',
          managerName: 'Manager Name',
          numWorkers: '25/30',
          numHelpers: '05/20'),
      Site(
        ownerName: 'Shruti',
        ownerNumber: '+91 98765 43210',
        supervisorName: 'Supervisor Name',
        managerName: 'Manager Name',
        numWorkers: '30',
        numHelpers: '05',
      ),
    ]);

    employee.assignAll([
      Employee(
          empName: "Smit",
          empNumber: "34365476575",
          empCategory: "Worker",
          checkIn: "10:00 AM",
          checkout: "18:00 PM"),
      Employee(
          empName: "Yash",
          empNumber: "34365476575",
          empCategory: "Helper",
          checkIn: "10:00 AM",
          checkout: "18:00 PM"),
      Employee(
          empName: "harsh",
          empNumber: "34365476575",
          empCategory: "Manager",
          checkIn: "10:00 AM",
          checkout: "18:00 PM")
    ]);
  }

  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
  }

  void moveDateRange(int days) {
    startDate.value = startDate.value.add(Duration(days: days));
  }
}
