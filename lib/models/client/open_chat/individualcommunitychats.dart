// ignore_for_file: must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker_plus/image_picker_plus.dart';
import 'package:wgnrr/api/const.dart';
import 'package:http/http.dart' as http;
import 'package:wgnrr/utils/screens/display_image.dart';

class Individualcommunitychats extends StatefulWidget {
  var username;
  var topic;
  var client;
  Individualcommunitychats(
      {super.key,
      required this.client,
      required this.topic,
      required this.username});

  @override
  State<Individualcommunitychats> createState() =>
      _IndividualcommunitychatsState();
}

class _IndividualcommunitychatsState extends State<Individualcommunitychats> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController comments = TextEditingController();
  Future send_comments() async {
    if (comments.text.isNotEmpty) {
      const url = '${murl}community/create_community_text.php';
      var response = await http.post(Uri.parse(url), body: {
        "username": widget.username.toString(),
        "topic": widget.topic.toString(),
        "message": comments.text,
      });
      comments.clear();
      if (response.statusCode == 200) {
        setState(() {
          get_comments();
        });
      }
    }
  }

  var comment;
  Future get_comments() async {
    http.Response response;
    const url = '${murl}community/community_text.php';
    var response1 = await http.post(Uri.parse(url), body: {
      "topic": widget.topic.toString(),
    });
    if (response1.statusCode == 200) {
      if (mounted) setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Row(
              children: [
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                      color: HexColor('#742B90'),
                      borderRadius: BorderRadius.circular(25.0),
                      border: Border.all(color: HexColor('#742B90'))),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width / 1.3,
                      maxWidth: MediaQuery.of(context).size.width / 1.2,
                      minHeight: 30.0,
                      maxHeight: 250.0,
                    ),
                    child: Scrollbar(
                      child: TextFormField(
                        style: GoogleFonts.vesperLibre(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                        cursorColor: Colors.white,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: comments,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }
                                send_comments();
                              },
                              icon: Icon(
                                Icons.send,
                                color: Colors.white,
                              )),
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor('#742B90')),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          fillColor: Colors.white,
                          hoverColor: HexColor('#742B90'),
                          focusColor: HexColor('#742B90'),
                          hintText: 'Message',
                          hintStyle: GoogleFonts.vesperLibre(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                          contentPadding: EdgeInsets.only(
                              top: 5.0, left: 15.0, right: 15.0, bottom: 5.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Spacer(),
                // CircleAvatar(
                //     backgroundColor: HexColor('#742B90'),
                //     child: IconButton(
                //         onPressed: () async {
                //           ImagePickerPlus picker = ImagePickerPlus(context);
                //           SelectedImagesDetails? details =
                //               await picker.pickBoth(
                //             source: ImageSource.both,
                //             multiSelection: false,
                //             galleryDisplaySettings: GalleryDisplaySettings(
                //               tabsTexts: _tabsTexts(),
                //               appTheme: AppTheme(
                //                   focusColor: Colors.white,
                //                   primaryColor: Colors.black),
                //               cropImage: true,
                //               showImagePreview: true,
                //             ),
                //           );
                //           if (details != null) await displayDetails(details);
                //         },
                //         icon: Icon(
                //           Icons.camera_alt,
                //           color: Colors.white,
                //         ))),
                // Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TabsTexts _tabsTexts() {
    return TabsTexts(
      videoText: "VIDEO",
      galleryText: "GALLERY",
      deletingText: "DELETE",
      clearImagesText: "Delete Selected Photo",
      limitingText: "10 The maximum number of images is",
    );
  }

  Future<void> displayDetails(SelectedImagesDetails details) async {
    await Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) {
          return DisplayImages(
            selectedBytes: details.selectedFiles,
            details: details,
            aspectRatio: details.aspectRatio,
            doctor: widget.client,
            username: widget.username,
            client: widget.client,
          );
        },
      ),
    );
  }
}
