import 'package:flutter/material.dart';

class TopGenre extends StatelessWidget {
  final int index;
  final String text;
  const TopGenre(this.index, this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.accents[index],
        borderRadius: BorderRadius.circular(10),
      ),
      width: 80,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(4),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
