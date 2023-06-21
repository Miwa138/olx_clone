import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:olx_clone_app/UploadScreen/upload_screen.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:olx_clone_app/Widgets/ItemUiDesignWidget.dart';
import 'package:olx_clone_app/Widgets/itemList.dart';
import '../Widgets/global_var.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  getUserAddress() async {
    Position newPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    position = newPosition;

    placemarks = await placemarkFromCoordinates(
      position!.latitude,
      position!.longitude,
    );
    Placemark placemark = placemarks![0];

    String newCompleteAddress =
        '${placemark.subThoroughfare} ${placemark.thoroughfare},'
        '${placemark.subThoroughfare} ${placemark.locality},'
        '${placemark.subAdministrativeArea},'
        '${placemark.administrativeArea} ${placemark.postalCode},'
        '${placemark.country},';

    completeAddress = newCompleteAddress;
    print(completeAddress);

    return completeAddress;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserAddress();
    uid = FirebaseAuth.instance.currentUser!.uid;
    userEmail = FirebaseAuth.instance.currentUser!.email!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Главная'),
      ),
      body: CustomScrollView(
        slivers: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("items")
                .snapshots(),
            builder: (context, AsyncSnapshot dataSnapshot)
            {
              if(dataSnapshot.hasData) //if brands exists
                  {
                //display brands
                return SliverStaggeredGrid.countBuilder(
                  crossAxisCount: 1,
                  staggeredTileBuilder: (c)=> const StaggeredTile.fit(1),
                  itemBuilder: (context, index)
                  {
                    Item brandsModel = Item.fromJson(
                      dataSnapshot.data.docs[index].data() as Map<String, dynamic>,
                    );

                    return ItemUiDesignWidget(
                      model: brandsModel,
                    );
                  },
                  itemCount: dataSnapshot.data.docs.length,
                );
              }
              else //if brands NOT exists
                  {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      "No brands exists",
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Добавить',
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) =>  Home()));
        },
        child: const Icon(Icons.cloud_upload),
        backgroundColor: Colors.black54,
      ),
    );
  }
}
