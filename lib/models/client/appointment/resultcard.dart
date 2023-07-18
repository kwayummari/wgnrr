import 'package:flutter/material.dart';
import 'package:wgnrr/utils/widget/richtext/richtext.dart';
import 'package:wgnrr/utils/widget/text/text.dart';

class PatientResultsCard extends StatefulWidget {
  final String client;
  final String doctor;
  final String blood;
  final String pain;
  final String smell;
  final String fever;
  final String questionare;
  final String procedure;
  final String timeline;

  const PatientResultsCard({
    required this.client,
    required this.doctor,
    required this.blood,
    required this.pain,
    required this.smell,
    required this.fever,
    required this.questionare,
    required this.procedure,
    required this.timeline,
  });

  @override
  _PatientResultsCardState createState() => _PatientResultsCardState();
}

class _PatientResultsCardState extends State<PatientResultsCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return widget.procedure == 'Procedure - Medical'
        ? AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            height: isExpanded ? 250 : 70,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        txt: widget.timeline +
                            'hrs after ${widget.procedure == 'Procedure - Surgical' ? 'Surgical procedure' : 'Medical Procedure'}',
                        size: 20,
                        weight: FontWeight.bold,
                      ),
                      IconButton(
                        icon: isExpanded
                            ? const Icon(Icons.keyboard_arrow_up)
                            : const Icon(Icons.keyboard_arrow_down),
                        onPressed: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                      ),
                    ],
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: isExpanded ? 1.0 : 0.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.questionare == '-')
                          richText(
                            header: 'Emaotional Status: ',
                            trailer:
                                'We cannot determine your emotional status since it not yet 7 hours after ${widget.procedure}',
                          )
                        else if (int.parse(widget.questionare) >= 10)
                          richText(
                            header: 'Emaotional Status: ',
                            trailer: 'Possible Depression',
                          )
                        else
                          richText(
                            header: 'Emaotional Status: ',
                            trailer: 'You are fine',
                          ),
                        if (int.parse(widget.timeline) < 7 &&
                            widget.pain == 'Worst Pain Possible')
                          richText(
                            header: 'Pain: ',
                            trailer:
                                'You feel ${widget.pain} pain which is normal for now',
                          ),
                        if (int.parse(widget.timeline) == 6 &&
                            widget.pain == 'Severe')
                          richText(
                            header: 'Pain: ',
                            trailer:
                                'You feel ${widget.pain} pain which is normal for now',
                          )
                        else if (int.parse(widget.timeline) == 12 &&
                            (widget.pain == 'Severe' ||
                                widget.pain == 'Moderate'))
                          richText(
                            header: 'Pain: ',
                            trailer:
                                'You feel ${widget.pain} pain which is normal for now',
                          )
                        else if ((int.parse(widget.timeline) <= 48 ||
                                int.parse(widget.timeline) >= 24) &&
                            widget.pain == 'Mild')
                          richText(
                            header: 'Pain: ',
                            trailer:
                                'You feel ${widget.pain} pain which is normal for now',
                          )
                        else if (int.parse(widget.timeline) >= 168 &&
                            widget.pain == 'No Pain')
                          richText(
                            header: 'Pain: ',
                            trailer:
                                'You feel ${widget.pain} pain which is normal for now',
                          )
                        else
                          richText(
                            header: 'Pain: ',
                            trailer:
                                'You feel ${widget.pain}, please contact your health care provider',
                          ),
                        if (int.parse(widget.timeline) == 12 &&
                            widget.blood == '3-4')
                          richText(
                            header: 'Blood: ',
                            trailer:
                                'You used ${widget.blood} pads  which is normal for now',
                          )
                        else if (int.parse(widget.timeline) == 24 &&
                            widget.blood == '3-4')
                          richText(
                            header: 'Blood: ',
                            trailer:
                                'You used ${widget.blood} pads  which is normal for now',
                          )
                        else if (int.parse(widget.timeline) == 168 &&
                            widget.blood == '2-3')
                          richText(
                            header: 'Blood: ',
                            trailer:
                                'You used ${widget.blood} pads  which is normal for now',
                          )
                        else if (int.parse(widget.timeline) == 4018 &&
                            widget.blood == '1-2')
                          richText(
                            header: 'Blood: ',
                            trailer:
                                'You used ${widget.blood} pads  which is normal for now',
                          )
                        else if (int.parse(widget.timeline) > 4018 &&
                            widget.blood == '0')
                          richText(
                            header: 'Blood: ',
                            trailer:
                                'You used ${widget.blood} pads  which is normal for now',
                          )
                        else
                          richText(
                            header: 'Blood: ',
                            trailer:
                                'You used ${widget.blood} pads please contact your health care provider',
                          ),
                        if (int.parse(widget.timeline) >= 0 &&
                            widget.fever == 'No')
                          richText(
                            header: 'Fever: ',
                            trailer:
                                'You have ${widget.fever} fever  which is normal for now',
                          )
                        else
                          richText(
                            header: 'Fever: ',
                            trailer:
                                'You have ${widget.fever} fever  please contact your health care provider',
                          ),
                        if (int.parse(widget.timeline) >= 0 &&
                            widget.smell == 'No')
                          richText(
                            header: 'Smell: ',
                            trailer:
                                'You have ${widget.smell} Foul smell Vaginal Discharge  which is normal for now',
                          )
                        else
                          richText(
                            header: 'Smell: ',
                            trailer:
                                'You have ${widget.smell} Foul smell Vaginal Discharge please contact your health care provider',
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            height: isExpanded ? 220 : 60,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        txt: widget.timeline +
                            'hrs after ${widget.procedure == 'Procedure - Surgical' ? 'Surgical procedure' : 'Medical Procedure'}',
                        size: 20,
                        weight: FontWeight.bold,
                      ),
                      IconButton(
                        icon: isExpanded
                            ? const Icon(Icons.keyboard_arrow_up)
                            : const Icon(Icons.keyboard_arrow_down),
                        onPressed: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                      ),
                    ],
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: isExpanded ? 1.0 : 0.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.questionare == '-')
                          richText(
                            header: 'Emaotional Status: ',
                            trailer:
                                'We cannot determine your emotional status since it not yet 7 hours after ${widget.procedure}',
                          )
                        else if (int.parse(widget.questionare) >= 10)
                          richText(
                            header: 'Emaotional Status: ',
                            trailer: 'Possible Depression',
                          )
                        else
                          richText(
                            header: 'Emaotional Status: ',
                            trailer: 'You are fine',
                          ),
                        if (int.parse(widget.timeline) < 24 &&
                            widget.pain == 'Very Severe')
                          richText(
                            header: 'Pain: ',
                            trailer:
                                'You feel ${widget.pain} pain which is normal for now',
                          )
                        else if (int.parse(widget.timeline) == 24 &&
                            widget.pain == 'Mild')
                          richText(
                            header: 'Pain: ',
                            trailer:
                                'You feel ${widget.pain} pain which is normal for now',
                          )
                        else if (int.parse(widget.timeline) >= 48 &&
                            widget.pain == 'No Pain')
                          richText(
                            header: 'Pain: ',
                            trailer:
                                'You feel ${widget.pain} pain which is normal for now',
                          )
                        else
                          richText(
                            header: 'Pain: ',
                            trailer:
                                'You feel ${widget.pain}, please contact your health care provider',
                          ),
                        if (int.parse(widget.timeline) <= 72 &&
                            widget.blood == '1-2')
                          richText(
                            header: 'Blood: ',
                            trailer:
                                'You used ${widget.blood} pads  which is normal for now',
                          )
                        else if (int.parse(widget.timeline) >= 168 &&
                            int.parse(widget.blood) == 0)
                          richText(
                            header: 'Blood: ',
                            trailer:
                                'You used ${widget.blood} pads  which is normal for now',
                          )
                        else
                          richText(
                            header: 'Blood: ',
                            trailer:
                                'You used ${widget.blood} than 2 pads please contact your health care provider',
                          ),
                        if (int.parse(widget.timeline) >= 0 &&
                            widget.fever == 'No')
                          richText(
                            header: 'Fever: ',
                            trailer:
                                'You have ${widget.fever} fever  which is normal for now',
                          )
                        else
                          richText(
                            header: 'Fever: ',
                            trailer:
                                'You have ${widget.fever} fever  please contact your health care provider',
                          ),
                        if (int.parse(widget.timeline) >= 0 &&
                            widget.smell == 'No')
                          richText(
                            header: 'Smell: ',
                            trailer:
                                'You have ${widget.smell} Foul smell Vaginal Discharge  which is normal for now',
                          )
                        else
                          richText(
                            header: 'Smell: ',
                            trailer:
                                'You have ${widget.smell} Foul smell Vaginal Discharge please contact your health care provider',
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
