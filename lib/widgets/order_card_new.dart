import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../mainScreens/order_details_screen.dart';
import '../models/items.dart';


class OrderCardNew extends StatelessWidget {
  final int? itemCount;
  final List<DocumentSnapshot>? data;
  final String? orderID;
  final List<String>? seperateQuantitiesList;

  OrderCardNew({
    this.itemCount,
    this.data,
    this.orderID,
    this.seperateQuantitiesList,
  });

  List<String?>?  temp;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (c) => OrderDetailsScreen(orderID: orderID)),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: const BoxDecoration(),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            height: itemCount! * 125 + 40,
            child: ListView.builder(
              itemCount: itemCount,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                Items model =
                Items.fromJson(data![index].data()! as Map<String, dynamic>);
                if(temp?.length == 0) {
                  temp?.add("garbageValue");
                }
                temp?.add(model.itemID);
                return placedOrderDesignWidget(
                    model, context, seperateQuantitiesList![index],index==itemCount! -1 );
              },
            ),
          ),
          // if (itemCount == data!.length) // Show reorder button only after the last item
            // InkWell(
            //   onTap: () {
            //     // Handle reorder button action
            //   },
            //   borderRadius: BorderRadius.circular(8),
            //   child: Container(
            //     margin:
            //     const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            //     decoration: BoxDecoration(
            //       color: Colors.blue,
            //       borderRadius: BorderRadius.circular(8),
            //     ),
            //     padding:
            //     const EdgeInsets.symmetric(horizontal: 120, vertical: 10),
            //     child: const Text(
            //       "Reorder",
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontFamily: "Quicksand",
            //         fontSize: 16,
            //       ),
            //     ),
            //   ),
            // ),
        ],
      ),
    );
  }
  Widget placedOrderDesignWidget(Items model, BuildContext context,
      seperateQuantitiesList, bool isLastItem) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  model.thumbnailUrl!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        model.title!,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: "GeneralSans",
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          const Text(
                            "x ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            seperateQuantitiesList,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: "Quicksand",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "₹ ${model.price.toString()}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Quicksand",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        //TODO---------------------------
        // if (isLastItem)
        //   Column(
        //     children: [
        //       SizedBox(height:5),
        //       InkWell(
        //         onTap: ()   {
        //           addItemsToCart(temp, context, seperateQuantitiesList, model.sellerUID!);
        //         },
        //         borderRadius: BorderRadius.circular(8),
        //         child: Container(
        //           margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        //           decoration: BoxDecoration(
        //             color: Colors.green,
        //             borderRadius: BorderRadius.circular(8),
        //           ),
        //           padding:
        //           const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        //           child: const Text(
        //             "Reorder",
        //             style: TextStyle(
        //               color: Colors.white,
        //               fontFamily: "Quicksand",
        //               fontSize: 15,
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
      ],
    );

  }
}

