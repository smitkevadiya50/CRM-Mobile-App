import 'package:crm/get_binding.dart';
import 'package:crm/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/attendance_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AttendanceController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: GetXBindingController(),
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
