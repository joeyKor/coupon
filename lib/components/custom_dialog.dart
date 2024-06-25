import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  void Function()? onTap;
  String code;
  String Content;

  CustomDialog(
      {super.key,
      required this.code,
      required this.Content,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff2a303e),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(width: 100, height: 100, 'lib/assets/coupon.png'),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  code,
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 24,
                ),
                Text(
                  Content,
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 32),
                        foregroundColor: const Color(0xffec5b5b),
                        side: const BorderSide(color: Color(0xffec5b5b))),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("cancel")),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 32),
                        backgroundColor: const Color(0xff5bec84),
                        foregroundColor: const Color(0xff2a303e)),
                    onPressed: onTap,
                    child: const Text('yes'))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
