import 'package:flutter/material.dart';

class ChoiceDialog extends StatelessWidget {
  void Function()? onTap;
  String text;

  ChoiceDialog({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(text),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: onTap, child: const Text('YES')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('NO'))
            ],
          ),
          const SizedBox(
            height: 20,
          )
        ],
      )),
    );
  }
}
