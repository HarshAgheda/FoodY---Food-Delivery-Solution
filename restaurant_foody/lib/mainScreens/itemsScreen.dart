import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../global/global.dart';
import '../model/items.dart';
import '../model/menus.dart';
import '../uploadScreens/items_upload_screen.dart';
import '../widgets/items_design.dart';
import '../widgets/my_drawer.dart';
import '../widgets/progress_bar.dart';
import '../widgets/text_widget_header.dart';


class ItemsScreen extends StatefulWidget
{
  final Menus? model;
  ItemsScreen({this.model});

  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}


class _ItemsScreenState extends State<ItemsScreen>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[400],
        title: Text(
          sharedPreferences!.getString("name")!,
          style: const TextStyle(fontSize: 25, fontFamily: "GeneralSans"),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.library_add, color: Colors.white,),
            onPressed: ()
            {
              Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemsUploadScreen(model: widget.model)));
            },
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(pinned: true, delegate: TextWidgetHeader(title: widget.model!.menuTitle.toString())),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("sellers")
                .doc(sharedPreferences!.getString("uid"))
                .collection("menus")
                .doc(widget.model!.menuID)
                .collection("items").orderBy("publishedDate",descending: true)
                .snapshots(),
            builder: (context, snapshot)
            {
              return !snapshot.hasData
                  ? SliverToBoxAdapter(
                    child: Center(child: circularProgress(),),
              )
                  : SliverStaggeredGrid.countBuilder(
                crossAxisCount: 1,
                staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                itemBuilder: (context, index)
                {
                  Items model = Items.fromJson(
                    snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                  );
                  return ItemsDesignWidget(
                    model: model,
                    context: context,
                  );
                },
                itemCount: snapshot.data!.docs.length,
              );
            },
          ),
        ],
      ),
    );
  }
}
