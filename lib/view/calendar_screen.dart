import 'package:crm/controller/general_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Obx(() {
      DateTime start = GeneralController.to.startDate.value;
      return Column(
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
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_left),
                      onPressed: () => GeneralController.to.moveDateRange(-7),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(7, (index) {
                        DateTime date = start.add(Duration(days: index));
                        bool isSelected =
                            DateFormat('yyyy-MM-dd').format(date) ==
                                DateFormat('yyyy-MM-dd').format(
                                    GeneralController.to.selectedDate.value);
                        return GestureDetector(
                          onTap: () =>
                              GeneralController.to.updateSelectedDate(date),
                          child: Column(
                            children: [
                              Text(
                                DateFormat('E').format(date),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? Colors.purple
                                        : Colors.black),
                              ),
                              const SizedBox(height: 4),
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: CircleAvatar(
                                  radius: 18,
                                  backgroundColor: isSelected
                                      ? Colors.purple
                                      : Colors.grey.shade200,
                                  child: Text(
                                    '${date.day}',
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_right),
                      onPressed: () => GeneralController.to.moveDateRange(7),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
