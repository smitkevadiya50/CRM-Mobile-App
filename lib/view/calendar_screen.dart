import 'package:crm/controller/site_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatelessWidget {
  final SiteController controller;

  const CalendarScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      DateTime start = controller.startDate.value;
      return Container(
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
                  onPressed: () => controller.moveDateRange(-7),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(7, (index) {
                    DateTime date = start.add(Duration(days: index));
                    bool isSelected = DateFormat('yyyy-MM-dd').format(date) ==
                        DateFormat('yyyy-MM-dd')
                            .format(controller.selectedDate.value);
                    return GestureDetector(
                      onTap: () => controller.updateSelectedDate(date),
                      child: Column(
                        children: [
                          Text(
                            DateFormat('E').format(date),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color:
                                    isSelected ? Colors.purple : Colors.black),
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
                                  color:
                                      isSelected ? Colors.white : Colors.black,
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
                  onPressed: () => controller.moveDateRange(7),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
