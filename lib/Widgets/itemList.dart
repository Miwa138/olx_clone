import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Item
{
  String? userName;
  String? itemModel;
  String? itemPrice;
  List? image;
  // String? images;

  Item({
    this.userName,
    this.image,
    this.itemModel,
    this.itemPrice,
    // this.images,

  });

  Item.fromJson(Map<String, dynamic> json)
  {
    userName = json["userName"];
    itemModel = json["itemModel"];
    itemPrice = json["itemPrice"];
    image = json['images'];
    // images = json["images"];

  }

}