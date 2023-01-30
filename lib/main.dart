// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'package:wgnrr/provider/provider.dart';
import 'package:wgnrr/splash/splash.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MultiProvider(
      providers: appProviders,
    child: const MyApp(),)
    );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) =>  MaterialApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
            ClampingScrollWrapper.builder(context, widget!),
            breakpoints: const [
              ResponsiveBreakpoint.resize(480, name: MOBILE),
              ResponsiveBreakpoint.autoScale(800, name: TABLET),
              ResponsiveBreakpoint.resize(1000, name: DESKTOP),
              ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
              ResponsiveBreakpoint.autoScale(2460, name: '4K'),
            ],
          ),
      debugShowCheckedModeBanner: false,
      title: 'WGNRR',
      theme: ThemeData(
          // timePickerTheme: Theme.of(context).primaryColor,
          cardColor: Colors.amber.shade900,
          highlightColor: Colors.amber.shade900,
          splashColor: Colors.amber.shade900,
          primaryColor: Colors.purple.shade700,
          visualDensity: VisualDensity.adaptivePlatformDensity, colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.amber).copyWith(background: Colors.amber.shade900)),
      home: Splash());
}
