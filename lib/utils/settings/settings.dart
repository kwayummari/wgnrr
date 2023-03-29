import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wgnrr/splash/splash.dart';
import 'package:wgnrr/utils/widget/drawer/app_drawer.dart';
import 'package:wgnrr/utils/widget/text/text.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with TickerProviderStateMixin {
  bool? _notificationsEnabled;
  bool _darkModeEnabled = false;
  late AnimationController _controller;
  late Animation<double> _opacityAnimation =
      Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

  var username;
  var status;
  var bot;
  var language;
  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var u = sharedPreferences.get('username');
    var s = sharedPreferences.get('status');
    var b = sharedPreferences.get('bot');
    var l = sharedPreferences.get('language');
    setState(() {
      language == 'Kiswahili'
          ? _notificationsEnabled = false
          : _notificationsEnabled = true;
      username = u;
      status = s;
      bot = b;
      language = l;
    });
  }

  @override
  void initState() {
    super.initState();
    getValidationData();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      drawer: AppDrawer(
        username: username,
        language: language,
        status: status,
      ),
      appBar: AppBar(
        leading: Builder(
            builder: (context) => // Ensure Scaffold is in context
                IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                )),
        automaticallyImplyLeading: true,
        shape: Border(bottom: BorderSide(color: Colors.orange, width: 0.2)),
        elevation: 4,
        toolbarHeight: 70,
        backgroundColor: HexColor('#742B90'),
        title: AppText(
          txt: language == 'Kiswahili' ? 'Mpangilio' : 'Settings',
          size: 15,
          color: HexColor('#ffffff'),
          weight: FontWeight.w500,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                if (_controller.isCompleted) {
                  _controller.reverse();
                } else {
                  _controller.forward();
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Language',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  Icon(
                    _controller.isCompleted
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            FadeTransition(
              opacity: _opacityAnimation,
              child: SwitchListTile(
                title: Text(language),
                value: _notificationsEnabled!,
                onChanged: (value) async {
                  final SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  language == 'Kiswahili'
                      ? sharedPreferences.setString(
                          'language', 'English'.toString())
                      : sharedPreferences.setString(
                          'language', 'Kiswahili'.toString());
                  setState(() {
                    language == 'Kiswahili'
                        ? _notificationsEnabled = false
                        : _notificationsEnabled = true;
                        Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Splash()));
                  });
                },
              ),
            ),
            SizedBox(height: 0.0),
            GestureDetector(
              onTap: () {
                setState(() {
                  _darkModeEnabled = !_darkModeEnabled;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Appearance',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
                    transitionBuilder: (child, animation) => ScaleTransition(
                      scale: animation,
                      child: child,
                    ),
                    child: _darkModeEnabled
                        ? Icon(
                            Icons.nightlight_round,
                            key: ValueKey('dark_mode'),
                            color: Colors.grey[600],
                          )
                        : Icon(
                            Icons.light_mode_rounded,
                            key: ValueKey('light_mode'),
                          ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
