import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foody/assistantMethods/cart_Item_counter.dart';
import 'package:foody/mainScreens/cart_screen.dart';
import 'package:provider/provider.dart';

import '../global/global.dart';


separateOrderItemIDs(orderIDs)  // orderIDs -> productIDs list in each order
{
  List<String> separateItemIDsList=[], defaultItemList=[];
  int i=0;

  defaultItemList = List<String>.from(orderIDs);

  for(i; i<defaultItemList.length; i++)
  {
    //56557657:7
    String item = defaultItemList[i].toString();
    var pos = item.lastIndexOf(":");

    //56557657
    String getItemId = (pos != -1) ? item.substring(0, pos) : item;

    print("\nThis is itemID now = " + getItemId);

    separateItemIDsList.add(getItemId);
  }

  print("\nThis is Items List now = ");
  print(separateItemIDsList);

  return separateItemIDsList;
}

separateItemIDs()
{
  List<String> separateItemIDsList=[], defaultItemList=[];
  int i=0;

  defaultItemList = sharedPreferences!.getStringList("userCart")!;

  for(i; i<defaultItemList.length; i++)
  {
    String item = defaultItemList[i].toString();
    var pos = item.lastIndexOf(":");

    String getItemId = (pos != -1) ? item.substring(0, pos) : item;

    print("This is itemID now = " + getItemId);

    separateItemIDsList.add(getItemId);
  }

  print("This is Items List now = ");
  print(separateItemIDsList);

  return separateItemIDsList;
}


addItemToCart(String? foodItemId, BuildContext context, int itemCounter)
{
  List<String>? tempList = sharedPreferences!.getStringList("userCart");
  tempList!.add(foodItemId! + ":$itemCounter"); //56557657:7
  
  FirebaseFirestore.instance.collection("users")
      .doc(firebaseAuth.currentUser!.uid).update({
    "userCart": tempList,
  }).then((value)
  {
    Fluttertoast.showToast(msg: "Item Added Successfully.");

    sharedPreferences!.setStringList("userCart", tempList);

    //update the badge
    Provider.of<CartItemCounter>(context, listen: false).displayCartListItemsNumber();
  });
}

//For reordering items from history
addItemsToCart(List<String?>? foodItemsID, BuildContext context, List<int> itemCounterList, String sellerUID)
{
  List<String>? tempList;
  for(int i=0;i<itemCounterList.length;i++)
  {
    tempList!.add(foodItemsID![i]! + ":${itemCounterList[i]}"); //56557657:7
  }
  FirebaseFirestore.instance.collection("users")
      .doc(firebaseAuth.currentUser!.uid).update({
    "userCart": tempList,
  }).then((value)
  {
    // Fluttertoast.showToast(msg: "Items Added Successfully.");

    sharedPreferences!.setStringList("userCart", tempList!);

    //update the badge
    Provider.of<CartItemCounter>(context, listen: false).displayCartListItemsNumber();
    Navigator.push(context, MaterialPageRoute(builder: (c)=> CartScreen(sellerUID:sellerUID)));

  });
}

addItemsToCartNew(ItemsList, BuildContext context, String sellerUID)
{
  List<String>? tempList=[];
  List<String>? itemsList = List<String>.from(ItemsList);
  // tempList.add("garbageValue");
  for(int i=0 ;i<itemsList!.length; i++)
  {
    //56557657:7
    String item = itemsList[i].toString();
    var pos = item.lastIndexOf(":");
    String quantity;
    String ItemId;
    if ((pos != -1)) {
      ItemId = item.substring(0, pos);
      quantity=item.substring(pos+1);
      tempList.add(ItemId + ":${quantity}"); //56557657:7
    } else {
      tempList.add(item); //56557657:7
    }
  }
  FirebaseFirestore.instance.collection("users")
      .doc(firebaseAuth.currentUser!.uid).update({
    "userCart": tempList,
  }).then((value)
  {
    // Fluttertoast.showToast(msg: "Items Added Successfully.");

    sharedPreferences!.setStringList("userCart", tempList);

    //update the badge
    Provider.of<CartItemCounter>(context, listen: false).displayCartListItemsNumber();
    Navigator.push(context, MaterialPageRoute(builder: (c)=> CartScreen(sellerUID:sellerUID)));

  });
}

separateItemQuantities()
{
  List<int> separateItemQuantityList=[];
  List<String> defaultItemList=[];
  int i=1;

  defaultItemList = sharedPreferences!.getStringList("userCart")!;

  for(i; i<defaultItemList.length; i++)
  {
    String item = defaultItemList[i].toString();

    List<String> listItemCharacters = item.split(":").toList();

    var quanNumber = int.parse(listItemCharacters[1].toString());
    // quanNumber.toString()
    print("\nThis is product id  and Quantity Number = " +  item);

    separateItemQuantityList.add(quanNumber);
  }

  print("\nThis is Quantity List now = ");
  print(separateItemQuantityList);

  return separateItemQuantityList;
}


separateOrderItemQuantities(orderIDs)
{
  List<String> separateItemQuantityList=[];
  List<String> defaultItemList=[];
  int i=1;

  defaultItemList = List<String>.from(orderIDs);

  for(i; i<defaultItemList.length; i++)
  {
    //56557657:7
    String item = defaultItemList[i].toString();


    //0=:
    //1=7
    //:7
    List<String> listItemCharacters = item.split(":").toList();

    //7
    var quanNumber = int.parse(listItemCharacters[1].toString());

    print("\nThis is (orderitemquan) Quantity Number = " + quanNumber.toString());

    separateItemQuantityList.add(quanNumber.toString());
  }

  print("\nThis is Quantity List now = ");
  print(separateItemQuantityList);

  return separateItemQuantityList;
}


clearCartNow(context)
{
  sharedPreferences!.setStringList("userCart", ['garbageValue']);
  List<String>? emptyList = sharedPreferences!.getStringList("userCart");

  FirebaseFirestore.instance
      .collection("users")
      .doc(firebaseAuth.currentUser!.uid)
      .update({"userCart": emptyList}).then((value)
  {
    sharedPreferences!.setStringList("userCart", emptyList!);
    Provider.of<CartItemCounter>(context, listen: false).displayCartListItemsNumber();
  });
}