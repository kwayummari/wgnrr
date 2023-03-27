import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wgnrr/utils/widget/drawer/app_drawer.dart';
import 'package:wgnrr/utils/widget/text/text.dart';

class viewResults extends StatefulWidget {
  var client;
  var doctor;
  var procedure;
  var timeline;
  var pain;
  var blood;
  var fever;
  var smell;
  var questionare;
  var language;
  var status;
  viewResults(
      {super.key,
      required this.client,
      required this.doctor,
      required this.procedure,
      required this.timeline,
      required this.pain,
      required this.blood,
      required this.fever,
      required this.smell,
      required this.questionare,
      required this.language,
      required this.status});

  @override
  State<viewResults> createState() => _viewResultsState();
}

class _viewResultsState extends State<viewResults> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      drawer: AppDrawer(
        username: widget.client,
        language: widget.language,
        status: widget.status,
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
          txt: widget.language == 'Kiswahili'
              ? 'Matokeo ya post'
              : 'Post procedures results',
          size: 15,
          color: HexColor('#ffffff'),
          weight: FontWeight.w500,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: widget.procedure == 'Procedure - Surgical'
            ? Column(
                children: [
                  AppText(txt: widget.client, size: 15),
                  AppText(txt: widget.doctor, size: 15),
                  AppText(txt: widget.procedure, size: 15),
                  AppText(
                      txt: widget.timeline + 'hours after procedure', size: 15),
                  AppText(txt: 'Blood: ' + widget.blood, size: 15),
                  AppText(txt: 'Fever: ' + widget.fever, size: 15),
                  AppText(txt: 'Pain: ' + widget.pain, size: 15),
                  AppText(txt: 'Smell: ' + widget.smell, size: 15),
                  AppText(
                      txt: 'Questionnaire: ' + widget.questionare, size: 15),
                ],
              )
            : Column(
                children: [
                  AppText(txt: widget.client, size: 15),
                  AppText(txt: widget.doctor, size: 15),
                  AppText(txt: widget.procedure, size: 15),
                  AppText(
                      txt: widget.timeline + 'hours after procedure', size: 15),
                  AppText(txt: 'Blood: ' + widget.blood, size: 15),
                  AppText(txt: 'Fever: ' + widget.fever, size: 15),
                  AppText(txt: 'Pain: ' + widget.pain, size: 15),
                  AppText(txt: 'Smell: ' + widget.smell, size: 15),
                  AppText(
                      txt: 'Questionnaire: ' + widget.questionare, size: 15),
                ],
              ),
      ),
    );
  }
}
