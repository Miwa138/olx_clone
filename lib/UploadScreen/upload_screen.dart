import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:olx_clone_app/Widgets/global_var.dart';
import 'package:uuid/uuid.dart';

CollectionReference items = FirebaseFirestore.instance.collection('items');
FirebaseFirestore firebaseStorage = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

bool _loading = false;

int ind = 0;
List?imglist; // = ['https://thumbs.dreamstime.com/b/%D0%B7%D0%B0%D0%B3%D1%80%D1%83%D0%B7%D0%B8%D1%82%D0%B5-%D0%B7%D0%BD%D0%B0%D1%87%D0%BE%D0%BA-%D0%B8-%D0%B8-%D0%BE%D0%B3%D0%BE%D1%82%D0%B8%D0%BF-%D0%B2-%D1%81%D0%BE%D0%B2%D1%80%D0%B5%D0%BC%D0%B5%D0%BD%D0%BD%D0%BE%D0%B9-%D0%B8%D0%BD%D0%B8%D0%B8-%D1%81%D1%82%D0%B8-%D0%B5-85639570.jpg'];
void minusImage(int len) {
  if (ind == 0) {
  } else {
    ind -= 1;
  }
}

void plusImage(int len) {
  if (ind == len - 1) {
  } else {
    ind += 1;
  }
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

String itemPrice = '';
String itemModel = '';
String name = '';

class _HomeState extends State<Home> {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? _image;
  List<String> urls = [];
  int uploadItem = 0;
  UploadTask? uploadTask;
  String postId = Uuid().v4();
  var geturls;

  Future imagePickerMethod() async {
    final pick = await imagePicker.pickMultiImage(imageQuality: 15);
    setState(() {
      if (pick != null) {
        _image = pick;
      } else {
        Fluttertoast.showToast(msg: "Нет изображения");
      }
    });
  }

  Future<String> uploadFile(XFile images) async {
    final imgId = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance.ref().child("post_$imgId");
    uploadTask = reference.putFile(File(images.path));
    await uploadTask?.whenComplete(() {
      setState(() {});
    });
    return await reference.getDownloadURL();
  }



  void uploadFunction(List<XFile> images) async {
    setState(() {
      _loading = true;
    });

    for (int i = 0; i < images.length; i++) {
      var imgUrl = await uploadFile(images[i]);
      urls.add(imgUrl.toString());
      await firebaseStorage
          .collection('items')
          .doc(postId)
          .set({'images': urls,
        'userName': name,
        'userId': _auth.currentUser!.uid,
        'postId': postId,
        'itemPrice': itemPrice,
        'itemModel': itemModel,
        'time': DateTime.now(),
      });
    }
    urls.clear();

    setState(() {
      _loading = false;
    });
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
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNameOfUser();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(""),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              //open button ----------------
              ElevatedButton(
                  onPressed: () {
                    imagePickerMethod();
                  },
                  child: Text("Выбрать фото")),
              ElevatedButton(
                  onPressed: () {
                    uploadFunction(_image!);
                  },
                  child: Text("Загрузить")),

              Divider(),
              Text("Picked Files:"),
              _loading ? Positioned(
                child: Container(
                  alignment: AlignmentDirectional.center,
                  decoration:  const BoxDecoration(
                    color: Colors.white70,
                  ),
                  child:  Container(
                    decoration:  BoxDecoration(
                        color: Colors.blue[200],
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    width: 300.0,
                    height: 200.0,
                    alignment: AlignmentDirectional.center,
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Center(
                          child:  SizedBox(
                            height: 50.0,
                            width: 50.0,
                            child:  CircularProgressIndicator(
                              value: null,
                              strokeWidth: 7.0,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 25.0),
                          child:  const Center(
                            child:  Text(
                              "Загрузка...",
                              style:  TextStyle(
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ) : Container(),
              Divider(),
              _image != null
                  ? Wrap(
                children: _image!.map((imageone) {
                  return Container(
                      child: Card(
                        child: Container(
                          height: 100,
                          width: 100,
                          child: Image.file(File(imageone.path)),
                        ),
                      ));
                }).toList(),
              )
                  : Container(),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 20.0,
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
                    decoration: const InputDecoration(hintText: 'Цена'),
                    onChanged: (value) {
                      itemPrice = value;
                    },
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),

                ],
              ),
            ],
          ),
        ));
  }
}
