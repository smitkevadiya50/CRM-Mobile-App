import 'package:crm/controller/site_controller.dart';
import 'package:crm/model/employee.dart';
import 'package:crm/model/side.dart';
import 'package:crm/view/calendar_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SiteScreen extends StatelessWidget {
  final SiteController controller = SiteController.to;

  SiteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: width * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.02,
            ),
            const Text(
              "Calendar",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            CalendarScreen(controller: controller),
            SizedBox(
              height: height * 0.03,
            ),
            const Text(
              "Site List",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SiteListWidget(controller: controller),
          ],
        ),
      ),
    );
  }
}

class SiteListWidget extends StatelessWidget {
  final SiteController controller;

  const SiteListWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Obx(() {
      return Column(
        children: controller.sites.asMap().entries.map((entry) {
          int index = entry.key;
          Site site = entry.value;
          return Container(
            padding: EdgeInsets.all(width * 0.03),
            margin: EdgeInsets.only(top: width * 0.02),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.brown,
                    ),
                    SizedBox(width: width * 0.03),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Site Name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('Location', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: width * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            siteListItems(
                                text: site.ownerName, title: "Owner name"),
                            siteListItems(
                                text: site.supervisorName, title: "Supervisor"),
                            siteListItems(
                                text: site.numWorkers, title: "No. of Worker"),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            siteListItems(
                                text: site.ownerNumber, title: "Owner number"),
                            siteListItems(
                                text: site.managerName, title: "Manager"),
                            siteListItems(
                                text: site.numHelpers, title: "No. of Helper"),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: width * 0.02),
                if (controller.isShowMoreSite.contains(index))
                  Column(
                    children: controller.employee.asMap().entries.map((entry) {
                      Employee site = entry.value;
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.brown,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(site.empName,
                                      style: const TextStyle(
                                          color: Color(0xff122569),
                                          fontWeight: FontWeight.w600)),
                                  Text(site.empCategory,
                                      style: const TextStyle(
                                          color: Color(0xff122569),
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                siteListItems(
                                    title: "Check In", text: site.checkIn),
                                const SizedBox(
                                  width: 10,
                                ),
                                siteListItems(
                                    title: "Check out", text: site.checkout),
                              ],
                            )
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                SizedBox(height: width * 0.02),
                TextButton(
                  onPressed: () {
                    if (controller.isShowMoreSite.contains(index)) {
                      controller.isShowMoreSite.remove(index);
                    } else {
                      controller.isShowMoreSite.add(index);
                    }
                  },
                  child: controller.isShowMoreSite.contains(index)
                      ? const Text(
                          'Show less',
                          style: TextStyle(color: Colors.purple),
                        )
                      : const Text(
                          'Show in detail',
                          style: TextStyle(color: Colors.purple),
                        ),
                ),
              ],
            ),
          );
        }).toList(),
      );
    });
  }
}

Widget siteListItems({required String title, required String text}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: Color(0xff7581AA)),
        ),
        Text(
          text,
          style: const TextStyle(
              color: Color(0xff122569), fontWeight: FontWeight.w600),
        ),
      ],
    ),
  );
}
