import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../assistantMethods/assistant_methods.dart';
import '../global/global.dart';
import '../widgets/order_card.dart';
import '../widgets/progress_bar.dart';
import '../widgets/simple_app_bar.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

// class _HistoryScreenState extends State<HistoryScreen> {
//   final formattedCurrentTime = DateFormat("dd/MM/yyyy HH:mm").format(DateTime.now());
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: SimpleAppBar(title: "History"),
//         body: StreamBuilder<QuerySnapshot>(
//           stream: FirebaseFirestore.instance
//               .collection("users")
//               .doc(sharedPreferences!.getString("uid"))
//               .collection("orders")
//               .where("status", isEqualTo: "ended")
//               .orderBy("orderTime", descending: true)
//               .snapshots(),
//
//     builder: (c, snapshot) {
//             return snapshot.hasData
//                 ? ListView.builder(
//               itemCount: snapshot.data!.docs.length,
//               itemBuilder: (c, index) {
//                 return FutureBuilder<QuerySnapshot>(
//                   future: FirebaseFirestore.instance
//                       .collection("items")
//                       .where("itemID", whereIn: separateOrderItemIDs((snapshot.data!.docs[index].data()! as Map<String,dynamic>) ["productIDs"]))
//                       .where("orderBy", whereIn: (snapshot.data!.docs[index].data()! as Map<String, dynamic>)["uid"])
//                       .orderBy("publishedDate", descending: true)
//                       .get(),
//
//                   builder: (c, snap) {
//                     return snap.hasData
//                         ? Column(
//                             children: [
//                               OrderCard(
//                                 itemCount: snap.data!.docs.length,
//                                 data: snap.data!.docs,
//                                 orderID: snapshot.data!.docs[index].id,
//                                 seperateQuantitiesList: separateOrderItemQuantities(
//                                   (snapshot.data!.docs[index].data()
//                                   as Map<String, dynamic>)["productIDs"],
//                                   flag:formattedCurrentTime.isBefore(deliveryDateTime) || formattedCurrentTime.isAtSameMomentAs(deliveryDateTime);
//                                 ),
//                               ),
//                               Transform.translate(
//                                 offset: Offset(0,-20),
//                                 child: InkWell(
//                                   onTap: () {
//                                     addItemsToCartNew((snapshot.data!.docs[index].data()
//                                     as Map<String, dynamic>)["productIDs"], context, (snapshot.data!.docs[index].data() as Map<String, dynamic>)["sellerUID"]);
//                                   },
//                                   borderRadius: BorderRadius.circular(8),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       color: Colors.blue,
//                                       borderRadius: BorderRadius.circular(8),
//                                     ),
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 40, vertical: 10),
//                                     child: const Text(
//                                       "Reorder",
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontFamily: "Quicksand",
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                     )
//                         : Container();
//                   },
//                 );
//               },
//             )
//                 : Center(child: circularProgress(),);
//           },
//         ),
//       ),
//     );
//   }
// }
class _HistoryScreenState extends State<HistoryScreen> {
  final formattedCurrentTime =
      DateFormat("dd/MM/yyyy HH:mm").format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SimpleAppBar(title: "History"),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(sharedPreferences!.getString("uid"))
              .collection("orders")
              .where("status", isEqualTo: "ended")
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
                        DateTime deliveryDateTime =
                            DateFormat("dd/MM/yyyy HH:mm").parse(deliveryDandT);

                        bool isUpcoming =
                            deliveryDateTime.isAfter(DateTime.now());

                      return FutureBuilder<QuerySnapshot>(
                        future: FirebaseFirestore.instance
                            .collection("items")
                            .where("itemID",
                                whereIn: separateOrderItemIDs(
                                    orderData["productIDs"]))
                            .where("orderBy", whereIn: orderData["uid"])
                            .orderBy("publishedDate", descending: true)
                            .get(),
                        builder: (c, snap) {
                          return snap.hasData
                              ? Column(
                                  children: [
                                    OrderCard(
                                      itemCount: snap.data!.docs.length,
                                      data: snap.data!.docs,
                                      orderID: snapshot.data!.docs[index].id,
                                      seperateQuantitiesList:
                                          separateOrderItemQuantities(
                                              orderData["productIDs"]),
                                      flag: isUpcoming,
                                    ),
                                    Transform.translate(
                                      offset: Offset(0, -20),
                                      child: InkWell(
                                        onTap: () {
                                          addItemsToCartNew(
                                              orderData["productIDs"],
                                              context,
                                              orderData["sellerUID"]);
                                        },
                                        borderRadius: BorderRadius.circular(8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 40,
                                            vertical: 10,
                                          ),
                                          child: const Text(
                                            "Reorder",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Quicksand",
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Container();
                        },
                      );
                    },
                  )
                : Center(
                    child: circularProgress(),
                  );
          },
        ),
      ),
    );
  }
}
