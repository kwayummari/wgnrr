import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wgnrr/models/client/appointment/appointment.dart';
import 'package:wgnrr/models/client/appointment/results.dart';
import 'package:wgnrr/models/client/home.dart';
import 'package:wgnrr/models/health_care_provider/appointment_doctor/appointment.dart';
import 'package:wgnrr/models/health_care_provider/feedback/feedback.dart';
import 'package:wgnrr/utils/settings/settings.dart';
import 'package:wgnrr/utils/widget/text/text.dart';

class AppDrawer extends StatefulWidget {
  var language;
  var status;
  var username;
  var update;
  AppDrawer(
      {Key? key,
      required this.language,
      required this.status,
      required this.update,
      required this.username});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 3;
    return Drawer(
      backgroundColor: HexColor('#ffffff'),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                color: Colors.white,
                child: Image.asset(
                  'assets/full_logo.png',
                  height: 300,
                )),
            Divider(
              color: Colors.black,
            ),
            if (widget.update.toString() != '2' || widget.update == null)
              ListTile(
                tileColor: Colors.red,
                onTap: () async {
                  var url =
                      'https://play.google.com/store/apps/details?id=com.wgnrr.app';
                  launchUrl(Uri.parse(url));
                },
                leading: Icon(
                  Icons.update,
                  color: Colors.white,
                  size: 15,
                ),
                title: AppText(
                  txt: widget.language == 'Kiswahili'
                      ? 'Nyenyekea programu yako'
                      : 'Update your application',
                  size: 15,
                  color: Colors.white,
                  weight: FontWeight.w500,
                ),
              ),
            if (widget.update.toString() != '1' || widget.update == null)
              Divider(
                color: Colors.black,
              ),
            ListTile(
              leading: Icon(
                Icons.person_2,
                color: Colors.black,
              ),
              title: AppText(
                txt: widget.username!,
                size: 15,
                color: HexColor('#000000'),
                weight: FontWeight.w500,
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            ListTile(
              leading: Icon(
                Icons.newspaper,
                color: Colors.black,
                size: 15,
              ),
              title: AppText(
                txt: widget.status!,
                size: 15,
                color: HexColor('#000000'),
                weight: FontWeight.w500,
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            ListTile(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Quiz())),
              leading: Icon(
                Icons.account_box,
                color: Colors.black,
                size: 15,
              ),
              title: AppText(
                txt: widget.language == 'Kiswahili' ? 'Marejesho' : 'Feedback',
                size: 15,
                color: HexColor('#000000'),
                weight: FontWeight.w500,
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            ListTile(
              onTap: () {
                if (widget.status != 'Health Care Providers')
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Appointment_table()));
                else
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Appointment_table_doctor()));
              },
              leading: Icon(
                Icons.meeting_room,
                color: Colors.black,
                size: 15,
              ),
              title: AppText(
                txt: widget.language == 'Kiswahili'
                    ? 'Apointimenti'
                    : 'Appointment',
                size: 15,
                color: HexColor('#000000'),
                weight: FontWeight.w500,
              ),
            ),
            if (widget.status != 'Health Care Providers')
              Divider(
                color: Colors.black,
              ),
            if (widget.status != 'Health Care Providers')
              ListTile(
                onTap: () {
                  if (widget.status != 'Health Care Providers')
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Results()));
                  else
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Results()));
                },
                leading: Icon(
                  Icons.meeting_room,
                  color: Colors.black,
                  size: 15,
                ),
                title: AppText(
                  txt: widget.language == 'Kiswahili'
                      ? 'Matokeo ya huduma'
                      : 'Post Procedures Results',
                  size: 15,
                  color: HexColor('#000000'),
                  weight: FontWeight.w500,
                ),
              ),
            Divider(
              color: Colors.black,
            ),
            ListTile(
              onTap: () async {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Homepage('')));
              },
              leading: Icon(
                Icons.home,
                color: Colors.black,
                size: 15,
              ),
              title: AppText(
                txt: widget.language == 'Kiswahili' ? 'Nyumbani' : 'Home',
                size: 15,
                color: HexColor('#000000'),
                weight: FontWeight.w500,
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            ListTile(
              onTap: () async {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SettingsPage()));
              },
              leading: Icon(
                Icons.settings,
                color: Colors.black,
                size: 15,
              ),
              title: AppText(
                txt: widget.language == 'Kiswahili' ? 'Mpangilio' : 'Settings',
                size: 15,
                color: HexColor('#000000'),
                weight: FontWeight.w500,
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            SizedBox(
              height: 70,
            )
          ],
        ),
      ),
    );
  }
}
