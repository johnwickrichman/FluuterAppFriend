// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:teeappfriend/utility/my_constant.dart';

class ShowForm extends StatelessWidget {
  final String hint;
  final bool? obsceu;
  final IconData? iconData;
  final Function(String) changeFunc;

  const ShowForm({
    Key? key,
    required this.hint,
    this.obsceu,
    this.iconData,
    required this.changeFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextFormField(
        onChanged: changeFunc,
        obscureText: obsceu ?? false,
        decoration: InputDecoration(
          suffixIcon: iconData == null ? const SizedBox() : Icon(iconData),
          filled: true,
          fillColor: Colors.white.withOpacity(0.75),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          hintText: hint,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: MyConstant.dark)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: MyConstant.active)),
        ),
      ),
    );
  }
}
