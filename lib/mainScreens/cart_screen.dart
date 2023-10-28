import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foody/mainScreens/home_screen.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import '../assistantMethods/assistant_methods.dart';
import '../assistantMethods/cart_Item_counter.dart';
import '../assistantMethods/total_amount.dart';
import '../models/items.dart';
import '../widgets/cart_item_design.dart';
import '../widgets/orderDateTime.dart';
import '../widgets/progress_bar.dart';
import '../widgets/text_widget_header.dart';
import 'address_screen.dart';

class CartScreen extends StatefulWidget {
  final String? sellerUID;

  CartScreen({this.sellerUID});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<int>? separateItemQuantityList;
  num totalAmount = 0;
  //CHANGED-----------------
  DateTime? selectedDateTime = DateTime.now();
  bool isRepeatOrder = false;
  Future<void> _selectDateTime() async {
    final DateTime? selectedDateTime = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return OrderDateTimeDialog(
          onDateTimeSelected: (DateTime selectedDateTime) {
            setState(() {
              this.selectedDateTime = selectedDateTime;
            });
            // This function is required, but we only need to pass the selectedDateTime to the parent widget.
          },
        );
      },
    );

    if (selectedDateTime != null) {
      setState(() {
        this.selectedDateTime = selectedDateTime;
      });
    }
  }

  DateTime? selectedDate;
  final TextEditingController dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: currentDate,
      lastDate: currentDate.add(const Duration(days: 365)),
    );

    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
        // dateController.text = DateFormat("dd/MM/yyyy").format(selectedDate!);
      });
    }
  }

  @override
  void initState() {
    super.initState();

    totalAmount = 0;
    Provider.of<TotalAmount>(context, listen: false).displayTotalAmount(0);

    separateItemQuantityList = separateItemQuantities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          color: const Color(0xFF5893D4),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // clears cart too
            Navigator.push(
                context, MaterialPageRoute(builder: (c) => const HomeScreen()));
            // clearCartNow(context);
          },
        ),
        title: const Text(
          "Foody",
          style: TextStyle(fontSize: 25, fontFamily: "GeneralSans"),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Container(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: TextWidgetHeader(
                title: "My Cart",
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("items")
                  .where("itemID", whereIn: separateItemIDs())
                  .orderBy("publishedDate", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                return !snapshot.hasData
                    ? SliverToBoxAdapter(
                        child: Center(
                          child: circularProgress(),
                        ),
                      )
                    : snapshot.data!.docs.isEmpty
                        ? Container()
                        : SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                Items model = Items.fromJson(
                                  snapshot.data!.docs[index].data()!
                                      as Map<String, dynamic>,
                                );

                                if (index == 0) {
                                  totalAmount = 0;
                                  totalAmount = totalAmount +
                                      (model.price! *
                                          separateItemQuantityList![index]);
                                } else {
                                  totalAmount = totalAmount +
                                      (model.price! *
                                          separateItemQuantityList![index]);
                                }

                                if (snapshot.data!.docs.length - 1 == index) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((timeStamp) {
                                    Provider.of<TotalAmount>(context,
                                            listen: false)
                                        .displayTotalAmount(
                                            totalAmount.toDouble());
                                  });
                                }
                                return CartItemDesign(
                                  model: model,
                                  context: context,
                                  quanNumber: separateItemQuantityList![index],
                                );
                              },
                              childCount: snapshot.hasData
                                  ? snapshot.data!.docs.length
                                  : 0,
                            ),
                          );
              },
            ),
            SliverToBoxAdapter(
              child: Consumer2<TotalAmount, CartItemCounter>(
                  builder: (context, amountProvider, cartProvider, c) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: cartProvider.count == 0
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Text(
                              "Total Amount :  ₹ ${amountProvider.tAmount.toInt()}",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                  fontFamily: "Montserrat"),
                            ),
                          ),
                  ),
                );
              }),
            ),
            // Select Date and Time button
            // const SizedBox(height: 5),
            SliverToBoxAdapter(
               child : Padding(
                 padding: const EdgeInsets.only(left: 10.0,right:10.0,top:15.0),
                 child: CheckboxListTile(
                    title: const Text(
                      "Repeat Order?",
                      style: TextStyle(
                        fontSize: 22,
                        // fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontFamily: "Quicksand",
                      ),
                    ),
                    value: isRepeatOrder,
                    onChanged: (value) {
                      setState(() {
                        isRepeatOrder = value!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Colors.orange, // Change the checkbox color
                    checkColor: Colors.white, // Change the checkmark color
                    tileColor: Colors.orange.withOpacity(0.3),
                 // Change the background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.grey), // Add border color
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                  ),
               ),
            ),

            isRepeatOrder == true ? SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10.0),
                    child: TextFormField(
                      readOnly: true,
                      onTap: _selectDateTime,
                      controller: TextEditingController(
                        text: selectedDateTime != null
                            ? DateFormat("dd/MM/yyyy HH:mm:ss")
                                .format(selectedDateTime!)
                            : "Select Start Date and Time",
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        labelText: "Start Date and Time",
                        labelStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 25),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        suffixIcon: const Icon(
                          Icons.calendar_today,
                          color: Colors.blue,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10.0),
                    child: TextFormField(
                      readOnly: true,
                      controller: TextEditingController(
                        text: selectedDate != null
                            ? DateFormat("dd/MM/yyyy").format(selectedDate!)
                            : "Select End Date",
                      ),
                      // dateController,
                      onTap: () {
                        _selectDate(context);
                      },
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        labelText: "End Date",
                        labelStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 25),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        suffixIcon: const Icon(
                          Icons.calendar_today,
                          color: Colors.blue,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                ],
              ),
            )
            : SliverToBoxAdapter(),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(
            width: 20,
          ),
          Align(
            alignment: Alignment
                .bottomLeft, // Align to the bottom center of the screen
            child: FloatingActionButton.extended(
              heroTag: 'btn1',
              label: const Text(
                "Clear Cart",
                style: TextStyle(fontSize: 18, fontFamily: "Quicksand"),
              ),
              backgroundColor: Colors.cyan[400],
              icon: const Icon(Icons.clear_all),
              onPressed: () {
                clearCartNow(context);

                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => const HomeScreen()));

                Fluttertoast.showToast(msg: "Cart has been cleared.");
              },
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment
                .bottomRight, // Align to the bottom center of the screen
            child: FloatingActionButton.extended(
              heroTag: 'btn2',
              label: const Text(
                "Check Out",
                style: TextStyle(fontSize: 18, fontFamily: "Quicksand"),
              ),
              backgroundColor: Colors.green,
              icon: const Icon(Icons.navigate_next),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddressScreen(
                      totalAmount: totalAmount.toDouble(),
                      sellerUID: widget.sellerUID,
                      selectedDateTime:
                          selectedDateTime,
                      selectedEndDate: selectedDate,// Pass the selected date and time to AddressScreen
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
