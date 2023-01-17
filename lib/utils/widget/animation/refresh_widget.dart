// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class RefreshWidget extends StatefulWidget {
  final Widget child;
  final Future Function() onRefresh;

  const RefreshWidget({
    Key? key,
    required this.onRefresh,
    required this.child,
  }) : super(key: key);

  @override
  _RefreshWidgetState createState() => _RefreshWidgetState();
}

class _RefreshWidgetState extends State<RefreshWidget> {
  @override
  Widget build(BuildContext context) =>
      Platform.isAndroid ? buildAndroidList() : buildIOSList();

  Widget buildAndroidList() => RefreshIndicator(
        color: HexColor('#cbdd33'),
        onRefresh: widget.onRefresh,
        child: widget.child,
      );

  Widget buildIOSList() => CustomScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        slivers: [
          CupertinoSliverRefreshControl(onRefresh: widget.onRefresh),
          SliverToBoxAdapter(child: widget.child),
        ],
      );
}
