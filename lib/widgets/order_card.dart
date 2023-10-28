import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../mainScreens/order_details_screen.dart';
import '../models/items.dart';

class OrderCard extends StatelessWidget {
  final int? itemCount;
  final List<DocumentSnapshot>? data;
  final String? orderID;
  final List<String>? seperateQuantitiesList;
  final bool? flag;

  OrderCard({
    this.itemCount,
    this.data,
    this.orderID,
    this.seperateQuantitiesList,
    this.flag,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => OrderDetailsScreen(orderID: orderID)));
      },
      child: Container(
        decoration: const BoxDecoration(
            // gradient: LinearGradient(
            //   colors: [
            //     Colors.black12,
            //     Colors.white54,
            //   ],
            //   begin:  FractionalOffset(0.0, 0.0),
            //   end:  FractionalOffset(1.0, 0.0),
            //   stops: [0.0, 1.0],
            //   tileMode: TileMode.clamp,
            // )
            ),
        // padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        height: flag == true ? itemCount! * 100 + 68 : itemCount! * 100 + 20,
        child: ListView.builder(
          itemCount: itemCount,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            Items model =
                Items.fromJson(data![index].data()! as Map<String, dynamic>);

            return Column(
              children: [
                if (flag == true) Container(
                        margin: const EdgeInsets.only(
                            left: 270.0, top: 8.0, bottom: 8.0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 6.0),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: const Text(
                          "Recurring",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Quicksand",
                          ),
                        ),
                      ) else Container(),
                placedOrderDesignWidget(
                    model, context, seperateQuantitiesList![index]),
              ],
            );
          },
        ),
      ),
    );
  }
}

Widget placedOrderDesignWidget(
    Items model, BuildContext context, seperateQuantitiesList) {
  return Container(
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
          offset: const Offset(0, 3),
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
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  model.title!,
                  style: const TextStyle(
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
  );
}

// Widget placedOrderDesignWidget(Items model, BuildContext context, seperateQuantitiesList)
// {
//   return Container(
//     width: MediaQuery.of(context).size.width,
//     height: 120,
//     color: Colors.grey[200],
//     child: Row(
//       children: [
//         Image.network(model.thumbnailUrl!, width: 120,),
//         const SizedBox(width: 10.0,),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//
//               const SizedBox(
//                 height: 20,
//               ),
//
//               Row(
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   Expanded(
//                     child: Text(
//                       model.title!,
//                       style: const TextStyle(
//                         color: Colors.black,
//                         fontSize: 16,
//                         fontFamily: "Acme",
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   const Text(
//                     "₹ ",
//                     style: TextStyle(fontSize: 16.0, color: Colors.blue),
//                   ),
//                   Text(
//                     model.price.toString(),
//                     style: const TextStyle(
//                       color: Colors.blue,
//                       fontSize: 18.0,
//                     ),
//                   ),
//                 ],
//               ),
//
//               const SizedBox(
//                 height: 20,
//               ),
//
//               Row(
//                 children: [
//                   const Text(
//                       "x ",
//                       style: TextStyle(
//                         color: Colors.black54,
//                         fontSize: 14,
//                       ),
//                   ),
//                   Expanded(
//                     child: Text(
//                       seperateQuantitiesList,
//                       style: const TextStyle(
//                         color: Colors.black54,
//                         fontSize: 30,
//                         fontFamily: "Acme",
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }
