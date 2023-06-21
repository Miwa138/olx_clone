import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:olx_clone_app/DialogBox/ImageSliderScreen/image_slider_screen.dart';

import 'global_var.dart';

class ListViewWidget extends StatefulWidget {
  String docId,
      itemColor,
      img1,
      userImg,
      name,
      userId,
      itemModel,
      postId;
  String itemPrice, description, address, userNumber;
  DateTime date;
  double lat, lng;

  ListViewWidget({
    required this.docId,
    required this.itemColor,
    required this.userImg,
    required this.name,
    required this.userId,
    required this.itemModel,
    required this.postId,
    required this.itemPrice,
    required this.description,
    required this.address,
    required this.userNumber,
    required this.date,
    required this.lat,
    required this.lng,
    required this.img1,

  });

  @override
  State<ListViewWidget> createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  Future<Future> showDialogForUpdateData(selectedDoc, oldUserName,
      oldPhoneNumber, oldItemPrice, oldItemColor, oldItemDescription) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext cotext) {
          return SingleChildScrollView(
            child: AlertDialog(
              title: const Text(
                'Обновление данных',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Bebas',
                  letterSpacing: 2.0,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    initialValue: oldUserName,
                    decoration: const InputDecoration(
                      hintText: 'Имя',
                    ),
                    onChanged: (value) {
                      setState(() {
                        oldUserName = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    initialValue: oldPhoneNumber,
                    decoration: const InputDecoration(
                      hintText: 'Телефон',
                    ),
                    onChanged: (value) {
                      setState(() {
                        oldPhoneNumber = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    initialValue: oldItemPrice,
                    decoration: const InputDecoration(
                      hintText: 'Цена',
                    ),
                    onChanged: (value) {
                      setState(() {
                        oldItemPrice = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    initialValue: oldItemColor,
                    decoration: const InputDecoration(
                      hintText: 'Цвет',
                    ),
                    onChanged: (value) {
                      setState(() {
                        oldItemColor = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    initialValue: oldItemDescription,
                    decoration: const InputDecoration(
                      hintText: 'Описание',
                    ),
                    onChanged: (value) {
                      setState(() {
                        oldItemDescription = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    initialValue: oldItemDescription,
                    decoration: const InputDecoration(
                      hintText: 'Описание',
                    ),
                    onChanged: (value) {
                      setState(() {
                        oldItemDescription = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(cotext);
                    },
                    child: const Text(
                      'Закончить',
                    )),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(cotext);
                    updateProfileNameOnExistingPosts(oldUserName);
                    _updateUserName(oldUserName, oldPhoneNumber);

                    FirebaseFirestore.instance
                        .collection('items')
                        .doc(selectedDoc)
                        .update({
                      'userName': oldUserName,
                      'userNumber': oldPhoneNumber,
                      'itemPrice': oldItemPrice,
                      'itemColors': oldItemColor,
                      'description': oldItemDescription,
                    }).catchError((onError) {
                      print(onError);
                    });
                    Fluttertoast.showToast(msg: 'Загрузка завершина');
                  },
                  child: Text('Обновить'),
                ),
              ],
            ),
          );
        });
  }

  updateProfileNameOnExistingPosts(oldUserName) async {
    await FirebaseFirestore.instance
        .collection('items')
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) {
      for (int index = 0; index < snapshot.docs.length; index++) {
        String userProfileNameInPost = snapshot.docs[index]['userName'];
        if (userProfileNameInPost != oldUserName) {
          FirebaseFirestore.instance
              .collection('items')
              .doc(snapshot.docs[index].id)
              .update({
            'userName': oldUserName,
          });
        }
      }
    });
  }

  Future _updateUserName(oldUserName, oldPhoneNumber) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'userName': oldUserName,
      'userNumber': oldPhoneNumber,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Card(
        elevation: 16.0,
        shadowColor: Colors.white10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onDoubleTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) =>
                //     ImageSliderScreen(
                //       title: widget.itemModel,
                //       itemColor: widget.itemColor,
                //       userNumber: widget.userNumber,
                //       description: widget.description,
                //       lat: widget.lat,
                //       lng: widget.lng,
                //       address: widget.address,
                //       itemPrice: widget.itemPrice,
                //       urlImage1: widget.img1,
                //     ),
                // ),
                // );
              },
              child: Image.network(
                widget.img1,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      widget.userImg,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        widget.itemModel,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white60,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        DateFormat('dd MMM, yyyy - hh:mm a')
                            .format(widget.date)
                            .toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white60,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  widget.userId != uid
                      ? const Padding(
                    padding: EdgeInsets.only(right: 50.0),
                    child: Column(),
                  )
                      : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          showDialogForUpdateData(
                            widget.docId,
                            widget.name,
                            widget.userNumber,
                            widget.itemPrice,
                            widget.itemModel,
                            widget.itemColor,
                          );
                        },
                        icon: const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Icon(
                            Icons.edit_note,
                            color: Colors.white,
                            size: 27,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('items')
                              .doc(widget.postId)
                              .delete();

                          Fluttertoast.showToast(
                            msg: 'Запись удалена',
                            toastLength: Toast.LENGTH_LONG,
                            backgroundColor: Colors.grey,
                            fontSize: 18.0,
                          );
                        },
                        icon: const Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Icon(
                            Icons.delete_forever,
                            size: 22,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
