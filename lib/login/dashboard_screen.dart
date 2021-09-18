import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_login/theme.dart';
import 'package:flutter_login/widgets.dart';
import 'package:stansand_african_limited/constants/colors.dart';
import 'package:stansand_african_limited/widgets/fade_in.dart';
import 'transition_route_observer.dart';
import 'constants.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/dashboard';

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin, TransitionRouteAware {
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                Align(
                  alignment: Alignment.topRight,
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Refresh"),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.amber),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Min"),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.amber),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Select"),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.amber),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Comment"),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.amber),
                        ),
                      ),
                    ],
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
