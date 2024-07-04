import 'dart:convert';
import 'dart:io';
import 'package:crm/controller/general_controller.dart';
import 'package:crm/controller/site_controller.dart';
import 'package:crm/model/photo_model.dart';
import 'package:crm/utility/api.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class PhotosController extends GetxController {
  static PhotosController get to => Get.find();

  Rx<PhotoModel> photoModel = PhotoModel().obs;
  final ImagePicker _picker = ImagePicker();

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

  Future<void> addPhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      File photoFile = File(photo.path);
      var request = http.MultipartRequest('POST', Uri.parse(sitePhotos));
      request.files
          .add(await http.MultipartFile.fromPath('site_photo', photoFile.path));
      request.fields['site_id'] = SiteController.to.sites.value.sites == null
          ? ""
          : SiteController.to.sites.value.sites!.first.siteId.toString();
      request.fields['date'] =
          GeneralController.to.selectedDate.value.toString().split(" ")[0];

      try {
        var response = await request.send();
        if (response.statusCode == 200) {
          var responseBody = await http.Response.fromStream(response);
          photoModel.value.sitePhotos!
              .add(SitePhoto.fromJson(jsonDecode(responseBody.body)));
          photoModel.refresh();
          Get.snackbar("Success", "Photo uploaded successfully");
        } else {
          Get.snackbar(
              "Error", "Failed to upload photo: ${response.statusCode}");
        }
      } catch (e) {
        Get.snackbar("Error", e.toString());
      }
    } else {
      Get.snackbar("Error", "No photo selected");
    }
  }
}
