import 'package:crm/controller/general_controller.dart';
import 'package:crm/view/attendance_screen.dart';
import 'package:crm/view/photos_screen.dart';
import 'package:crm/view/settings_screen.dart';
import 'package:crm/view/site_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        // Switch between different widgets based on the selected index
        switch (GeneralController.to.selectedIndex.value) {
          case 0:
            return const SiteScreen();
          case 1:
            return const AttendanceScreen();
          case 2:
            return const PhotosScreen();
          case 3:
            return const SettingsScreen();
          default:
            return const SiteScreen();
        }
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          fixedColor: Colors.indigo,
          unselectedItemColor: Colors.black45,
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
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        );
      }),
    );
  }
}
