import 'dart:convert';

import 'package:crm/controller/general_controller.dart';
import 'package:crm/controller/site_controller.dart';
import 'package:crm/model/photo_model.dart';
import 'package:crm/utility/api.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PhotosController extends GetxController {
  static PhotosController get to => Get.find();

  Rx<PhotoModel> photoModel = PhotoModel().obs;

  getSitePhotos() async {
    var date = GeneralController.to.selectedDate.value.toString().split(" ")[0];
    var url = Uri.parse(
        '$sitePhotos?site_id=${SiteController.to.sites.value.sites == null ? "" : SiteController.to.sites.value.sites!.first.siteId.toString()}&date=$date');
    try {
      var response = await http.get(url);
      photoModel.value = PhotoModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      Get.snackbar("Eror", e.toString());
    }
  }
}
