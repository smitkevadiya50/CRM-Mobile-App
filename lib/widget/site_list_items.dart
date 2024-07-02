import 'package:flutter/material.dart';

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
