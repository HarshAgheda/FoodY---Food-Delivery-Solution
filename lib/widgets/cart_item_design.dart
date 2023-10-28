import 'package:flutter/material.dart';

import '../models/items.dart';


class CartItemDesign extends StatefulWidget
{
  final Items? model;
  BuildContext? context;
  final int? quanNumber;

  CartItemDesign({
    this.model,
    this.context,
    this.quanNumber,
  });

  @override
  _CartItemDesignState createState() => _CartItemDesignState();
}

class _CartItemDesignState extends State<CartItemDesign> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.yellow[100],
      child: Padding(
        padding: const EdgeInsets.only(top:5,left: 5,right: 5),
        child: Container(
          height: 120,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image
              Container(
                width: 120,
                height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    widget.model!.thumbnailUrl!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Title
                    Text(
                      widget.model!.title!,
                      style: const TextStyle(
                        fontSize: 20,
                        // fontWeight: FontWeight.bold,
                        fontFamily: "Quicksand",
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Quantity
                    Row(
                      children: [
                        const Text(
                          "x ",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: "Quicksand",
                          ),
                        ),
                        Text(
                          widget.quanNumber.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Quicksand",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5.0,),
                    // Price
                    Row(
                      children: [
                        // Text(
                        //   "Price: ",
                        //   style: TextStyle(
                        //     fontSize: 16,
                        //     color: Colors.black,
                        //     fontFamily: "Quicksand",
                        //   ),
                        // ),
                        Text(
                          "₹ ${(widget.quanNumber! * widget.model!.price!)}",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            // fontWeight: FontWeight.bold,
                            fontFamily: "Quicksand",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class _CartItemDesignState extends State<CartItemDesign> {
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       splashColor: Colors.yellow[100],
//       child: Padding(
//         padding: const EdgeInsets.all(6.0),
//         child: Container(
//           height: 100,
//           width: MediaQuery.of(context).size.width,
//           child: Row(
//             children: [
//               //image
//               Image.network(widget.model!.thumbnailUrl!, width: 140, height: 120,),
//
//               const SizedBox(width: 6,),
//
//               //title
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   //title
//                   Text(
//                     widget.model!.title!,
//                     style: const TextStyle(
//                       color: Colors.black,
//                       fontSize: 16,
//                       fontFamily: "Kiwi",
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 1,
//                   ),
//
//                   //quantity number // x 7
//                   Row(
//                     children: [
//                       const Text(
//                         "x ",
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 25,
//                           fontFamily: "Acme",
//                         ),
//                       ),
//                       Text(
//                         widget.quanNumber.toString(),
//                         style: const TextStyle(
//                           color: Colors.black,
//                           fontSize: 25,
//                           fontFamily: "Acme",
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   //price
//                   Row(
//                     children: [
//                       const Text(
//                         "Price: ",
//                         style: TextStyle(
//                           fontSize: 15,
//                           color: Colors.grey,
//                         ),
//                       ),
//                       const Text(
//                         "€ ",
//                         style: TextStyle(
//                             color: Colors.blue,
//                             fontSize: 16.0
//                         ),
//                       ),
//                       Text(
//                           widget.model!.price.toString(),
//                           style: const TextStyle(
//                             fontSize: 16,
//                             color: Colors.blue,
//                           )
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
