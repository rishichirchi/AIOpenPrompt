import 'package:ai_app/pallete.dart';
import 'package:ai_app/widgets/feature_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Virtual Assistant'),
        leading: const Icon(Icons.menu),
        centerTitle: true,
      ),
      body: Column(
        //Avatar
        children: [
          Stack(
            children: [
              Center(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Pallete.assistantCircleColor,
                      shape: BoxShape.circle),
                  height: 120,
                  width: 120,
                  margin: const EdgeInsets.only(top: 4),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/virtualAssistant.png'),
                  ),
                ),
                height: 123,
              ),
            ],
          ),
          //Message
          Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 40).copyWith(top: 30),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              border: Border.all(color: Pallete.borderColor),
              borderRadius:
                  BorderRadius.circular(20).copyWith(topLeft: Radius.zero),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                "Good Morning! What can I do for you?",
                style: TextStyle(
                  color: Pallete.mainFontColor,
                  fontSize: 25,
                  fontFamily: 'Cera Pro',
                ),
              ),
            ),
          ),
          //Suggestions list
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(top: 10, left: 22),
            child: const Text(
              'Here are a few commands',
              style: TextStyle(
                  color: Pallete.mainFontColor,
                  fontSize: 20,
                  fontFamily: 'Cera Pro',
                  fontWeight: FontWeight.bold),
            ),
          ),
          //features list
          const Column(
            children: [
              FeatureCard(color: Pallete.firstSuggestionBoxColor, headerText:'Chat GPT'),
            ],
          )
        ],
      ),
    );
  }
}
