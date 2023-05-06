import 'package:flutter/material.dart';
import 'package:wgnrr/utils/widget/text/text.dart';

class allchoicesShimmerLoading extends StatefulWidget {
  final double width;
  final double height;
  final double commentwidth;
  final double commentheight;
  final double borderRadius;

  allchoicesShimmerLoading(
      {required this.width,
      required this.height,
      required this.commentwidth,
      required this.commentheight,
      required this.borderRadius});

  @override
  _allchoicesShimmerLoadingState createState() =>
      _allchoicesShimmerLoadingState();
}

class _allchoicesShimmerLoadingState extends State<allchoicesShimmerLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _gradientPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    _gradientPosition = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
              alignment: Alignment.topLeft,
              child: Icon(
                Icons.circle,
                color: Colors.grey.shade400,
              )),
        ),
        SizedBox(
          width: widget.width,
          height: widget.height,
          child: AnimatedBuilder(
            animation: _gradientPosition,
            builder: (BuildContext context, _) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  gradient: LinearGradient(
                    begin: Alignment(_gradientPosition.value, 0.0),
                    end: Alignment(-1.0, 0.0),
                    colors: [
                      Colors.grey.shade300,
                      Colors.grey.shade100,
                      Colors.grey.shade300,
                    ],
                    stops: [
                      _gradientPosition.value.abs(),
                      (_gradientPosition.value.abs() + 0.2).clamp(0.0, 1.0),
                      (_gradientPosition.value.abs() + 0.4).clamp(0.0, 1.0),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(children: [
          IconButton(
              onPressed: () async {},
              icon: Icon(
                Icons.share_rounded,
                color: Colors.grey.shade400,
              )),
          IconButton(
            onPressed: () {},
            icon: InkWell(
              onTap: () {},
              child: Icon(
                Icons.chat_bubble,
                color: Colors.grey.shade400,
              ),
            ),
          ),
          Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade400,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(color: Colors.grey.shade500))
                // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                ),
            onPressed: () {},
            child: AppText(
              txt: 'View',
              size: 15,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 10,
          )
        ]),
        SizedBox(
          width: widget.commentwidth,
          height: widget.commentheight,
          child: AnimatedBuilder(
            animation: _gradientPosition,
            builder: (BuildContext context, _) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  gradient: LinearGradient(
                    begin: Alignment(_gradientPosition.value, 0.0),
                    end: Alignment(-1.0, 0.0),
                    colors: [
                      Colors.grey.shade300,
                      Colors.grey.shade100,
                      Colors.grey.shade300,
                    ],
                    stops: [
                      _gradientPosition.value.abs(),
                      (_gradientPosition.value.abs() + 0.2).clamp(0.0, 1.0),
                      (_gradientPosition.value.abs() + 0.4).clamp(0.0, 1.0),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
