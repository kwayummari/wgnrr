// // ignore_for_file: must_be_immutable
// import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:wgnrr/api/const.dart';
// import 'package:http/http.dart' as http;

// class Individualcommunitychats extends StatefulWidget {
//   var username;
//   var topic;
//   var client;
//   Individualcommunitychats(
//       {super.key,
//       required this.client,
//       required this.topic,
//       required this.username});

//   @override
//   State<Individualcommunitychats> createState() =>
//       _IndividualcommunitychatsState();
// }

// class _IndividualcommunitychatsState extends State<Individualcommunitychats> {
  

//   var comment;
//   Future get_comments() async {
//     http.Response response;
//     const url = '${murl}community/community_text.php';
//     var response1 = await http.post(Uri.parse(url), body: {
//       "topic": widget.topic.toString(),
//     });
//     if (response1.statusCode == 200) {
//       if (mounted) setState(() {});
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: SingleChildScrollView(
//         child: 
//       ),
//     );
//   }
// }
