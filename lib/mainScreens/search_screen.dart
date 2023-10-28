import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/sellers.dart';
import '../widgets/sellers_design.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Future<QuerySnapshot>? restaurantsDocumentsList;
  String sellerNameText = "";

  initSearchingRestaurant(String textEntered) {
    restaurantsDocumentsList = FirebaseFirestore.instance
        .collection("sellers")
        .where("sellerName", isGreaterThanOrEqualTo: textEntered)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Container(
          margin: const EdgeInsets.fromLTRB(15, 5, 35, 5),
          child: TextField(
            onChanged: (textEntered) {
              setState(() {
                sellerNameText = textEntered;
              });
              initSearchingRestaurant(textEntered);
            },
            decoration: InputDecoration(
              hintText: "Search restaurants here...",
              hintStyle: const TextStyle(
                  color: Colors.white, fontSize: 18, fontFamily: "GeneralSans"),
              border: InputBorder.none,
              suffixIcon: IconButton(
                icon: const Icon(Icons.search, size: 28),
                color: Colors.white,
                onPressed: () {
                  initSearchingRestaurant(sellerNameText);
                },
              ),
            ),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: "GeneralSans",
            ),
          ),
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: restaurantsDocumentsList,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    Sellers model = Sellers.fromJson(snapshot.data!.docs[index]
                        .data()! as Map<String, dynamic>);

                    return SellersDesignWidget(
                      model: model,
                      context: context,
                    );
                  },
                )
              : const Center(
                  child: Text(
                    "No Record Found",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontFamily: "Quicksand",
                    ),
                  ),
                );
        },
      ),
    );
  }
}
