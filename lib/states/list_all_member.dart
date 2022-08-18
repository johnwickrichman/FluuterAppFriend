import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teeappfriend/utility/my_constant.dart';
import 'package:teeappfriend/utility/my_dialog.dart';
import 'package:teeappfriend/widgets/show_icon_button.dart';
import 'package:teeappfriend/widgets/show_text.dart';

class ListAllMember extends StatefulWidget {
  const ListAllMember({super.key});

  @override
  State<ListAllMember> createState() => _ListAllMemberState();
}

class _ListAllMemberState extends State<ListAllMember> {
  @override
  void initState() {
    super.initState();
    setUpNoti();
  }

  Future<void> setUpNoti() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    String? token = await firebaseMessaging.getToken();
    print('token ==> $token');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          ShowIconButton(
            iconData: Icons.exit_to_app,
            pressFunc: () {
              MyDialog(context: context).normalDialog(
                  label: 'ออกจากระบบ',
                  pressFunc: (() {
                    processSignOut(context: context);
                  }),
                  title: 'คุณต้องการ Logout จริงๆใช่มั้ย',
                  subTitle: 'ชัวร์นะคะ');
            },
          )
        ],
        centerTitle: true,
        title: ShowText(
          text: 'รายการสมาชิกทั้งหมด',
          textStyle: MyConstant().h2Style(),
        ),
      ),
    );
  }

  Future<void> processSignOut({required BuildContext context}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear().then((value) {
      Navigator.pushNamedAndRemoveUntil(context, '/authen', (route) => false);
    });
  }
}
