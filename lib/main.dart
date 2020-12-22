import 'package:flutter/material.dart';
import 'package:report_app/screen/first_screen.dart';
import 'package:report_app/screen/reg.dart';

import 'screen/launching_screen.dart';

void main() {
  runApp(MaterialApp(
    home: LaunchingScreen(),
    navigatorObservers: [routeObserver],
    navigatorKey: navigatorKey,
  ));
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
