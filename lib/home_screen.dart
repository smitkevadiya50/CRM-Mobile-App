import 'package:crm/controller/general_controller.dart';
import 'package:crm/view/attendance_screen.dart';
import 'package:crm/view/photos_screen.dart';
import 'package:crm/view/site_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Employee Verification'),
      ),
      body: Obx(() {
        // Switch between different widgets based on the selected index
        switch (GeneralController.to.selectedIndex.value) {
          case 0:
            return SiteScreen();
          case 1:
            return const AttendanceScreen();
          case 2:
            return const PhotosScreen();
          default:
            return const Center(child: Text('Home'));
        }
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: GeneralController.to.selectedIndex.value,
          onTap: GeneralController.to.changeIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.apartment_outlined),
              label: 'Site',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timeline_rounded),
              label: 'Attendance',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.photo_outlined),
              label: 'Photos',
            ),
          ],
        );
      }),
    );
  }
}
