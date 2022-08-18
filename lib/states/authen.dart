import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teeappfriend/models/user_model.dart';
import 'package:teeappfriend/states/create_account.dart';
import 'package:teeappfriend/utility/my_constant.dart';
import 'package:teeappfriend/utility/my_dialog.dart';
import 'package:teeappfriend/widgets/show_button.dart';
import 'package:teeappfriend/widgets/show_form.dart';
import 'package:teeappfriend/widgets/show_image.dart';
import 'package:teeappfriend/widgets/show_text.dart';

class Authen extends StatefulWidget {
  const Authen({super.key});

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  String? user, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constants) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
          child: Container(
            decoration: MyConstant().basicBox(),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  logoAndTitle(constants),
                  userForm(constants),
                  passwordForm(constants),
                  newButton(context: context),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Container newButton({required BuildContext context}) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ShowButton(
            label: 'SignIn',
            pressFunc: () {
              if ((user?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
                MyDialog(context: context).normalDialog(
                    title: 'มีช่องว่างนะคะ', subTitle: 'กรุณากรอกให้ครบนะคะ');
              } else {
                processAuthen();
              }
            },
          ),
          const SizedBox(
            width: 6,
          ),
          ShowButton(
            label: 'SignUp',
            pressFunc: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateAccount(),
                  ));
            },
          )
        ],
      ),
    );
  }

  Container passwordForm(BoxConstraints constants) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      width: constants.maxWidth * 0.55,
      child: ShowForm(
        iconData: Icons.lock_outline,
        obsceu: true,
        hint: 'Password :',
        changeFunc: (String string) {
          password = string.trim();
        },
      ),
    );
  }

  Container userForm(BoxConstraints constants) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      width: constants.maxWidth * 0.55,
      child: ShowForm(
        iconData: Icons.person_outline,
        hint: 'User :',
        changeFunc: (String string) {
          user = string.trim();
        },
      ),
    );
  }

  SizedBox logoAndTitle(BoxConstraints constants) {
    return SizedBox(
      width: constants.maxWidth * .6,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            width: constants.maxWidth * .12,
            child: ShowImage(),
          ),
          ShowText(
            text: 'Login',
            textStyle: MyConstant().h1Style(),
          ),
        ],
      ),
    );
  }

  Future<void> processAuthen() async {
    String path =
        'https://www.androidthai.in.th/fluttertraining/getUserWhereUserTee.php?isAdd=true&user=$user';
    await Dio().get(path).then((value) {
      if (value.toString() == 'null') {
        MyDialog(context: context).normalDialog(
            title: 'ไม่มี $user ในระบบ',
            subTitle: 'ไม่มีชื่อ $user นี้ในระบบฐานข้อมูลนะคะ');
      } else {
        print('value ==> $value');

        var result = json.decode(value.data);
        print('New Value ==> $result');

        for (var element in result) {
          UserModel userModel = UserModel.fromMap(element);
          if (password == userModel.password) {
            // True Password

            processSaveUser(userModel: userModel);
          } else {
            //Wrong Password
            MyDialog(context: context).normalDialog(
                title: 'รหัสผ่านผิดนะคะ', subTitle: 'กรุณาลองใหม่อีกครั้งนะคะ');
          }
        }
      }
    });
  }

  Future<void> processSaveUser({required UserModel userModel}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('id', userModel.id);
    sharedPreferences.setString('name', userModel.name);
    sharedPreferences.setString('avatar', userModel.avatar);
    sharedPreferences.setString('token', userModel.token);

    Navigator.pushNamedAndRemoveUntil(
        context, '/listAllMember', (route) => false);
  }
}
