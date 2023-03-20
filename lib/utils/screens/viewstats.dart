// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, non_constant_identifier_names, duplicate_ignore, prefer_const_constructors, body_might_complete_normally_nullable, prefer_if_null_operators, no_leading_underscores_for_local_identifiers, unused_element, avoid_print, unused_label

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wgnrr/api/const.dart';
import 'package:wgnrr/models/health_care_provider/feedback/feedback.dart';
import 'package:wgnrr/utils/animation/fade_animation.dart';
import 'package:wgnrr/utils/widget/text/text.dart';

class ViewStats extends StatefulWidget {
  var username;
  var author;
  var date;
  var title;
  var caption;
  var description;
  var image;
  // ignore: non_constant_identifier_names
  ViewStats(
      {Key? key,
      required this.username,
      required this.author,
      required this.date,
      required this.title,
      required this.caption,
      required this.image,
      required this.description})
      : super(key: key);

  @override
  State<ViewStats> createState() => _ViewStatsState();
}

class _ViewStatsState extends State<ViewStats> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: FadeAnimation(
                1.2,
                CachedNetworkImage(
                  imageUrl: '${murl}stats/image/${widget.image}',
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Container(
                    height: 400,
                    width: double.infinity,
                    color: Colors.black,
                    child: Center(
                      child: CircularProgressIndicator(
                        value: downloadProgress.progress,
                        color: Colors.white,
                        strokeWidth: 3,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                )),
          ),
          Positioned(
            top: 50,
            left: 10,
            child: FadeAnimation(
              1.2,
              CircleAvatar(
                backgroundColor: HexColor('#981EE4'),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: mediaQuery.size.height / 1.5,
            child: FadeAnimation(
              1.2,
              Container(
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: HexColor('#981EE4')),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeAnimation(
                        1.3,
                        Center(
                          child: Text(
                            '${widget.title}',
                            style: GoogleFonts.vesperLibre(
                              color: HexColor('#000000'),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Divider(
                        color: HexColor('#981EE4'),
                      ),
                      FadeAnimation(
                        1.3,
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: HexColor('#981EE4'),
                              child: Icon(Icons.calendar_month,
                                  color: HexColor('#ffffff')),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Date -${widget.date}',
                              style: GoogleFonts.vesperLibre(
                                color: HexColor('#000000'),
                                // fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FadeAnimation(
                        1.3,
                        Row(
                          children: [
                            CircleAvatar(
                                backgroundColor: HexColor('#981EE4'),
                                child: Icon(Icons.person,
                                    color: HexColor('#ffffff'))),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Author -${widget.author}',
                              style: GoogleFonts.vesperLibre(
                                color: HexColor('#000000'),
                                // fontSize: 1,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(
                        color: HexColor('#981EE4'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Caption',
                        style: GoogleFonts.vesperLibre(
                          color: HexColor('#981EE4'),
                          fontSize: 18,
                          height: 1.4,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Center(
                          child: FadeAnimation(
                            1.3,
                            Text(
                              '${widget.caption}',
                              style: GoogleFonts.vesperLibre(
                                color: HexColor('#000000'),
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Description',
                        style: GoogleFonts.vesperLibre(
                          color: HexColor('#981EE4'),
                          fontSize: 18,
                          height: 1.4,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: FadeAnimation(
                          1.4,
                          Text(
                            '${widget.description}',
                            style: GoogleFonts.vesperLibre(
                              color: HexColor('#000000'),
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Quiz())),
                        child: Container(
                          margin: const EdgeInsets.all(15.0),
                          padding: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: Row(
                            children: [
                              Icon(Icons.feedback),
                              AppText(
                                txt: 'Provide feedback',
                                size: 20,
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}