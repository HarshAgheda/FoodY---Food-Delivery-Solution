import 'package:flutter/material.dart';
import 'package:foody/mainScreens/menus_screen.dart';

import '../models/sellers.dart';

class SellersDesignWidget extends StatefulWidget {
  Sellers? model; //receiving two params(sellers & context)
  BuildContext? context;

  SellersDesignWidget({this.model, this.context});

  @override
  _SellersDesignWidgetState createState() => _SellersDesignWidgetState();
}

class _SellersDesignWidgetState extends State<SellersDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (c) => MenusScreen(model: widget.model)),
        );
      },
      splashColor: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: Colors.grey.withOpacity(0.15),
              width: 4,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.model!.sellerAvatarUrl!,
                  height: 180.0,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                widget.model!.sellerName!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontFamily: "Quicksand",
                  // fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5.0),
            ],
          ),
        ),
      ),
    );
  }
}


// class _SellersDesignWidgetState extends State<SellersDesignWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (c) => MenusScreen(model: widget.model)),
//         );
//       },
//       splashColor: Colors.amber,
//       child: Padding(
//         padding: const EdgeInsets.all(5.0),
//         child: Container(
//           height: 225,
//           width: MediaQuery.of(context).size.width,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center, // Align items in the center vertically
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: Image.network(
//                   widget.model!.sellerAvatarUrl!,
//                   height: 180.0,
//                   width: double.infinity,
//                   fit: BoxFit.fitWidth,
//                 ),
//               ),
//               const SizedBox(height: 5.0),
//               Center(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                   child: Text(
//                     widget.model!.sellerName!,
//                     textAlign: TextAlign.center, // Align text in the center
//                     style: const TextStyle(
//                       color: Colors.black,
//                       fontSize: 25,
//                       fontFamily: "Quicksand",
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 5.0),
//               Divider(
//                 height: 1,
//                 thickness: 1,
//                 color: Colors.grey[300],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

//
// class _SellersDesignWidgetState extends State<SellersDesignWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (c) => MenusScreen(model: widget.model)),
//         );
//       },
//       splashColor: Colors.amber,
//       child: Padding(
//         padding: const EdgeInsets.all(5.0),
//         child: Container(
//           height: 280,
//           width: MediaQuery.of(context).size.width,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: Image.network(
//                   widget.model!.sellerAvatarUrl!,
//                   height: 180.0,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               const SizedBox(height: 10.0),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                 child: Text(
//                   widget.model!.sellerName!,
//                   style: const TextStyle(
//                     color: Colors.black,
//                     fontSize: 20,
//                     fontFamily: "Quicksand",
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10.0),
//               Divider(
//                 height: 1,
//                 thickness: 1,
//                 color: Colors.grey[300],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

//
// class _SellersDesignWidgetState extends State<SellersDesignWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (c) => MenusScreen(model: widget.model)));
//       },
//       splashColor: Colors.amber,
//       child: Padding(
//         padding: const EdgeInsets.all(5.0),
//
//         child: Container(
//           height: 280,
//           width: MediaQuery.of(context).size.width,
//           child: Column(
//             children: [
//               Divider(
//                 height: 1,
//                 thickness: 1,
//                 color: Colors.grey[300],
//               ),
//               Image.network(
//                 widget.model!.sellerAvatarUrl!,
//                 height: 220.0,
//                 fit: BoxFit.cover,
//               ),
//               const SizedBox(height: 10.0,),
//               Text(
//                 widget.model!.sellerName!,
//                 style: const TextStyle(
//                   color: Colors.black,
//                   fontSize: 25,
//                   fontFamily: "Quicksand",
//                 ),
//               ),
//               Divider(
//                 height: 1,
//                 thickness: 1,
//                 color: Colors.grey[300],
//               ),
//             ],
//           ),
//         ),
//         // child: Container(
//         //   height: 280,
//         //   width: MediaQuery.of(context).size.width,
//         //   child: Column(
//         //     children: [
//         //       Divider(
//         //         height: 4,
//         //         thickness: 3,
//         //         color: Colors.grey[300],
//         //       ),
//         //       Image.network(
//         //           widget.model!.sellerAvatarUrl!,
//         //           height: 100.0,
//         //         fit: BoxFit.cover,
//         //       ),
//         //       const SizedBox(height: 1.0,),
//         //       Text(
//         //         widget.model!.sellerName!,
//         //         style: const TextStyle(
//         //           color: Colors.cyan,
//         //           fontSize: 20,
//         //           fontFamily: "Quicksand",
//         //         ),
//         //       ),
//         //       Text(
//         //         widget.model!.sellerEmail!,
//         //         style: const TextStyle(
//         //           color: Colors.grey,
//         //           fontSize: 12,
//         //         ),
//         //       ),
//         //       Divider(
//         //         height: 4,
//         //         thickness: 3,
//         //         color: Colors.grey[300],
//         //       ),
//         //     ],
//         //   ),
//         // ),
//       ),
//     );
//   }
// }
