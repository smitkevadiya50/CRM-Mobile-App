import 'package:crm/view/calendar_screen.dart';
import 'package:crm/widget/site_list_items.dart';
import 'package:flutter/material.dart';

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
              Row(
                children: [
                  siteListItems(title: "Site Name", text: "Krishna"),
                  const Spacer(),
                  siteListItems(title: "Location", text: "Katargam"),
                  const Spacer()
                ],
              ),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 40.0,
                  mainAxisSpacing: 40.0,
                ),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style:
                            const TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ),
                  );
                },
              )
            ],
          )),
    );
  }
}
