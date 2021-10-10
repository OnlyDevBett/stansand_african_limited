import 'dart:convert';
import 'dart:core';
// import 'package:avatar_glow/avatar_glow.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:flutter_text_to_speech/flutter_text_to_speech.dart';
import 'transition_route_observer.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;

class SortedScreen extends StatefulWidget {
  static const routeName = '/sortedPage';

  const SortedScreen({Key? key}) : super(key: key);

  @override
  _SortedScreenState createState() => _SortedScreenState();
}

class _SortedScreenState extends State<SortedScreen>
    with SingleTickerProviderStateMixin, TransitionRouteAware {
  var key = GlobalKey();
  VoiceController controller = FlutterTextToSpeech.instance.voiceController();
  Future<bool> _goToLogin(BuildContext context) {
    return Navigator.of(context).pushReplacementNamed('/').then((_) => false);
  }

  final routeObserver = TransitionRouteObserver<PageRoute?>();
  static const headerAniInterval = Interval(.1, .3, curve: Curves.easeOut);
  late Animation<double> _headerScaleAnimation;
  AnimationController? _loadingController;

  // late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;


  @override
  void initState() {
    super.initState();
    loadAsset();
    // _speech = stt.SpeechToText();
    controller.init();
  }

  List<List<dynamic>> data = [];

  loadAsset() async {
    final myData = await rootBundle.loadString("assets/excel/datas.csv");
    List<List<dynamic>> csvTable = const CsvToListConverter().convert(myData);
    data = csvTable;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final _vendorID = TextEditingController();
    final _catalogueNumber = TextEditingController();
    final assets = DefaultAssetBundle.of(context).loadString('assets/excel/datas.json');

    TextEditingController textController = TextEditingController();

    return WillPopScope(
      onWillPop: () => _goToLogin(context),
      child: SafeArea(
        child: Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            color: theme.primaryColor.withOpacity(.1),
            child: ListView(
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _vendorID,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple),
                          ),
                          hintText: 'Vendor ID',
                          suffixStyle: TextStyle(color: Colors.green),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _catalogueNumber,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple),
                          ),
                          hintText: 'Catalogue Number',
                          suffixStyle: TextStyle(color: Colors.green),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          await loadAsset();
                          print(data);
                        },
                        child: const Text("Load"),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.purple),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),

                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text("Comment"),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.purple),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.account_circle_outlined),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 280.0,
                    height: 300.0,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.purple,
                      ),
                    ),
                    child: FutureBuilder(
                      future: DefaultAssetBundle.of(context)
                          .loadString('assets/excel/datas.json'),
                      builder: (context, snapshot) {
                        var showData = jsonDecode(snapshot.data.toString());
                        return ListView.builder(
                          itemCount: showData.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 3.0, right: 3.0),
                                    child:
                                        Text(showData[index]['Seq'].toString()),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 3.0, right: 3.0),
                                    child:
                                        Text(showData[index]['Auction Type']),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 3.0, right: 3.0),
                                    child: Text(showData[index]['Garden']),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 3.0, right: 3.0),
                                    child: Text(showData[index]['Lot No'].toString()),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 3.0, right: 3.0),
                                    child: Text(showData[index]['Invoice']),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 3.0, right: 3.0),
                                    child: Text(showData[index]['Grade']),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 3.0, right: 3.0),
                                    child: Text(showData[index]['Cat Pkgs'].toString()),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 3.0, right: 3.0),
                                    child: Text(
                                        showData[index]['Cat Wght'].toString()),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 3.0, right: 3.0),
                                    child: Text(
                                        showData[index]['Cat Pkgs,Wght'].toString()),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 3.0, right: 3.0),
                                    child: Text(showData[index]['Liqor Remarks']),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.all(10.0),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      style: const TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      controller: textController,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 50.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        side: const BorderSide(
                                          width: 3,
                                          color: Color(0xff6809e0),
                                        ),
                                      ),
                                      onPressed: () {
                                        controller.speak(
                                          textController.text,
                                        );
                                        textController.clear();
                                      },
                                      child: const Center(
                                        child: Text(
                                          'Tap For Speak',
                                          style: TextStyle(
                                            fontSize: 40,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      color: const Color(0xff6809e0),
                                    ),
                                  )
                                  // AvatarGlow(
                                  //   animate: _isListening,
                                  //   glowColor: Theme.of(context).primaryColor,
                                  //   endRadius: 75.0,
                                  //   duration:
                                  //       const Duration(milliseconds: 2000),
                                  //   repeatPauseDuration:
                                  //       const Duration(milliseconds: 100),
                                  //   repeat: true,
                                  //   child: FloatingActionButton(
                                  //     onPressed: _listen,
                                  //     child: Icon(_isListening
                                  //         ? Icons.mic
                                  //         : Icons.mic_none),
                                  //   ),
                                  // ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  //
  // void _listen() async {
  //   if (!_isListening) {
  //     bool available = await _speech.initialize(
  //       onStatus: (val) => print('onStatus: $val'),
  //       onError: (val) => print('onError: $val'),
  //     );
  //     if (available) {
  //       setState(() => _isListening = true);
  //       _speech.listen(
  //         onResult: (val) => setState(() {
  //           _text = val.recognizedWords;
  //           if (val.hasConfidenceRating && val.confidence > 0) {
  //             _confidence = val.confidence;
  //           }
  //         }),
  //       );
  //     }
  //   } else {
  //     setState(() => _isListening = false);
  //     _speech.stop();
  //   }
  // }
}
