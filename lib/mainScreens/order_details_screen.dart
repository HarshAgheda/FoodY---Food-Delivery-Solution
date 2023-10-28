import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../global/global.dart';
import '../models/address.dart';
import '../widgets/progress_bar.dart';
import '../widgets/shipment_address_design.dart';
import '../widgets/simple_app_bar.dart';


class OrderDetailsScreen extends StatefulWidget
{
  final String? orderID;

  OrderDetailsScreen({this.orderID});

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}


class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  String orderStatus = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: "${widget.orderID}"),
      body: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection("orders")
              .doc(widget.orderID)
              .get(),
          builder: (c, snapshot) {
            Map? dataMap;
            if (snapshot.hasData) {
              dataMap = snapshot.data!.data()! as Map<String, dynamic>;
              orderStatus = dataMap["status"].toString();
            }
            return snapshot.hasData
                ? Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Bill Amount : ₹  ${dataMap!["totalAmount"]}",
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Quicksand"
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5.0,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.1),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Order Id = ${widget.orderID!}",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Quicksand"
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Order at: ${DateFormat("dd MMMM, yyyy - hh:mm aa")
                            .format(DateTime.fromMillisecondsSinceEpoch(
                            int.parse(dataMap["orderTime"])))}",
                        style: const TextStyle(fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Quicksand"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "OTP:  ${dataMap["OTP"]}",
                        style: const TextStyle(fontSize: 20,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Quicksand"),
                      ),
                    ),
                  ),
                  const Divider(thickness: 4,),
                  FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection("users")
                        .doc(sharedPreferences!.getString("uid"))
                        .collection("userAddress")
                        .doc(dataMap["addressID"])
                        .get(),
                    builder: (c, snapshot) {
                      return snapshot.hasData
                          ? ShipmentAddressDesign(
                        model: Address.fromJson(
                            snapshot.data!.data()! as Map<String, dynamic>
                        ),
                      )
                          : Center(child: circularProgress(),);
                    },
                  ),
                ],
              ),
            )
                : Center(child: circularProgress(),);
          },
        ),
      ),
    );
  }
}
