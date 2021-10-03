import 'dart:convert';
import 'dart:core';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:stansand_african_limited/login/sorted_page.dart';
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
    loadAsset();
  }

  List<List<dynamic>> data = [];

  loadAsset() async {
    final myData = await rootBundle.loadString("assets/excel/datas.csv");
    List<List<dynamic>> csvTable = const CsvToListConverter().convert(myData);
    data = csvTable;
  }

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final _vendorID = TextEditingController();
    final _catalogueNumber = TextEditingController();

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

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
                          hintText: 'Auction NO',
                          suffixStyle: TextStyle(color: Colors.green),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
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
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const SortedScreen()));
                        },
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
                          .loadString('assets/excel/data.json'),
                      builder: (context, snapshot) {
                        var showData = jsonDecode(snapshot.data.toString());
                        return ListView.builder(
                          itemCount: showData.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: ListTile(
                                  title: Row(
                                    children: [
                                      Checkbox(
                                        checkColor: Colors.white,
                                        fillColor:
                                            MaterialStateProperty.resolveWith(
                                          getColor,
                                        ),
                                        value: isChecked,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            isChecked = value!;
                                          });
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 3.0, right: 3.0),
                                        child:
                                            Text(showData[index]['Leaf Type']),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 3.0, right: 3.0),
                                        child: Text(
                                            showData[index]['Purchase For']),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 3.0, right: 3.0),
                                        child:
                                            Text(showData[index]['Inventory']),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 3.0, right: 3.0),
                                        child: Text(showData[index]['Garden']),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 3.0, right: 3.0),
                                        child:
                                            Text(showData[index]['Kenyan Tea']),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 3.0, right: 3.0),
                                        child: Text(showData[index]['RA Tea']),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 3.0, right: 3.0),
                                        child: Text(showData[index]['Grade']),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 3.0, right: 3.0),
                                        child: Text(showData[index]['Pkg']),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 3.0, right: 3.0),
                                        child: Text(showData[index]['Lot No']
                                            .toString()),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 3.0, right: 3.0),
                                        child: Text(showData[index]['Invoice']
                                            .toString()),
                                      ),
                                    ],
                                  ),
                                ));
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
}
