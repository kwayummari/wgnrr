import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  final Function onPress;
  final Icon icon;

  const AppIconButton({Key? key, required this.onPress, required this.icon,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: () => onPress(), icon: icon);
  }
}
