import 'package:flutter/material.dart';
import 'package:foody/mainScreens/cart_screen.dart';
import 'package:provider/provider.dart';

import '../assistantMethods/cart_Item_counter.dart';


class MyAppBar extends StatefulWidget implements PreferredSizeWidget
{
  final PreferredSizeWidget? bottom;
  final String? sellerUID;

  MyAppBar({this.bottom, this.sellerUID});

  @override
  _MyAppBarState createState() => _MyAppBarState();

  @override
  Size get preferredSize => bottom==null?Size(56, AppBar().preferredSize.height):Size(56, 80+AppBar().preferredSize.height);
}

class _MyAppBarState extends State<MyAppBar>
{
  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        color:  Color(0xFF5893D4),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: ()
        {
          Navigator.pop(context);
        },
      ),
      title: const Text(
        "Foody",
        style: TextStyle(fontSize: 25, fontFamily:"GeneralSans"),
      ),
      centerTitle: true,
      automaticallyImplyLeading: true,
      actions: [
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_cart, color: Colors.white,size: 25,),
              onPressed: ()
              {
                //send user to cart screen
                Navigator.push(context,MaterialPageRoute(builder: (c)=>CartScreen(sellerUID: widget.sellerUID)));
              },
            ),
            Positioned(
              child: Stack(
                children: [
                  const Icon(
                    Icons.brightness_1,
                    size: 20.0,
                    color: Colors.yellow,
                  ),
                  Positioned(
                    top: 2.5,
                    right: 6.5,
                    child: Center(
                      child: Consumer<CartItemCounter>(
                        builder: (context, counter, c)
                        {
                          return Text(
                            counter.count.toString(),
                            style: const TextStyle(color: Colors.black, fontSize: 12,fontFamily:"GeneralSans"),
                          );
                        },
                      ),
                      ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );

  }
}
