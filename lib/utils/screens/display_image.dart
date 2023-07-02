// import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:image_picker_plus/image_picker_plus.dart';
// import 'package:wgnrr/api/const.dart';
// import 'package:http/http.dart' as http;
//
// class DisplayImages extends StatefulWidget {
//   final List<SelectedByte> selectedBytes;
//   final double aspectRatio;
//   final SelectedImagesDetails details;
//   final username;
//   final doctor;
//   final client;
//   const DisplayImages({
//     Key? key,
//     required this.doctor,
//     required this.client,
//     required this.username,
//     required this.details,
//     required this.selectedBytes,
//     required this.aspectRatio,
//   }) : super(key: key);
//
//   @override
//   State<DisplayImages> createState() => _DisplayImagesState();
// }
//
// class _DisplayImagesState extends State<DisplayImages> {
//   TextEditingController comments = TextEditingController();
//   Future send_comments() async {
//     if (widget.selectedBytes.length == 1) {
//       SelectedByte selectedByte = widget.selectedBytes[0];
//       const url = '${murl}message/message_image_write.php';
//       var request = http.MultipartRequest('POST', Uri.parse(url));
//       request.fields['username'] = widget.username.toString();
//       request.fields['doctor'] = widget.doctor.toString();
//       request.fields['part'] = '1'.toString();
//       request.fields['type'] = '2'.toString();
//       request.fields['comments'] = comments.text;
//       var image = await http.MultipartFile.fromPath(
//           "image", selectedByte.selectedFile.path);
//       request.files.add(image);
//       var response = await request.send();
//       if (response.statusCode == 200) {
//         Navigator.pop(context);
//         setState(() {
//           get_comments();
//         });
//       }
//     }
//   }
//
//   var comment;
//   Future get_comments() async {
//     const url = '${murl}message/message.php';
//     var response1 = await http.post(Uri.parse(url), body: {
//       "client": widget.client.toString(),
//       "doctor": widget.doctor.toString()
//     });
//     if (response1.statusCode == 200) {
//       if (mounted)
//         setState(() {
//         });
//     }
//   }
//
//   Future<Widget> view(link) async {
//     SelectedByte selectedByte = link;
//     return
//         SizedBox(
//             width: double.infinity,
//             child: Image.file(selectedByte.selectedFile),
//           );
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     print(widget.selectedBytes);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: HexColor('#742B90'),
//         centerTitle: true,
//         automaticallyImplyLeading: true,
//         title: const Text(
//           'Selected Images',
//           style: TextStyle(color: Colors.white),
//         ),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 send_comments();
//               },
//               icon: Icon(
//                 Icons.send_and_archive,
//                 color: Colors.white,
//               ))
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             FutureBuilder<Widget>(
//               future: view(
//                 widget.selectedBytes[0],
//               ),
//               builder: (BuildContext _, snapshot) {
//                 if (snapshot.hasError) {
//                   // Error
//                   return Text('', textScaleFactor: 1);
//                 } else if (!(snapshot.hasData)) {
//                   return Container(
//                     width: 100,
//                     height: 100,
//                     child: Center(
//                       child: Icon(Icons.error),
//                     ),
//                   );
//                 }
//                 return Center(child: snapshot.data);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // class _DisplayVideo extends StatefulWidget {
// //   final SelectedByte selectedByte;
// //   const _DisplayVideo({Key? key, required this.selectedByte}) : super(key: key);
//
// //   @override
// //   State<_DisplayVideo> createState() => _DisplayVideoState();
// // }
//
// // class _DisplayVideoState extends State<_DisplayVideo> {
// //   @override
// //   void initState() {
// //     super.initState();
// //   }
//
//   // @override
//   // Widget build(BuildContext context) {
//   //   return BetterPlayer.file(widget.selectedByte.selectedFile.path);
//   // }
// // }
