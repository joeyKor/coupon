import 'package:coupon/components/custom_dialog.dart';
import 'package:coupon/components/my_button.dart';
import 'package:coupon/components/my_textfield.dart';
import 'package:coupon/components/notice_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManagementPage extends StatelessWidget {
  late SharedPreferences _prefs;

  final TextEditingController codeController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  ManagementPage({super.key});

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  //  Future<void> _saveDAta() async {
  //   // await _prefs.setStringList('items', []);
  //   _prefs.setString('myData', codeController.text);

  // }

  @override
  Widget build(BuildContext context) {
    _initSharedPreferences();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              const Text(
                "c o d e ",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(
                width: 300,
                child: MyTextField(
                    controller: codeController,
                    hintText: "code",
                    obscureText: false),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              const Text(
                "content",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(
                width: 300,
                child: MyTextField(
                    controller: contentController,
                    hintText: "content",
                    obscureText: false),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          MyButton(
              text: "Regist",
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      if (codeController.text == "" ||
                          contentController.text == "") {
                        return NoticeDialog(
                          text: 'Please enter both code and content',
                        );
                      }

                      return CustomDialog(
                        onTap: () {
                          _prefs.setString(
                              codeController.text, contentController.text);
                          Navigator.pop(context);
                          codeController.text = "";
                          contentController.text = "";
                          showDialog(
                              context: context,
                              builder: (context) {
                                return NoticeDialog(text: "Coupon Added");
                              });

                          // Navigator.pop(context);
                        },
                        code: codeController.text,
                        Content: contentController.text,
                      );
                    });
              }),
          const SizedBox(
            height: 50,
          ),
          MyButton(
              text: "Home",
              onTap: () {
                Navigator.pop(context);
              })
        ],
      ),
    );
  }
}
