import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

import '../controller/attendance_controller.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Attendance'),
      ),
      body: FutureBuilder<void>(
        future: AttendanceController.to.initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Obx(() {
                    final path =
                        AttendanceController.to.capturedImagePath.value;
                    if (path.isEmpty) {
                      return CameraPreview(
                          AttendanceController.to.cameraController);
                    } else {
                      return Image.file(File(path));
                    }
                  }),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        AttendanceController.to.captureImage();
                      },
                      child: const Text('Capture Image'),
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
