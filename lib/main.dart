import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wgnrr/api/const.dart';
import 'package:wgnrr/provider/provider.dart';
import 'package:wgnrr/splash/splash.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MultiProvider(
      providers: appProviders,
      child: ScreenshotPreventionApp(
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var u = sharedPreferences.get('username');
      var l = sharedPreferences.get('language');
      var s = sharedPreferences.get('status');
      if (u != null && s == 'Health Care Providers') {
        http.Response response;
        const url = '${murl}chats/online.php';
        var response1 = await http.post(Uri.parse(url), body: {
          "username": u.toString(),
        });
        if (response1.statusCode == 200) {
          Fluttertoast.showToast(
            msg: l == 'Kiswahili' ? 'Karibu $u' : 'Welcome back $u',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 15.0,
          );
        }
      }
    } else if (state == AppLifecycleState.paused) {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var u = sharedPreferences.get('username');
      var l = sharedPreferences.get('language');
      var s = sharedPreferences.get('status');
      if (u != null && s == 'Health Care Providers') {
        http.Response response;
        const url = '${murl}chats/offline.php';
        var response1 = await http.post(Uri.parse(url), body: {
          "username": u.toString(),
        });
        if (response1.statusCode == 200) {
          Fluttertoast.showToast(
            msg: l == 'Kiswahili' ? 'Karibu $u' : 'Welcome back $u',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 15.0,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
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
        title: 'MimiCare',
        theme: ThemeData(
          // timePickerTheme: Theme.of(context).primaryColor,
          cardColor: Colors.amber.shade900,
          highlightColor: Colors.amber.shade900,
          splashColor: Colors.amber.shade900,
          primaryColor: Colors.purple.shade700,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.amber)
              .copyWith(background: Colors.amber.shade900),
        ),
        home: Splash(),
      );
}

class ScreenshotPreventionApp extends StatelessWidget {
  final Widget child;

  ScreenshotPreventionApp({required this.child});

  @override
  Widget build(BuildContext context) {
    // Prevent screenshots globally
    FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);

    return child;
  }
}
