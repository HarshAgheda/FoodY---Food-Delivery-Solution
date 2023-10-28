import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../assistantMethods/assistant_methods.dart';
import '../global/global.dart';
import '../widgets/order_card.dart';
import '../widgets/progress_bar.dart';
import '../widgets/simple_app_bar.dart';

class MyOrdersScreen extends StatefulWidget
{
  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();
}


class _MyOrdersScreenState extends State<MyOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SimpleAppBar(title: "Orders",),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(sharedPreferences!.getString("uid"))
              .collection("orders")
              .where("status", isEqualTo: "normal")
              .orderBy("orderTime", descending: true)
              .snapshots(),
          builder: (c, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (c, index) {
                Map<String, dynamic> orderData =
                snapshot.data!.docs[index].data()!
                as Map<String, dynamic>;

                // Convert deliveryDandT to DateTime and format it
                String deliveryDandT = orderData["DeliveryDandT"];
                DateTime deliveryDateTime = DateFormat("dd/MM/yyyy HH:mm").parse(deliveryDandT);
                bool isUpcoming = deliveryDateTime.isAfter(DateTime.now());

                bool f = false;
                if (orderData["DeleveryEndDate"] != null) {
                  DateTime deliveryEndDate = DateFormat("dd/MM/yyyy").parse(
                      orderData["DeleveryEndDate"]);
                  f = deliveryEndDate.isBefore(DateTime.now());
                  print(deliveryEndDate);
                  // Now you can proceed with your comparison logic
                }
                if (f == true) //completed order
                {
                 isUpcoming = false;
                }
                  return FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collection("items")
                      .where("itemID", whereIn: separateOrderItemIDs((snapshot.data!.docs[index].data()! as Map<String,dynamic>) ["productIDs"]))
                      .where("orderBy", whereIn: (snapshot.data!.docs[index].data()! as Map<String, dynamic>)["uid"])
                      .orderBy("publishedDate", descending: true)
                      .get(),
                  builder: (c, snap) {
                    return snap.hasData
                        ? OrderCard(
                      itemCount: snap.data!.docs.length,
                      data: snap.data!.docs,
                      orderID: snapshot.data!.docs[index].id,
                      seperateQuantitiesList: separateOrderItemQuantities((snapshot.data!.docs[index].data()! as Map<String,dynamic>)["productIDs"]),
                      flag: isUpcoming,
                    )
                        : Center(child: circularProgress());
                  },
                );
              },
            )
                : Center(child: circularProgress(),);
          },
        ),
      ),
    );
  }
}