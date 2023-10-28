import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../assistantMethods/get_current_location.dart';
import '../global/global.dart';
import '../mainScreens/parcel_picking_screen.dart';
import '../models/address.dart';



class ShipmentAddressDesign extends StatelessWidget
{
  final Address? model;
  final String? orderStatus;
  final String? orderId;
  final String? sellerId;
  final String? orderByUser;

  ShipmentAddressDesign({this.model, this.orderStatus, this.orderId, this.sellerId, this.orderByUser});



  confirmedParcelShipment(BuildContext context, String getOrderID, String sellerId, String purchaserId)
  {
    FirebaseFirestore.instance
        .collection("orders")
        .doc(getOrderID)
        .update({
      "riderUID": sharedPreferences!.getString("uid"),
      "riderName": sharedPreferences!.getString("name"),
      "status": "picking",
      "lat": position!.latitude,
      "lng": position!.longitude,
      "address": completeAddress,
    });

    //send rider to shipmentScreen
    Navigator.push(context, MaterialPageRoute(builder: (context) => ParcelPickingScreen(
      purchaserId: purchaserId,
      purchaserAddress: model!.fullAddress,
      purchaserLat: model!.lat,
      purchaserLng: model!.lng,
      sellerId: sellerId,
      getOrderID: getOrderID,
    )));
  }



  @override
  Widget build(BuildContext context)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
              'Delivery Details : ',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: "Montserrat",fontSize: 18)
          ),
        ),
        const SizedBox(
          height: 6.0,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          width: MediaQuery.of(context).size.width,
          child: Table(
            children: [
              TableRow(
                children: [
                  Text(
                    "Name                    :         " + model!.name!,
                    style: const TextStyle(color: Colors.black, fontFamily: "Montserrat",fontSize: 18),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Text(
                    "Contact No          :         " + model!.phoneNumber!,
                    style: const TextStyle(color: Colors.black, fontFamily: "Montserrat",fontSize: 18),
                  ),
                  // Text(model!.phoneNumber!),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            model!.fullAddress!,
            textAlign: TextAlign.justify,
            style: const TextStyle(fontFamily: "Montserrat",fontSize: 16),
          ),
        ),


        orderStatus == "ended"
            ? Container()
        : Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: InkWell(
                onTap: ()
                {
                  UserLocation uLocation = UserLocation();
                  uLocation.getCurrentLocation();
                  confirmedParcelShipment(context, orderId!, sellerId!, orderByUser!);
                },
              borderRadius: BorderRadius.circular(8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8),
                ),
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                child: const Center(
                  child:  Text(
                    "Accept delivery request",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: "Quicksand"),
                  ),
                ),
              ),
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
                // Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
              },
              borderRadius: BorderRadius.circular(8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(8),
                ),
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                child: const Center(
                  child: Text(
                    "Go Back",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: "Quicksand"),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20,),
      ],
    );
  }
}