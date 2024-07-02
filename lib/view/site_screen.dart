import 'package:crm/controller/site_controller.dart';
import 'package:crm/view/calendar_screen.dart';
import 'package:crm/widget/site_list_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/SiteModel.dart';

class SiteScreen extends StatelessWidget {
  const SiteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final sites = SiteController.to.sites.value.sites;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Site"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: width * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CalendarScreen(),
            SizedBox(
              height: height * 0.03,
            ),
            const Text(
              "Site List",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Obx(
              () => sites == null || sites.isEmpty
                  ? const Center(
                      child: Text('No sites available'),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: SiteController.to.sites.value.sites == null
                          ? 0
                          : SiteController.to.sites.value.sites?.length,
                      itemBuilder: (context, index) {
                        final site = sites[index];
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
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        site.siteName.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(site.siteLocation.toString(),
                                          style: const TextStyle(
                                              color: Colors.grey)),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: width * 0.02),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          siteListItems(
                                              text: site.ownerName.toString(),
                                              title: "Owner name"),
                                          siteListItems(
                                              text: site.supervisor!.name
                                                  .toString(),
                                              title: "Supervisor"),
                                          siteListItems(
                                              text: site.worker!.length
                                                  .toString(),
                                              title: "No. of Worker"),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          siteListItems(
                                              text: site.ownerNumber.toString(),
                                              title: "Owner number"),
                                          siteListItems(
                                              text:
                                                  site.manager!.name.toString(),
                                              title: "Manager"),
                                          siteListItems(
                                              text: site.helper!.length
                                                  .toString(),
                                              title: "No. of Helper"),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: width * 0.02),
                              if (SiteController.to.isShowMoreSite
                                  .contains(index))
                                Column(
                                  children:
                                      site.worker!.asMap().entries.map((entry) {
                                    Manager workers = entry.value;
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Row(
                                        children: [
                                          const CircleAvatar(
                                            radius: 20,
                                            backgroundColor: Colors.brown,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(workers.name ?? "",
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xff122569),
                                                        fontWeight:
                                                            FontWeight.w600)),
                                                Text(workers.name ?? "",
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xff122569),
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ],
                                            ),
                                          ),
                                          const Spacer(),
                                          Row(
                                            children: [
                                              siteListItems(
                                                  title: "Check In",
                                                  text: workers.name ?? ""),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              siteListItems(
                                                  title: "Check out",
                                                  text: workers.name ?? ""),
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
                                  SiteController.to.toggleShowMore(index);
                                },
                                child: SiteController.to.isShowMoreSite
                                        .contains(index)
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
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
