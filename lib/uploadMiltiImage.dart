import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:olx_clone_app/DialogBox/loading_dialog.dart';
import 'package:path/path.dart' as Path;
import 'package:uuid/uuid.dart';

import '../Widgets/global_var.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  String postId = Uuid().v4();

  bool uploading = false, next = false;

  final List<File> _image = [];

  List<String> urlsList = [];

  FirebaseAuth _auth = FirebaseAuth.instance;

  String name = '';
  String phoneNo = '';

  double val = 0;

  CollectionReference? imgRef;

  String itemPrice = '';
  String itemModel = '';
  String itemColor = '';
  String itemDescription = '';

  chooseImage() async {
    XFile? pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image.add(File(pickedFile!.path));
    });
  }

  Future uploadFile() async {
    int i = 1;

    for (var img in _image) {
      setState(() {
        val = i / _image.length;
      });

      var ref = FirebaseStorage.instance
          .ref()
          .child('image/${Path.basename(img.path)}');

      await ref.putFile(img).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          urlsList.add(value);
          i++;
        });
      });
    }
  }


  getNameOfUser() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          name = snapshot.data()!['userName'];
          phoneNo = snapshot.data()!['userNumber'];
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getNameOfUser();
    imgRef = FirebaseFirestore.instance.collection('imageUrls');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: false,
          title: Text(
            next ? 'Добавьте информацию' : 'Выберете изображение',
          ),
          actions: [
            next
                ? Container()
                : ElevatedButton(onPressed: () {
              if (_image.length == 1) {
                setState(() {
                  uploading = true;
                  next = true;
                });

              }
              else if(_image.length == 2){
                setState(() {
                  uploading = true;
                  next = true;
                });
              }
              else if(_image.length == 3){
                setState(() {
                  uploading = true;
                  next = true;
                });
              }
              else if(_image.length > 3){
                Fluttertoast.showToast(msg: 'Не больше 3 фотографий');
              }
            },
              child: Text('Далее'),
            ),
          ],
        ),
        body: next
            ? SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 5.0,
                ),
                TextField(
                  decoration: const InputDecoration(hintText: 'Цена'),
                  onChanged: (value) {
                    itemPrice = value;
                  },
                ),
                const SizedBox(
                  height: 5.0,
                ),
                TextField(
                  decoration:
                  const InputDecoration(hintText: 'Название товара'),
                  onChanged: (value) {
                    itemModel = value;
                  },
                ),
                const SizedBox(
                  height: 5.0,
                ),
                TextField(
                  decoration: const InputDecoration(hintText: 'Цвет'),
                  onChanged: (value) {
                    itemColor = value;
                  },
                ),
                const SizedBox(
                  height: 5.0,
                ),
                TextField(
                  decoration: const InputDecoration(hintText: 'Описание'),
                  onChanged: (value) {
                    itemDescription = value;
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return LoadingAlertDialog(
                              message: 'Загрузка...',
                            );
                          });
                      if(_image.length == 1)
                      {
                        uploadFile().whenComplete(() {
                          FirebaseFirestore.instance
                              .collection('items')
                              .doc(postId)
                              .set({
                            'userName': name,
                            'id': _auth.currentUser!.uid,
                            'postId': postId,
                            'userNumber': phoneNo,
                            'itemPrice': itemPrice,
                            'itemModel': itemModel,
                            'itemColors': itemColor,
                            'description': itemDescription,
                            'urlImage1': urlsList[0].toString(),
                            // 'urlImage2': urlsList[1].toString(),
                            // 'urlImage3': urlsList[2].toString(),
                            // 'urlImage4': urlsList[3].toString(),
                            // 'urlImage5': urlsList[4].toString(),
                          });

                        }
                        );
                      }
                      else  if(_image.length == 2)
                      {
                        uploadFile().whenComplete(() {
                          FirebaseFirestore.instance
                              .collection('items')
                              .doc(postId)
                              .set({
                            'userName': name,
                            'id': _auth.currentUser!.uid,
                            'postId': postId,
                            'userNumber': phoneNo,
                            'itemPrice': itemPrice,
                            'itemModel': itemModel,
                            'itemColors': itemColor,
                            'description': itemDescription,
                            'urlImage1': urlsList[0].toString(),
                            'urlImage2': urlsList[1].toString(),
                            // 'urlImage3': urlsList[2].toString(),
                            // 'urlImage4': urlsList[3].toString(),
                            // 'urlImage5': urlsList[4].toString(),
                          });

                        }
                        );
                      }
                      else  if(_image.length == 3)
                      {
                        uploadFile().whenComplete(() {
                          FirebaseFirestore.instance
                              .collection('items')
                              .doc(postId)
                              .set({
                            'userName': name,
                            'id': _auth.currentUser!.uid,
                            'postId': postId,
                            'userNumber': phoneNo,
                            'itemPrice': itemPrice,
                            'itemModel': itemModel,
                            'itemColors': itemColor,
                            'description': itemDescription,
                            'urlImage1': urlsList[0].toString(),
                            'urlImage2': urlsList[1].toString(),
                            'urlImage3': urlsList[2].toString(),
                            // 'urlImage4': urlsList[3].toString(),
                            // 'urlImage5': urlsList[4].toString(),
                          });

                        }
                        );
                      }
                    },
                    child: const Text(
                      'Загрузить',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
            : Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              child: GridView.builder(
                itemCount: _image.length + 1,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  return index == 0
                      ? Center(
                    child: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        !uploading ? chooseImage() : null;
                      },
                    ),
                  )
                      : Container(
                    margin: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(_image[index - 1]),
                            fit: BoxFit.cover)),
                  );
                },
              ),
            ),
            uploading
                ? // истина
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Загрузка...',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CircularProgressIndicator(
                    value: val,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.green),
                  )
                ],
              ),
            )
                : //лож
            Container(),
          ],
        ),
      ),
    );
  }
}
