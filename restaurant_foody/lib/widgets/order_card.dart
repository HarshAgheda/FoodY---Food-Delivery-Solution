import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../mainScreens/order_details_screen.dart';
import '../model/items.dart';



class OrderCard extends StatelessWidget
{
  final int? itemCount;
  final List<DocumentSnapshot>? data;
  final String? orderID;
  final List<String>? seperateQuantitiesList;

  OrderCard({
    this.itemCount,
    this.data,
    this.orderID,
    this.seperateQuantitiesList,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> OrderDetailsScreen(orderID: orderID)));
      },
      child: Container(
         // padding: const EdgeInsets.only(top:10),
        margin: const EdgeInsets.only(top: 20 ),
        height: itemCount! * 125,
         child: ListView.builder(
          itemCount: itemCount,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index)
          {
            Items model = Items.fromJson(data![index].data()! as Map<String, dynamic>);
            return placedOrderDesignWidget(model, context, seperateQuantitiesList![index]);
          },
        ),
      ),
    );
  }
}

Widget placedOrderDesignWidget(Items model, BuildContext context, seperateQuantitiesList) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 120,
    margin: const EdgeInsets.only(top: 5,right: 5.0,left: 5),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: NetworkImage(model.thumbnailUrl!),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 15.0),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 20),
                Text(
                  model.title!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style:const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: "Quicksand",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "x ",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                            fontFamily: "Quicksand",
                          ),
                        ),
                        Text(
                          seperateQuantitiesList,
                          style:const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: "Quicksand",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    // const SizedBox(width: 150,),
                    // Text(
                    //   "₹ ${model.price.toString()}",
                    //   style: TextStyle(
                    //     color: Colors.black,
                    //     fontSize: 18.0,
                    //     fontWeight: FontWeight.bold,
                    //     fontFamily: "Quicksand",
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 35.0),
          child: Text(
            "₹ ${model.price.toString()}",
            style:const TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              fontFamily: "Quicksand",
            ),
          ),
        ),
      ],
    ),
  );
}
