import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final Widget aTitle;
  final Color bcolor;

  const CustomAppBar({Key key, this.aTitle, this.height,this.bcolor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: bcolor,
      title: aTitle,
      centerTitle: true,
      elevation: 0.0,
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
