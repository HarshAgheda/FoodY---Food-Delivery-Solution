import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../global/global.dart';
import '../model/items.dart';
import '../splashScreen/splash_screen.dart';
import '../widgets/simple_app_bar.dart';


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
      appBar: SimpleAppBar(title: sharedPreferences!.getString("name"),),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset:const Offset(0, 2),
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
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "₹ ${widget.model!.price}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "Quicksand",
                  fontSize: 35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
