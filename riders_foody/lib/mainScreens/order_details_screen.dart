import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:riders_foody/widgets/simple_app_bar.dart';

import '../models/address.dart';
import '../widgets/progress_bar.dart';
import '../widgets/shipment_address_design.dart';


class OrderDetailsScreen extends StatefulWidget
{
  final String? orderID;

  OrderDetailsScreen({this.orderID});

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}




class _OrderDetailsScreenState extends State<OrderDetailsScreen>
{
  @override
  void initState() {
    super.initState();
    // Call the function when the page loads
    getImgURL();
    getOrderInfo();
  }
  String orderStatus = "";
  String orderByUser = "";
  String sellerId = "";

  String? SSimageUrl;

  getImgURL()
  {
    FirebaseFirestore.instance.collection("orders").doc(widget.orderID).get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
        SSimageUrl= data["paymentDetails"];
        print("OTP: $SSimageUrl");
      } else {
        print("Document does not exist");
      }
    }).catchError((error) {
      print("Error getting document: $error");
    });
  }

  getOrderInfo()
  {
    FirebaseFirestore.instance
        .collection("orders")
        .doc(widget.orderID).get().then((DocumentSnapshot)
    {
      orderStatus = DocumentSnapshot.data()!["status"].toString();
      orderByUser = DocumentSnapshot.data()!["orderBy"].toString();
      sellerId = DocumentSnapshot.data()!["sellerUID"].toString();
    });
  }



  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: SimpleAppBar(),
      body: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection("orders")
              .doc(widget.orderID)
              .get(),
          builder: (c, snapshot)
          {
            Map? dataMap;
            if(snapshot.hasData)
            {
              dataMap = snapshot.data!.data()! as Map<String, dynamic>;
              orderStatus = dataMap["status"].toString();
            }
            return snapshot.hasData
                ? Column(
                  children: [
                    // StatusBanner(
                    //   status: dataMap!["isSuccess"],
                    //   orderStatus: orderStatus,
                    // ),
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
                          "Order at: ${DateFormat("dd/MM/yyyy hh:mm")
                                  .format(DateTime.fromMillisecondsSinceEpoch(int.parse(dataMap["orderTime"])))}",
                          style: const TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.bold,fontFamily: "Quicksand"),
                        ),
                      ),
                    ),
                    SSimageUrl!="" ? Column(
                      children: [
                        const Text("Payment Screenshot : ",                        style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold,fontFamily: "Quicksand"),),
                        Image.network(
                          SSimageUrl!,
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.width * 1.0,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ):const Text("Cash On Delivery Order",style: TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.bold,fontFamily: "Quicksand"),),
                    const Divider(thickness: 4,),
                    // orderStatus == "ended"
                    //     ? Image.asset("images/success.jpg")
                    //     : Image.asset("images/confirm_pick.png"),
                    // const Divider(thickness: 4,),
                    FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection("users")
                          .doc(orderByUser)
                          .collection("userAddress")
                          .doc(dataMap["addressID"])
                          .get(),
                      builder: (c, snapshot)
                      {
                      // DateFormat("dd MMMM, yyyy - hh:mm aa")
                      //     .format(DateTime.fromMillisecondsSinceEpoch(int.parse(dataMap?["orderTime"])));
                      return snapshot.hasData
                            ? ShipmentAddressDesign(
                          model: Address.fromJson(
                              snapshot.data!.data()! as Map<String, dynamic>
                          ),
                          orderStatus: orderStatus,
                          orderId: widget.orderID,
                          sellerId: sellerId,
                          orderByUser: orderByUser,
                        )
                            : Center(child: circularProgress(),);
                      },
                    ),
                  ],
                )
                : Center(child: circularProgress(),);
          },
        ),
      ),
    );
  }
}