import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foody/mainScreens/save_address_screen.dart';

import 'package:provider/provider.dart';

import '../assistantMethods/address_changer.dart';
import '../global/global.dart';
import '../models/address.dart';
import '../widgets/address_design.dart';
import '../widgets/progress_bar.dart';
import '../widgets/simple_app_bar.dart';


class AddressScreen extends StatefulWidget
{
  final double? totalAmount;
  final String? sellerUID;
  final DateTime? selectedDateTime;
  final DateTime? selectedEndDate;
  AddressScreen({this.totalAmount, this.sellerUID, this.selectedDateTime,this.selectedEndDate});


  @override
  _AddressScreenState createState() => _AddressScreenState();
}


//
// class _AddressScreenState extends State<AddressScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: SimpleAppBar(title: "Foody"),
//       floatingActionButton: FloatingActionButton.extended(
//         label: const Text("Add New Address"),
//         backgroundColor: Colors.cyan,
//         icon: const Icon(Icons.add_location, color: Colors.white,),
//         onPressed: () {
//           //save address to user collection
//           Navigator.push(context, MaterialPageRoute(builder: (c)=> SaveAddressScreen()));
//         },
//       ),
//       body: CustomScrollView(
//         slivers: [
//           SliverPersistentHeader(
//             pinned: true,
//             delegate: TextWidgetHeader(title: "Select Address"),
//           ),
//           SliverToBoxAdapter(
//             child: Consumer<AddressChanger>(builder: (context, address, c) {
//               return StreamBuilder<QuerySnapshot>(
//                 stream: FirebaseFirestore.instance.collection("users")
//                     .doc(sharedPreferences!.getString("uid"))
//                     .collection("userAddress")
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   return !snapshot.hasData
//                       ? Center(child: circularProgress(),)
//                       : snapshot.data!.docs.length == 0
//                       ? Container()
//                       : ListView.builder(
//                     itemCount: snapshot.data!.docs.length,
//                     shrinkWrap: true,
//                     itemBuilder: (context, index) {
//                       return AddressDesign(
//                         currentIndex: address.count,
//                         value: index,
//                         addressID: snapshot.data!.docs[index].id,
//                         totalAmount: widget.totalAmount,
//                         sellerUID: widget.sellerUID,
//                         model: Address.fromJson(
//                             snapshot.data!.docs[index].data()! as Map<String, dynamic>
//                         ),
//                       );
//                     },
//                   );
//                 },
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }


class _AddressScreenState extends State<AddressScreen>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: "Select Address"),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Add New Address",
        style: TextStyle(
          fontFamily: "Quicksand",
          fontSize: 15
        ),),
        backgroundColor: Colors.blue[500],
        icon: const Icon(Icons.add_location, color: Colors.white,),
        onPressed: ()
        {
          //save address to user collection
          Navigator.push(context, MaterialPageRoute(builder: (c)=> SaveAddressScreen()));
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 15,top: 20,bottom: 10),
              child: Text(
                  "Select Address:",
                style: TextStyle(
                    color: Colors.black,
                    // fontWeight: FontWeight.bold,
                  fontFamily: "Quicksand",
                    fontSize: 20,
                ),
              ),
            ),
          ),

          Consumer<AddressChanger>(builder: (context, address, c){
            return Flexible(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("users")
                    .doc(sharedPreferences!.getString("uid"))
                    .collection("userAddress")
                    .snapshots(),
                builder: (context, snapshot)
                {
                  return !snapshot.hasData
                      ? Center(child: circularProgress(),)
                      : snapshot.data!.docs.length == 0
                      ? Container()
                      : ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index)
                            {
                              return AddressDesign(
                                currentIndex: address.count,
                                value: index,
                                addressID: snapshot.data!.docs[index].id,
                                totalAmount: widget.totalAmount,
                                sellerUID: widget.sellerUID,
                                selectedDateTime: widget.selectedDateTime,
                                selectedEndDate: widget.selectedEndDate,
                              model: Address.fromJson(
                                  snapshot.data!.docs[index].data()! as Map<String, dynamic>
                                ),
                              );
                            },
                        );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
