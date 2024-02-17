import 'package:ai_app/pallete.dart';
import 'package:ai_app/service/openai_service.dart';
import 'package:ai_app/widgets/feature_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  final SpeechToText speechToText = SpeechToText();
  final OpenAIService openAIService = OpenAIService();
  final FlutterTts textToSpeech = FlutterTts();

  var speechEnabled = false;
  String wordsSpoken = '';
  String? generatedContent;
  String? generatedImageUrl;

  @override
  void initState() {
    super.initState();
    initSpeechToText();
    initTextToSpeech();
  }

  Future<void> initTextToSpeech() async {
    await textToSpeech.setSharedInstance(true);
    setState(() {});
  }

  Future<void> systemSpeak(String content) async {
    await textToSpeech.speak(content);
    setState(() {});
  }

  Future<void> initSpeechToText() async {
    speechEnabled = await speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      wordsSpoken = result.recognizedWords;
      if (result.finalResult) {//as finalResult return true when the entire sentence has been completed.
        openAIService.isArtPromptAPI(wordsSpoken);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
    textToSpeech.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Virtual Assistant'),
        leading: const Icon(Icons.menu),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
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
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  generatedContent == null?
                  "Good Morning! What can I do for you?": generatedContent!,
                  style:  TextStyle(
                    color: Pallete.mainFontColor,
                    fontSize:generatedContent==null? 25:28,
                    fontFamily: 'Cera Pro',
                  ),
                ),
              ),
            ),
            //Suggestions list
            Visibility(
              visible: generatedContent == null,
              child: Container(
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
            ),
            //features list
            Visibility(
              visible: generatedContent == null,
              child: const Column(
                children: [
                  FeatureCard(
                    color: Pallete.firstSuggestionBoxColor,
                    headerText: 'Chat GPT',
                    descriptionText:
                        'A smarter way to stay organized and informed with ChatGPT',
                  ),
                  FeatureCard(
                    color: Pallete.secondSuggestionBoxColor,
                    headerText: 'Dall-E',
                    descriptionText:
                        'Get inspired and stay creative with your presonal assitant powered by Dall-E',
                  ),
                  FeatureCard(
                    color: Pallete.thirdSuggestionBoxColor,
                    headerText: 'Smart Voice Assistant',
                    descriptionText:
                        'Get the best of both worlds powered by ChatGPT and Dall-E',
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      margin: const EdgeInsets.fromLTRB(10, 10, 3, 5),
                      color: Pallete.firstSuggestionBoxColor,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: wordsSpoken == ''
                            ? const Text('...')
                            : Text(wordsSpoken,
                                style: GoogleFonts.poppins(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  const Gap(5),
                  FloatingActionButton(
                    onPressed: () async {
                      if (await speechToText.hasPermission &&
                          speechToText.isNotListening) {
                        await startListening();
                      } else if (speechToText.isListening) {
                        final speech =
                            await openAIService.isArtPromptAPI(wordsSpoken);
                        if (speech.contains('https')) {
                          generatedImageUrl = speech;
                          generatedContent = null;
                          setState(() {});
                        } else {
                          generatedImageUrl = null;
                          generatedContent = speech;
                          setState(() {});
                          await systemSpeak(speech);
                        }
                        await stopListening();
                      } else {
                        initSpeechToText();
                      }
                    },
                    backgroundColor: Pallete.firstSuggestionBoxColor,
                    splashColor: Pallete.secondSuggestionBoxColor,
                    child: speechToText.isListening? const Icon(Icons.square):const Icon(Icons.mic),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
