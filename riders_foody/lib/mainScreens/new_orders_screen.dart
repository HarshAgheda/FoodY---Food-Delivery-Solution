import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../assistantMethods/assistant_methods.dart';
import '../widgets/order_card.dart';
import '../widgets/progress_bar.dart';
import '../widgets/simple_app_bar.dart';


class NewOrdersScreen extends StatefulWidget
{
  @override
  _NewOrdersScreenState createState() => _NewOrdersScreenState();
}


class _NewOrdersScreenState extends State<NewOrdersScreen>
{
  final formattedCurrentTime = DateFormat("dd/MM/yyyy HH:mm").format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SimpleAppBar(title: "New Orders",),  //title: "New Orders",
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("orders")
              .where("status", isEqualTo: "normal")
              .where("DeliveryDandT", isLessThanOrEqualTo: formattedCurrentTime.toString())
              .orderBy("DeliveryDandT", descending: true)
              .snapshots(),

          builder: (c, snapshot)
          {
            if (snapshot.hasData) {
              return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (c, index)
                    {
                      return FutureBuilder<QuerySnapshot>(
                        future: FirebaseFirestore.instance
                            .collection("items")
                            .where("itemID", whereIn: separateOrderItemIDs((snapshot.data!.docs[index].data()! as Map<String, dynamic>) ["productIDs"]))
                            .where("orderBy", whereIn: (snapshot.data!.docs[index].data()! as Map<String, dynamic>)["uid"])
                            .orderBy("publishedDate", descending: true)
                            .get(),
                        builder: (c, snap)
                        {
                          return snap.hasData
                              ? OrderCard(
                            itemCount: snap.data!.docs.length,
                            data: snap.data!.docs,
                            orderID: snapshot.data!.docs[index].id,
                            seperateQuantitiesList: separateOrderItemQuantities((snapshot.data!.docs[index].data()! as Map<String, dynamic>)["productIDs"]),
                          )
                              : Center(child: circularProgress());
                        },
                      );
                    },
                  );
            } else {
              return Center(child: circularProgress(),);
            }
          },
        ),
      );
  }
}
