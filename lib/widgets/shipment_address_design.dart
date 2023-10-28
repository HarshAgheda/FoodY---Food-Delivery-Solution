import 'package:flutter/material.dart';

import '../models/address.dart';
import '../splashScreen/splash_screen.dart';

class ShipmentAddressDesign extends StatelessWidget
{
  final Address? model;

  ShipmentAddressDesign({this.model});



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'Shipping Details',
            style: TextStyle(color: Colors.black, fontSize: 24,fontFamily: "GeneralSans"),
          ),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Name",
                style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: "Quicksand"),
              ),
              const SizedBox(height: 4),
              Text(
                model!.name!,
                style: const TextStyle(color: Colors.black, fontSize: 16,fontFamily: "InterMedium"),
              ),
              const SizedBox(height: 12),
              const Text(
                "Contact No.",
                style: TextStyle(color: Colors.black, fontSize: 20,fontFamily: "Quicksand"),
              ),
              const SizedBox(height: 4),
              Text(
                model!.phoneNumber!,
                style: const TextStyle(color: Colors.black, fontSize: 16,fontFamily: "InterMedium"),
              ),
              const SizedBox(height: 12),
              const Text(
                "Address",
                style: TextStyle(color: Colors.black, fontSize:20, fontFamily: "Quicksand" ),
              ),
              const SizedBox(height: 4),
              Text(
                model!.fullAddress!,
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 16,fontFamily: "InterMedium"),
              ),
            ],
          ),
        ),
        const SizedBox(height: 50),
        Center(
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            borderRadius: BorderRadius.circular(8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
              child: const Text(
                "Go Back",
                style: TextStyle(color: Colors.white, fontSize: 18,fontFamily: "Quicksand"),
              ),
            ),
          ),
        ),
      ],
    );
  }

// Widget build(BuildContext context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.all(10.0),
  //         child: Text(
  //           'Shipping Details:',
  //           style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
  //         ),
  //       ),
  //       const SizedBox(height: 6.0),
  //       Container(
  //         padding: EdgeInsets.symmetric(horizontal: 10.0),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               "Name: ${model!.name!}",
  //               style: TextStyle(color: Colors.black, fontSize: 16),
  //             ),
  //             const SizedBox(height: 8),
  //             Text(
  //               "Phone Number: ${model!.phoneNumber!}",
  //               style: TextStyle(color: Colors.black, fontSize: 16),
  //             ),
  //             const SizedBox(height: 16),
  //             Text(
  //               "Address: ${model!.fullAddress!}",
  //               textAlign: TextAlign.justify,
  //               style: TextStyle(fontSize: 16),
  //             ),
  //           ],
  //         ),
  //       ),
  //       const SizedBox(height: 20),
  //       Center(
  //         child: InkWell(
  //           onTap: () {
  //             Navigator.push(context, MaterialPageRoute(builder: (context) => const MySplashScreen()));
  //           },
  //           borderRadius: BorderRadius.circular(8),
  //           child: Container(
  //             decoration: BoxDecoration(
  //               color: Colors.blue,
  //               borderRadius: BorderRadius.circular(8),
  //             ),
  //             padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
  //             child: Text(
  //               "Go Back",
  //               style: TextStyle(color: Colors.white, fontSize: 18),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

// Widget build(BuildContext context)
  // {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const Padding(
  //         padding: EdgeInsets.all(10.0),
  //         child: Text(
  //             'Shipping Details:',
  //             style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
  //         ),
  //       ),
  //       const SizedBox(
  //         height: 6.0,
  //       ),
  //       Container(
  //         padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 5),
  //         width: MediaQuery.of(context).size.width,
  //         child: Table(
  //           children: [
  //             TableRow(
  //               children: [
  //                 const Text(
  //                   "Name",
  //                   style: TextStyle(color: Colors.black),
  //                 ),
  //                 Text(model!.name!),
  //               ],
  //             ),
  //             TableRow(
  //               children: [
  //                 const Text(
  //                   "Phone Number",
  //                   style: TextStyle(color: Colors.black),
  //                 ),
  //                 Text(model!.phoneNumber!),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //       const SizedBox(
  //         height: 20,
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.all(10.0),
  //         child: Text(
  //           model!.fullAddress!,
  //           textAlign: TextAlign.justify,
  //         ),
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.all(10.0),
  //         child: Center(
  //           child: InkWell(
  //             onTap: ()
  //             {
  //               Navigator.push(context, MaterialPageRoute(builder: (context) => const MySplashScreen()));
  //             },
  //             child: Container(
  //               decoration: const BoxDecoration(
  //                   gradient: LinearGradient(
  //                     colors: [
  //                       Colors.cyan,
  //                       Colors.amber,
  //                     ],
  //                     begin:  FractionalOffset(0.0, 0.0),
  //                     end:  FractionalOffset(1.0, 0.0),
  //                     stops: [0.0, 1.0],
  //                     tileMode: TileMode.clamp,
  //                   )
  //               ),
  //               width: MediaQuery.of(context).size.width - 40,
  //               height: 50,
  //               child: const Center(
  //                 child: Text(
  //                   "Go Back",
  //                   style: TextStyle(color: Colors.white, fontSize: 15.0),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
