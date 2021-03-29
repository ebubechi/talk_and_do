import 'package:flutter/material.dart';
import 'package:talk_and_do/speech_to_text.dart';
import 'package:talk_and_do/text_to_speech.dart';

class Home extends StatelessWidget {
  final String title;
  const Home({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        title: Center(child: Text(title)),
        backgroundColor: Colors.redAccent,
        elevation: 0.0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                            child: Center(
                                child: Container(
                                    child: Padding(
                                        padding: EdgeInsets.all(30.0),
                                        child: Text(
                                          "What would you like to convert?",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 30.0),
                                        )))),
                            // color: Colors.purpleAccent,
                            height: MediaQuery.of(context).size.height / 2))
                  ],
                )),
            Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                            child: Center(
                                child: GestureDetector(
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text("Speech-to-Text", style: TextStyle(color: Colors.white),),
                                ),
                                decoration: BoxDecoration(
                                   boxShadow: [
                                    BoxShadow(
                                        color:
                                            Colors.red.withOpacity(0.8),
                                        spreadRadius: 5,
                                        blurRadius: 5.0,
                                        offset: Offset(
                                          0,
                                          5,
                                        ))
                                  ],
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Speech2Text()));
                              },
                            )),
                            // color: Colors.redAccent,
                            height: MediaQuery.of(context).size.height / 2)),
                    Expanded(
                        child: Container(
                            child: Center(
                                child: GestureDetector(
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text("Text-to-Speech", style: TextStyle(color: Colors.white),),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Colors.red.withOpacity(0.8),
                                        spreadRadius: 5,
                                        blurRadius: 5.0,
                                        offset: Offset(
                                          5,
                                          5,
                                        ))
                                  ],
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TextToSpeech()));
                              },
                            )),
                            // color: Colors.redAccent,
                            height: MediaQuery.of(context).size.height / 2))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
