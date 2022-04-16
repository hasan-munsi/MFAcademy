import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mf_academy/globals/xarvis.dart';
class DatePickDialogue extends StatefulWidget {
  const DatePickDialogue({Key? key}) : super(key: key);

  @override
  State<DatePickDialogue> createState() => _DatePickDialogueState();
}

class _DatePickDialogueState extends State<DatePickDialogue> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: Get.width*0.9,
          height: Get.height*0.6,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Xarvis.fair,
            borderRadius: BorderRadius.circular(5),
          ),
          child: DateRangePickerDialog(
            firstDate: DateTime(2000),
            lastDate: DateTime.now(),
          ),
        ),
      ),
    );
  }
}
