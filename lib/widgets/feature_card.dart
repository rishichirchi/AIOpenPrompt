import 'package:ai_app/pallete.dart';
import 'package:flutter/material.dart';

class FeatureCard extends StatelessWidget {
  final Color color;
  final String headerText;
  const FeatureCard({super.key, required this.color, required this.headerText});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: color,
      ),
      child: Column(children: [
        Text(headerText, style: const TextStyle(color: Pallete.blackColor, fontSize: 18, fontFamily: 'Cera Pro', fontWeight: FontWeight.bold),),
      ]),
    );
  }
}
