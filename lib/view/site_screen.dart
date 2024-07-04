import 'package:crm/controller/site_controller.dart';
import 'package:crm/view/calendar_screen.dart';
import 'package:crm/widget/site_list_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../model/SiteModel.dart';

class SiteScreen extends StatelessWidget {
  const SiteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Site"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
                onTap: () {
                  SiteController.to.fetchSites();
                },
                child: const Icon(Icons.refresh_rounded)),
          )
        ],
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
              () => SiteController.to.sites.value.sites == null ||
                      SiteController.to.sites.value.sites!.isEmpty
                  ? const Center(
                      child: Text('No sites available'),
                    )
                  : Obx(
                      () => ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: SiteController.to.sites.value.sites == null
                            ? 0
                            : SiteController.to.sites.value.sites?.length,
                        itemBuilder: (context, index) {
                          final site =
                              SiteController.to.sites.value.sites![index];
                          List<Manager> combinedList = [
                            ...site.worker as Iterable<Manager>,
                            ...site.helper as Iterable<Manager>
                          ];
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
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.brown,
                                      backgroundImage: NetworkImage(
                                          site.siteLogo.toString(),
                                          scale: 1.0),
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
                                                text:
                                                    site.ownerNumber.toString(),
                                                title: "Owner number"),
                                            siteListItems(
                                                text: site.manager!.name
                                                    .toString(),
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
                                Column(
                                  children:
                                      combinedList.asMap().entries.map((entry) {
                                    Manager workers = entry.value;
                                    int empIndex = entry.key;
                                    return Obx(
                                      () => Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: SiteController
                                                      .to.isShowMoreSite
                                                      .contains(index)
                                                  ? 10
                                                  : 0),
                                          child: SiteController
                                                  .to.isShowMoreSite
                                                  .contains(index)
                                              ? Row(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 20,
                                                      backgroundImage:
                                                          NetworkImage(
                                                              workers.photo
                                                                  .toString(),
                                                              scale: 1.0),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              workers.name ??
                                                                  "",
                                                              style: const TextStyle(
                                                                  color: Color(
                                                                      0xff122569),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                          Text(
                                                              site.worker!.length >
                                                                      empIndex
                                                                  ? "Worker"
                                                                  : "Helper",
                                                              style: const TextStyle(
                                                                  color: Color(
                                                                      0xff122569),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                        ],
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    Row(
                                                      children: [
                                                        siteListItems(
                                                            title: "Check In",
                                                            text: workers
                                                                        .attendance ==
                                                                    null
                                                                ? "--:--"
                                                                : workers
                                                                        .attendance!
                                                                        .startTime ??
                                                                    ""),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        siteListItems(
                                                            title: "Check out",
                                                            text: workers
                                                                        .attendance ==
                                                                    null
                                                                ? "--:--"
                                                                : workers
                                                                        .attendance!
                                                                        .endTime ??
                                                                    ""),
                                                      ],
                                                    )
                                                  ],
                                                )
                                              : null),
                                    );
                                  }).toList(),
                                ),
                                SizedBox(height: width * 0.02),
                                Obx(
                                  () => TextButton(
                                    onPressed: () {
                                      SiteController.to.toggleShowMore(index);
                                    },
                                    child: SiteController.to.isShowMoreSite
                                            .contains(index)
                                        ? const Text(
                                            'Show less',
                                            style:
                                                TextStyle(color: Colors.purple),
                                          )
                                        : const Text(
                                            'Show in detail',
                                            style:
                                                TextStyle(color: Colors.purple),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
