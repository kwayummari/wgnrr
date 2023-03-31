import 'package:flutter/material.dart';

class homeShimmerLoading extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;
  final double innerwidth;
  final double innerheight;

  homeShimmerLoading(
      {required this.width, required this.height, required this.borderRadius, required this.innerheight, required this.innerwidth});

  @override
  _homeShimmerLoadingState createState() => _homeShimmerLoadingState();
}

class _homeShimmerLoadingState extends State<homeShimmerLoading>
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
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Column(
        children: [
          SizedBox(
            width: widget.innerwidth,
            height: widget.innerheight,
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
          Row(
            children: [
              SizedBox(
            width: widget.innerwidth,
            height: widget.innerheight,
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
          SizedBox(width: 20,),
              SizedBox(
                width: widget.innerwidth,
                height: widget.innerheight,
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
          ),
          Row(
            children: [
              SizedBox(
            width: widget.innerwidth,
            height: widget.innerheight,
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
          SizedBox(width: 20,),
              SizedBox(
                width: widget.innerwidth,
                height: widget.innerheight,
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
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
