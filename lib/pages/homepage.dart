import 'package:coupon/components/choice_dialog.dart';
import 'package:coupon/components/custom_dialog.dart';
import 'package:coupon/components/my_button.dart';
import 'package:coupon/components/my_textfield.dart';
import 'package:coupon/components/notice_dialog.dart';
import 'package:coupon/components/textspeech.dart';
import 'package:coupon/pages/management.dart';
import 'package:coupon/pages/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> items = [];
  final TextEditingController codeController = TextEditingController();
  late SharedPreferences _prefs;
  final FlutterTts tts = FlutterTts();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initSharedPreferences();
  }

  void speech(String text) {
    tts.setLanguage("en-US");
    tts.setSpeechRate(0.4);
    tts.speak(text);
  }

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> _saveDAta() async {
    await _prefs.setStringList('items', []);
    // _prefs.setString('myData', codeController.text);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Saved")));
  }

  Future<void> _submit(String text) async {
    DateTime now = DateTime.now();

    items = _prefs.getStringList('items') ?? [];
    items.add("$now    $text   code : ${codeController.text}");
    await _prefs.setStringList('items', items);
  }

  Future<void> _loadData(String code) async {
    // List<String>? myData = _prefs.getStringList('items');
    final String data2 = _prefs.getString(code) ?? "";
    items = _prefs.getStringList('items') ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 200,
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext ctx, int idx) {
                  return Text(
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                      items[idx]);
                }),
          ),
          const SizedBox(
            height: 100,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: 300,
                child: MyTextField(
                    controller: codeController,
                    hintText: "hi",
                    obscureText: false),
              ),
              const SizedBox(
                width: 20,
              ),
              MyButton(
                  text: 'check',
                  onTap: () {
                    // NoticeDialog(
                    //   text: 'hi',
                    // );
                    final String data2 =
                        _prefs.getString(codeController.text) ?? "no";
                    // if (data2 == "") {
                    //   return NoticeDialog(text: "no data");
                    // }

                    // ScaffoldMessenger.of(context)
                    //     .showSnackBar(SnackBar(content: Text(data2)));

                    if (data2 == "no") {
                      speech('Coupon number not found.');
                      showDialog(
                          context: context,
                          builder: (context) {
                            return NoticeDialog(
                                text: "Coupon number not found.");
                          });
                    } else {
                      speech('Would you like to use the $data2 coupon?');
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return ChoiceDialog(
                                onTap: () {
                                  _submit(data2);
                                  _loadData(codeController.text);
                                  setState(() {});
                                  Navigator.pop(context);
                                  codeController.text = "";
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return NoticeDialog(text: " Done!");
                                      });
                                },
                                text:
                                    'Would you like to use the $data2 coupon?');
                          });
                    }
                  })
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyButton(
                  text: ('admin'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ManagementPage()));
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
