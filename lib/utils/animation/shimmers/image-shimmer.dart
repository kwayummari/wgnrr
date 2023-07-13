import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MyImageWidget extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;

  const MyImageWidget({
    Key? key,
    required this.imageUrl,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Image.network(
        imageUrl,
        fit: BoxFit.fill,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Shimmer.fromColors(
            baseColor: Colors.purple[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              color: Colors.white,
              width: width,
              height: height,
            ),
          );
        },
      ),
    );
  }
}
