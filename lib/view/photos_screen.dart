import 'package:crm/controller/photos_controller.dart';
import 'package:crm/controller/site_controller.dart';
import 'package:crm/view/calendar_screen.dart';
import 'package:crm/widget/site_list_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhotosScreen extends StatelessWidget {
  const PhotosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Photos"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: () {
                PhotosController.to.getSitePhotos();
              },
              child: const Icon(Icons.refresh_rounded),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: width * 0.02),
          child: Column(
            children: [
              const CalendarScreen(),
              SizedBox(height: height * 0.02),
              GestureDetector(
                  onTap: () {},
                  child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.blue[700]),
                      child: const Text(
                        "Add Photo",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 14),
                      ))),
              SizedBox(
                height: height * 0.02,
              ),
              SiteController.to.sites.value.sites!.isEmpty
                  ? const Center(
                      child: Text("No Site's found"),
                    )
                  : Row(
                      children: [
                        siteListItems(
                            title: "Site Name",
                            text: SiteController
                                .to.sites.value.sites!.first.siteName
                                .toString()),
                        const Spacer(),
                        siteListItems(
                            title: "Location",
                            text: SiteController
                                .to.sites.value.sites!.first.siteLocation
                                .toString()),
                        const Spacer()
                      ],
                    ),
              Obx(() => PhotosController.to.photoModel.value.sitePhotos!.isEmpty
                  ? const Center(child: Text("No Photo's Uploaded"))
                  : GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 40.0,
                        mainAxisSpacing: 40.0,
                      ),
                      itemCount:
                          PhotosController.to.photoModel.value.sitePhotos !=
                                  null
                              ? PhotosController
                                  .to.photoModel.value.sitePhotos?.length
                              : 0,
                      itemBuilder: (context, index) {
                        return Container(
                            decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(12)),
                            child: Image.network(
                              PhotosController
                                  .to.photoModel.value.sitePhotos![index].url
                                  .toString(),
                              fit: BoxFit.fill,
                            ));
                      },
                    ))
            ],
          )),
    );
  }
}
