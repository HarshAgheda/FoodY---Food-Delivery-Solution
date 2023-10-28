import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:restaurant_foody/mainScreens/item_detail_screen.dart';

import '../global/global.dart';
import '../model/items.dart';
import '../splashScreen/splash_screen.dart';

class ItemsDesignWidget extends StatefulWidget {
  Items? model;
  BuildContext? context;

  ItemsDesignWidget({this.model, this.context});

  @override
  _ItemsDesignWidgetState createState() => _ItemsDesignWidgetState();
}


class _ItemsDesignWidgetState extends State<ItemsDesignWidget> {

  deleteItem(String itemID)
  {
    FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("menus")
        .doc(widget.model!.menuID!)
        .collection("items")
        .doc(itemID)
        .delete().then((value)
    {
      FirebaseFirestore.instance
          .collection("items")
          .doc(itemID)
          .delete();

      Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
      Fluttertoast.showToast(msg: "Item Deleted Successfully.");
    });
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemDetailsScreen(model: widget.model)));
      },
      splashColor: Colors.yellow[100],
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
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
            const SizedBox(width: 40),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.model!.title!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Montserrat",
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.model!.shortInfo!,
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
                Container(
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.redAccent,
                        spreadRadius: 2,
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
                      deleteItem(widget.model!.itemID!);
                    },
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
