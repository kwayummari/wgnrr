import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wgnrr/splash/splash.dart';
import 'package:wgnrr/utils/settings/account/account.dart';
import 'package:wgnrr/utils/settings/language.dart';
import 'package:wgnrr/utils/widget/IconButton/IconButton.dart';
import 'package:wgnrr/utils/widget/drawer/app_drawer.dart';
import 'package:wgnrr/utils/widget/text/text.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        automaticallyImplyLeading: true,
        shape: Border(bottom: BorderSide(color: Colors.orange, width: 0.2)),
        elevation: 4,
        toolbarHeight: 70,
        backgroundColor: HexColor('#742B90'),
        title: AppText(
          txt: language == 'Kiswahili'
              ? 'Mpangilio \n@${username}'
              : 'Settings \n@${username}',
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
            ListTile(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Account())),
              leading: Icon(Icons.person),
              title: AppText(
                txt: 'Your Account',
                size: 15,
                weight: FontWeight.bold,
              ),
              subtitle: AppText(
                  txt:
                      'See information about your account,download an archive of your data, or learn about your account deactivation options.',
                  size: 14),
            ),
            SizedBox(
              height: 15,
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: AppText(
                txt: 'Language',
                size: 15,
                weight: FontWeight.bold,
              ),
              subtitle: AppText(
                  txt:
                      'See information about your account,download an archive of your data, or learn about your account deactivation options.',
                  size: 14),
            ),
            SizedBox(
              height: 15,
            ),
            // GestureDetector(
            //   onTap: () {
            //     setState(() {
            //       _darkModeEnabled = !_darkModeEnabled;
            //     });
            //   },
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         'Appearance',
            //         style: TextStyle(
            //           fontWeight: FontWeight.bold,
            //           fontSize: 16.0,
            //         ),
            //       ),
            //       AnimatedSwitcher(
            //         duration: Duration(milliseconds: 500),
            //         transitionBuilder: (child, animation) => ScaleTransition(
            //           scale: animation,
            //           child: child,
            //         ),
            //         child: _darkModeEnabled
            //             ? Icon(
            //                 Icons.nightlight_round,
            //                 key: ValueKey('dark_mode'),
            //                 color: Colors.grey[600],
            //               )
            //             : Icon(
            //                 Icons.light_mode_rounded,
            //                 key: ValueKey('light_mode'),
            //               ),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }
}
