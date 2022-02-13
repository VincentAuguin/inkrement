import 'package:flutter/material.dart';

class NoContent extends StatelessWidget {
  const NoContent(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("🤷‍♂️"),
        const SizedBox(
          height: 4,
        ),
        Text(text)
      ],
    );
  }
}
