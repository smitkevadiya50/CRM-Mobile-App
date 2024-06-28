import 'package:crm/controller/general_controller.dart';
import 'package:crm/controller/photos_controller.dart';
import 'package:crm/controller/site_controller.dart';
import 'package:get/instance_manager.dart';

class GetXBindingController extends Bindings {
  @override
  void dependencies() {
    Get.put<GeneralController>(GeneralController());
    Get.put<SiteController>(SiteController());
    Get.put<PhotosController>(PhotosController());
  }
}
