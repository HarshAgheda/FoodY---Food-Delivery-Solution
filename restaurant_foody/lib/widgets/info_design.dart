import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../global/global.dart';
import '../mainScreens/itemsScreen.dart';
import '../model/menus.dart';

class InfoDesignWidget extends StatefulWidget {
  Menus? model;
  BuildContext? context;

  InfoDesignWidget({this.model, this.context});

  @override
  _InfoDesignWidgetState createState() => _InfoDesignWidgetState();
}

class _InfoDesignWidgetState extends State<InfoDesignWidget> {
  deleteMenu(String menuID) {
    FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("menus")
        .doc(menuID)
        .delete();

    Fluttertoast.showToast(msg: "Menu deleted successfully!");
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => ItemsScreen(model: widget.model)));
      },
      splashColor: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 140,
              height: 140,
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    widget.model!.thumbnailUrl!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 30),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.model!.menuTitle!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Montserrat",
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.model!.menuInfo!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontFamily: "Lato",
                    ),
                  ),
                ],
              ),
            ),
            // IconButton(
            //   icon: const Icon(
            //     Icons.delete,
            //     color: Colors.redAccent,
            //   ),
            //   onPressed: () {
            //     // Delete menu
            //     deleteMenu(widget.model!.menuID!);
            //   },
            // ),
            Container(
              margin: const EdgeInsets.only(right: 5),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  const BoxShadow(
                    color: Colors.redAccent,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                onPressed: () {
                  // Delete menu
                  deleteMenu(widget.model!.menuID!);
                },
              ),
            )

          ],
        ),
      ),
    );
  }
}
