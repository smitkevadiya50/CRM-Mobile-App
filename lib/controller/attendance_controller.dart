import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AttendanceController extends GetxController {
  static AttendanceController get to => Get.find();

  late CameraController cameraController;
  Future<void>? initializeControllerFuture;
  var capturedImagePath = ''.obs;
  var camerasAvailable = false.obs;

  @override
  void onInit() {
    super.onInit();
    initializeCamera();
  }

  void initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      final firstCamera = cameras.first;

      cameraController = CameraController(
        firstCamera,
        ResolutionPreset.high,
      );
      initializeControllerFuture = cameraController.initialize();
      camerasAvailable.value = true;
    } else {
      camerasAvailable.value = false;
    }
    update();
  }

  @override
  void onClose() {
    cameraController.dispose();
    super.onClose();
  }

  Future<void> captureImage() async {
    await initializeControllerFuture;

    final XFile image = await cameraController.takePicture();

    capturedImagePath.value = image.path;

    // Upload the image
    await uploadImage(image.path);
  }

  Future<void> uploadImage(String imagePath) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://127.0.0.1:5000/detect'));
      request.files.add(await http.MultipartFile.fromPath('image', imagePath));

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var jsonResponse = jsonDecode(responseData);
        if (jsonResponse['message'] != null) {
          Get.snackbar('Response', jsonResponse['message']);
        } else {
          Get.snackbar('Error', 'No message in response');
        }
      } else {
        Get.snackbar('Error', 'Failed to upload image');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while uploading the image');
    }
  }
}
