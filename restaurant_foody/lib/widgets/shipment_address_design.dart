import 'package:flutter/material.dart';

import '../model/address.dart';
import '../splashScreen/splash_screen.dart';



class ShipmentAddressDesign extends StatelessWidget
{
  final Address? model;
  final String? orderStatus;
  final String? orderId;
  final String? sellerId;
  final String? orderByUser;

  bool tapped=false;
  ShipmentAddressDesign({this.model, this.orderStatus, this.orderId, this.sellerId, this.orderByUser});


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
                    "Name                    :         ${model!.name!}",
                    style: const TextStyle(color: Colors.black, fontFamily: "Montserrat",fontSize: 18),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Text(
                    "Contact No          :         ${model!.phoneNumber!}",
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

        // Center(
        //   child: InkWell(
        //     onTap: () {
        //       tapped=true;// Toggle the text when the button is tapped
        //     },
        //     borderRadius: BorderRadius.circular(8),
        //     child: Container(
        //       decoration: BoxDecoration(
        //         color: Colors.deepPurple,
        //         borderRadius: BorderRadius.circular(8),
        //       ),
        //       width: MediaQuery.of(context).size.width - 40,
        //       height: 50,
        //       child: Center(
        //         child: Text(
        //           tapped ? "Accepted" : "Accept Order",
        //           style: TextStyle(
        //             color: Colors.white,
        //             fontSize: 18,
        //             fontWeight: FontWeight.bold,
        //             fontFamily: "Quicksand",
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        // orderStatus!="ended"?
        // YourStatefulWidget():Container(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
              child:InkWell(
                onTap: () {
                  Navigator.pop(context);
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


class YourStatefulWidget extends StatefulWidget {
  @override
  _YourStatefulWidgetState createState() => _YourStatefulWidgetState();
}

class _YourStatefulWidgetState extends State<YourStatefulWidget> {
bool tapped = false;

@override
Widget build(BuildContext context) {
  return Center(
    child: InkWell(
      onTap: () {
        setState(() {
          tapped = true;
        });
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(8),
        ),
        width: MediaQuery.of(context).size.width - 40,
        height: 50,
        child: Center(
          child: Text(
            tapped ? "Accepted" : "Accept Order",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: "Quicksand",
            ),
          ),
        ),
      ),
    ),
  );
}
}