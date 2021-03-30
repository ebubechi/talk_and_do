import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:talk_and_do/text_to_speech.dart';

// void main() => runApp(Speech2Text());

class Speech2Text extends StatefulWidget {
  @override
  _Speech2TextState createState() => _Speech2TextState();
}

class _Speech2TextState extends State<Speech2Text> {
  bool _hasSpeech = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = '';
  String lastError = '';
  String lastStatus = '';
  String _currentLocaleId = '';
  int resultListened = 0;
  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();

  @override
  void initState() {
    initSpeechState();
    super.initState();
  }

  Future<void> initSpeechState() async {
    var hasSpeech = await speech.initialize(
        onError: errorListener,
        onStatus: statusListener,
        debugLogging: true,
        finalTimeout: Duration(milliseconds: 0));
    if (hasSpeech) {
      _localeNames = await speech.locales();

      var systemLocale = await speech.systemLocale();
      _currentLocaleId = systemLocale.localeId;
    }

    if (!mounted) return;

    setState(() {
      _hasSpeech = hasSpeech;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Center(
            child: const Text(
              'Speech to Text Example',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ),
        body: Column(children: [
          Container(
            // child: Column(
            //   children: <Widget>[
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: <Widget>[
                //     FlatButton(
                //       child: Text('Initialize'),
                //       onPressed: _hasSpeech ? null : initSpeechState,
                //     ),
                //   ],
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: <Widget>[
                //     FlatButton(
                //       child: Text('Start'),
                //       onPressed: !_hasSpeech || speech.isListening
                //           ? null
                //           : startListening,
                //     ),
                //     FlatButton(
                //       child: Text('Stop'),
                //       onPressed: speech.isListening ? stopListening : null,
                //     ),
                //     FlatButton(
                //       child: Text('Cancel'),
                //       onPressed: speech.isListening ? cancelListening : null,
                //     ),
                //   ],
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: <Widget>[
                //     DropdownButton(
                //       onChanged: (selectedVal) => _switchLang(selectedVal),
                //       value: _currentLocaleId,
                //       items: _localeNames
                //           .map(
                //             (localeName) => DropdownMenuItem(
                //               value: localeName.localeId,
                //               child: Text(localeName.name),
                //             ),
                //           )
                //           .toList(),
                //     ),
                //   ],
                // )
            //   ],
            // ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              children: <Widget>[
                // Center(
                //   child: Text(
                //     'Recognized Words',
                //     style: TextStyle(fontSize: 22.0),
                //   ),
                // ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        child: Center(
                          child: Text(
                            lastWords,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Positioned.fill(
                        bottom: 20,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: 70.0,
                            height: 70.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: .26,
                                    spreadRadius: level * 1.5,
                                    color: Colors.redAccent.withOpacity(.05))
                              ],
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.mic),
                              onPressed: !_hasSpeech || speech.isListening
                                  ? stopListening
                                  : startListening,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(40),
                              bottom: Radius.circular(5))),
                      height: MediaQuery.of(context).size.height / 10,
                      child: Row(children: [
                        Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: IconButton(
                                    icon: Icon(
                                      Icons.mic,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Speech2Text()));
                                    }),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: IconButton(
                                    icon: Icon(Icons.text_fields,
                                        color: Colors.white),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TextToSpeech()));
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  )
              ],
            ),
          ),
          // Expanded(
          //   flex: 1,
          //   child: Column(
          //     children: <Widget>[
          //       Center(
          //         child: Text(
          //           'Error Status',
          //           style: TextStyle(fontSize: 22.0),
          //         ),
          //       ),
          //       Center(
          //         child: Text(lastError),
          //       ),
          //     ],
          //   ),
          // ),
          // Container(
          //   padding: EdgeInsets.symmetric(vertical: 20),
          //   color: Theme.of(context).backgroundColor,
          //   child: Center(
          //     child: speech.isListening
          //         ? Text(
          //             "I'm listening...",
          //             style: TextStyle(fontWeight: FontWeight.bold),
          //           )
          //         : Text(
          //             'Not listening',
          //             style: TextStyle(fontWeight: FontWeight.bold),
          //           ),
          //   ),
          // ),
        ]),
      ),
    );
  }

  void startListening() {
    lastWords = '';
    lastError = '';
    speech.listen(
        onResult: resultListener,
        listenFor: Duration(seconds: 5),
        pauseFor: Duration(seconds: 5),
        partialResults: false,
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        listenMode: ListenMode.confirmation);
    setState(() {});
  }

  void stopListening() {
    speech.stop();
    setState(() {
      level = 0.0;
    });
  }

  void cancelListening() {
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

  void resultListener(SpeechRecognitionResult result) {
    ++resultListened;
    print('Result listener $resultListened');
    setState(() {
      lastWords = '${result.recognizedWords} - ${result.finalResult}';
    });
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // print("sound level $level: $minSoundLevel - $maxSoundLevel ");
    setState(() {
      this.level = level;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    // print("Received error status: $error, listening: ${speech.isListening}");
    setState(() {
      lastError = '${error.errorMsg} - ${error.permanent}';
    });
  }

  void statusListener(String status) {
    // print(
    // 'Received listener status: $status, listening: ${speech.isListening}');
    setState(() {
      lastStatus = '$status';
    });
  }

  void _switchLang(selectedVal) {
    setState(() {
      _currentLocaleId = selectedVal;
    });
    print(selectedVal);
  }
}
