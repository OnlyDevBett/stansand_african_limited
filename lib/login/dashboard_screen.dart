import 'dart:core';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:open_file/open_file.dart';
import 'transition_route_observer.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/dashboard';

  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin, TransitionRouteAware {
  var key = GlobalKey();

  Future<bool> _goToLogin(BuildContext context) {
    return Navigator.of(context).pushReplacementNamed('/').then((_) => false);
  }

  final routeObserver = TransitionRouteObserver<PageRoute?>();
  static const headerAniInterval = Interval(.1, .3, curve: Curves.easeOut);
  late Animation<double> _headerScaleAnimation;
  AnimationController? _loadingController;

  @override
  void initState() {
    super.initState();
  }

  var value;
  var _openResult = 'Unknown';

  Future<void> openFile() async {
    String filePath = await rootBundle.loadString('assets/excel/data.xlsx');

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );
    if (result != null) {
      filePath = result.files.single.path!;
    }
    final _result = await OpenFile.open(filePath);
    print(
        '====================================================================');
    print(_result.toString());

    setState(() {
      _openResult = "type=${_result.type}  message=${_result.message}";
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final _vendorID = TextEditingController();
    final _catalogueNumber = TextEditingController();

    return WillPopScope(
      onWillPop: () => _goToLogin(context),
      child: SafeArea(
        child: Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            color: theme.primaryColor.withOpacity(.1),
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
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
                        onPressed: () {},
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
                        child: const Text("Push"),
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
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.purple,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('open result: $_openResult\n'),
                        TextButton(
                          child: Text('Tap to open file'),
                          onPressed: openFile,
                        ),
                      ],
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
}
