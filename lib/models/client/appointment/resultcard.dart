import 'package:flutter/material.dart';
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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      height: isExpanded ? 200 : 150,
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
                Text(
                  'Pain: ${widget.pain}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Blood: ${widget.blood}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Timeline: ${widget.timeline}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Fever: ${widget.fever}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
