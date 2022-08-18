// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:teeappfriend/utility/my_constant.dart';
import 'package:teeappfriend/widgets/show_image.dart';
import 'package:teeappfriend/widgets/show_text.dart';
import 'package:teeappfriend/widgets/show_text_button.dart';

class MyDialog {
  final BuildContext context;
  MyDialog({
    required this.context,
  });

  void normalDialog({
    required String title,
    required String subTitle,
    String? label,
    Function()? pressFunc,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: SizedBox(width: 80, child: ShowImage()),
          title: ShowText(
            text: title,
            textStyle: MyConstant().h2Style(),
          ),
          subtitle: ShowText(text: subTitle),
        ),
        actions: [
          label == null
              ? const SizedBox()
              : ShowTextButton(label: label, pressFunc: pressFunc!),
          ShowTextButton(
            label: label == null ? 'ตกลง' : 'ยกเลิก',
            pressFunc: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
