import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../assistantMethods/address_changer.dart';
import '../mainScreens/placed_order_screen.dart';
import '../maps/maps.dart';
import '../models/address.dart';

class AddressDesign extends StatefulWidget
{
  final Address? model;
  final int? currentIndex;
  final int? value;
  final String? addressID;
  final double? totalAmount;
  final String? sellerUID;
  final DateTime? selectedDateTime;
  final DateTime? selectedEndDate;

  AddressDesign({
    this.model,
    this.currentIndex,
    this.value,
    this.addressID,
    this.totalAmount,
    this.sellerUID,
    this.selectedDateTime,
    this.selectedEndDate,
  });

  @override
  _AddressDesignState createState() => _AddressDesignState();
}


class _AddressDesignState extends State<AddressDesign> {
  @override
  // Widget build(BuildContext context) {
  //   return InkWell(
  //     onTap: () {
  //       // Select this address
  //       // );
  //       Provider.of<AddressChanger>(context, listen: false).displayResult(widget.value);
  //     },
  //     child: Card(
  //       color: Color(0xFFE1F5FE).withOpacity(0.6),
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10.0),
  //         side: BorderSide(color: Color(0xFFE1F5FE).withOpacity(0.5), width: 2.0),
  //       ),
  //       child: Padding(
  //         padding: const EdgeInsets.symmetric(vertical: 8.0),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Row(
  //               children: [
  //                 Radio(
  //                   groupValue: widget.currentIndex!,
  //                   value: widget.value!,
  //                   activeColor: Colors.green,
  //                   onChanged: (val) {
  //                     // Provider
  //                     Provider.of<AddressChanger>(context, listen: false).displayResult(val);
  //                     print(val);
  //                   },
  //                 ),
  //                 SizedBox(width: 5.0),
  //                 Expanded(
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       buildInfoRow("Name ", widget.model!.name.toString()),
  //                       buildInfoRow("Phone Number ", widget.model!.phoneNumber.toString()),
  //                       buildInfoRow("Flat Number ", widget.model!.flatNumber.toString()),
  //                       buildInfoRow("City ", widget.model!.city.toString()),
  //                       buildInfoRow("State ", widget.model!.state.toString()),
  //                       buildInfoRow("Full Address ", widget.model!.fullAddress.toString()),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             SizedBox(height: 5.0),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: [
  //                 ElevatedButton(
  //                   child: const Text("Check on Maps"),
  //                   style: ElevatedButton.styleFrom(
  //                     primary: Colors.orange[500],
  //                     textStyle: const TextStyle(color: Colors.white, fontSize: 16 ,fontFamily: "GeneralSans"),
  //                   ),
  //                   onPressed: () {
  //                     // Open maps with address
  //                     MapsUtils.openMapWithAddress(widget.model!.fullAddress!);
  //                   },
  //                 ),
  //                 SizedBox(width: 10.0),
  //                 if (widget.value == Provider.of<AddressChanger>(context).count)
  //                   ElevatedButton(
  //                     child: const Text("Proceed"),
  //                     style: ElevatedButton.styleFrom(
  //                       primary: Colors.green,
  //                       textStyle: const TextStyle(color: Colors.white, fontSize: 16,fontFamily: "GeneralSans"),
  //                     ),
  //                     onPressed: () {
  //                       // Proceed to placed order screen
  //                       Navigator.push(
  //                         context,
  //                         MaterialPageRoute(
  //                           builder: (c) => PlacedOrderScreen(
  //                             addressID: widget.addressID,
  //                             totalAmount: widget.totalAmount,
  //                             sellerUID: widget.sellerUID,
  //                             selectedDateTime : widget.selectedDateTime,
  //                           ),
  //                         ));
  //                     },
  //                   ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Select this address
        // );
        Provider.of<AddressChanger>(context, listen: false).displayResult(widget.value);
      },
      child: Card(
        color: const Color(0xFFE1F5FE).withOpacity(0.7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: const Color(0xFFE1F5FE).withOpacity(0.5), width: 2.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Radio(
                    groupValue: widget.currentIndex!,
                    value: widget.value!,
                    activeColor: Colors.green,
                    onChanged: (val) {
                      // Provider
                      Provider.of<AddressChanger>(context, listen: false).displayResult(val);
                      print(val);
                    },
                  ),
                  const SizedBox(width: 5.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10,),
                        buildInfoRow("Name ", widget.model!.name.toString()),
                        buildInfoRow("Phone Number ", widget.model!.phoneNumber.toString()),
                        // buildInfoRow("Flat Number ", widget.model!.flatNumber.toString()),
                        // buildInfoRow("City ", widget.model!.city.toString()),
                        // buildInfoRow("State ", widget.model!.state.toString()),
                        buildInfoRow("Full Address ", widget.model!.fullAddress.toString()),
                        const SizedBox(height: 10,),
                      ],
                    ),
                  ),
                ],
              ),
              // const SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 40.0,
                    width:140,
                    decoration: BoxDecoration(
                      color: Colors.orange[500],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton(
                      onPressed: () {
                        // Open maps with address
                        MapsUtils.openMapWithAddress(widget.model!.fullAddress!);
                      },
                      child: const Text(
                        "Check on Maps",
                        style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: "Quicksand"),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  if (widget.value == Provider.of<AddressChanger>(context).count)
                    Container(
                      height: 40.0,
                      width:100,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextButton(
                        onPressed: () {
                          // Proceed to placed order screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (c) => PlacedOrderScreen(
                                addressID: widget.addressID,
                                totalAmount: widget.totalAmount,
                                sellerUID: widget.sellerUID,
                                selectedDateTime: widget.selectedDateTime,
                                selectedEndDate: widget.selectedEndDate,
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          "Proceed",
                          style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: "Quicksand"),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(String fieldName, String fieldValue) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$fieldName: ",
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              fontFamily: "Montserrat",
            ),
          ),
          const SizedBox(width: 4.0),
          Expanded(
            child: Text(
              fieldValue,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontFamily: "Quicksand",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

