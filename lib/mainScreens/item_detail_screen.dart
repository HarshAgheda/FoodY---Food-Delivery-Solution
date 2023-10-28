import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

import '../assistantMethods/assistant_methods.dart';
import '../models/items.dart';
import '../widgets/app_bar.dart';

class ItemDetailsScreen extends StatefulWidget {
  final Items? model;
  ItemDetailsScreen({this.model});

  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  TextEditingController counterTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(sellerUID: widget.model!.sellerUID),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    widget.model!.thumbnailUrl.toString(),
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: 200.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                widget.model!.title.toString(),
                style: const TextStyle(
                  fontFamily: "Quicksand",
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),
            ),
            const SizedBox(height: 5.0,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                widget.model!.longDescription.toString(),
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontFamily: "Quicksand",
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                "₹" + widget.model!.price.toString(),
                style: const TextStyle(
                  fontFamily: "Quicksand",
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.withOpacity(0.5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        // margin: EdgeInsets.symmetric(horizontal: 5),
        // color: Colors.grey.withOpacity(0.4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 15,),
            Container(
              width: 130,
              child: NumberInputPrefabbed.roundedButtons(
                scaleWidth: 1,
                controller: counterTextEditingController,
                incDecBgColor:  Colors.orange.withOpacity(0.8),
                min: 1,
                max: 9,
                initialValue: 1,
                style: TextStyle(fontFamily: "Quicksand"),
                buttonArrangement: ButtonArrangement.incRightDecLeft,
              ),
            ),
            const SizedBox(width: 30),
            Expanded(
              child: InkWell(
                onTap: () {
                  int itemCounter = int.parse(counterTextEditingController.text);

                  List<String> separateItemIDsList = separateItemIDs();

                  //1.check if item exists already in cart
                  separateItemIDsList.contains(widget.model!.itemID)
                      ? Fluttertoast.showToast(msg: "Item is already in Cart.")
                      :
                  //2.add to cart
                  addItemToCart(widget.model!.itemID, context, itemCounter);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.orange[500],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 50,
                  child: const Center(
                    child: Text(
                      "Add to Cart",
                      style: TextStyle(color: Colors.white, fontSize: 22,fontFamily: "Quicksand"),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
