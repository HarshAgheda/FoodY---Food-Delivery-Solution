import 'package:flutter/material.dart';


class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget
{
  String? title;
  final PreferredSizeWidget? bottom;

  SimpleAppBar({this.bottom, this.title});

  @override
  Size get preferredSize => bottom==null?Size(56, AppBar().preferredSize.height):Size(56, 80+AppBar().preferredSize.height);


  @override
  Widget build(BuildContext context)
  {
    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      flexibleSpace: Container(
        color: Colors.orange[600],
      ),
      centerTitle: true,
      title: const Text(
        "Foody",
        style: const TextStyle(fontSize: 25, fontFamily: "GeneralSans"),
      ),
    );
  }
}
