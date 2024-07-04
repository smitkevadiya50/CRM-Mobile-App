import 'dart:convert';
import 'package:crm/controller/general_controller.dart';
import 'package:crm/model/SiteModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SiteController extends GetxController {
  static SiteController get to => Get.find();

  var isShowMoreSite = <int>[].obs;
  Rx<SiteModel> sites = SiteModel().obs;

  @override
  void onInit() {
    super.onInit();
    fetchSites();
  }

  void fetchSites() async {
    String currentDate =
        GeneralController.to.selectedDate.value.toString().split(" ")[0];
    var url = Uri.parse(
        'http://127.0.0.1:3001/site/get-site-by-manager?managerId=667746d80c6c6f5cb1c1c0fe&date=$currentDate');
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        sites.value = SiteModel.fromJson(jsonDecode(response.body));
      } else {
        // Handle other status codes if needed
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network errors or exceptions
      print('Exception occured: $e');
    }
  }

  void toggleShowMore(int index) {
    if (isShowMoreSite.contains(index)) {
      isShowMoreSite.remove(index);
      print('Removed index: $index');
    } else {
      isShowMoreSite.add(index);
      print('Added index: $index');
    }
  }
}
