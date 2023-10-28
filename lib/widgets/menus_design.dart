import 'package:flutter/material.dart';

import '../mainScreens/items_screen.dart';
import '../models/menus.dart';


class MenusDesignWidget extends StatefulWidget
{
  Menus? model;
  BuildContext? context;

  MenusDesignWidget({this.model, this.context});

  @override
  _MenusDesignWidgetState createState() => _MenusDesignWidgetState();
}



class _MenusDesignWidgetState extends State<MenusDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemsScreen(model: widget.model)));
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
                      fontWeight: FontWeight.w500,
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
          ],
        ),
      ),

      // child: Padding(
      //   padding: const EdgeInsets.all(5.0),
      //   child: Container(
      //     height: 280,
      //     width: MediaQuery.of(context).size.width,
      //     child: Column(
      //       children: [
      //         Divider(
      //           height: 4,
      //           thickness: 3,
      //           color: Colors.grey[300],
      //         ),
      //         Image.network(
      //           widget.model!.thumbnailUrl!,
      //           height: 220.0,
      //           fit: BoxFit.cover,
      //         ),
      //         const SizedBox(height: 1.0,),
      //         Text(
      //           widget.model!.menuTitle!,
      //           style: const TextStyle(
      //             color: Colors.cyan,
      //             fontSize: 20,
      //             fontFamily: "Quicksand",
      //           ),
      //         ),
      //         Text(
      //           widget.model!.menuInfo!,
      //           style: const TextStyle(
      //             color: Colors.grey,
      //             fontSize: 12,
      //           ),
      //         ),
      //         Divider(
      //           height: 4,
      //           thickness: 3,
      //           color: Colors.grey[300],
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}