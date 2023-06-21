import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:olx_clone_app/Widgets/itemList.dart';
import 'package:uuid/uuid.dart';

CollectionReference items = FirebaseFirestore.instance.collection('items');
FirebaseFirestore firebaseStorage = FirebaseFirestore.instance;
int ind = 0;
List ?imglist;// = ['https://thumbs.dreamstime.com/b/%D0%B7%D0%B0%D0%B3%D1%80%D1%83%D0%B7%D0%B8%D1%82%D0%B5-%D0%B7%D0%BD%D0%B0%D1%87%D0%BE%D0%BA-%D0%B8-%D0%B8-%D0%BE%D0%B3%D0%BE%D1%82%D0%B8%D0%BF-%D0%B2-%D1%81%D0%BE%D0%B2%D1%80%D0%B5%D0%BC%D0%B5%D0%BD%D0%BD%D0%BE%D0%B9-%D0%B8%D0%BD%D0%B8%D0%B8-%D1%81%D1%82%D0%B8-%D0%B5-85639570.jpg'];
void minusImage(int len)
{
  if(ind == 0) {}

  else {ind-=1;}
}
void plusImage(int len)
{
  if( ind == len-1) {}
  else {ind+=1;}
}
class ItemScreen extends StatefulWidget {
  Item? model;

   ItemScreen({super.key, required this.model});
  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? _image;
  List<String> urls = [];
  int uploadItem = 0;
  UploadTask? uploadTask;
  String postId = const Uuid().v4();
  var geturls;

  Future imagePickerMethod() async {
    final pick = await imagePicker.pickMultiImage();
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            FutureBuilder<DocumentSnapshot>(
                future: items.doc(postId).get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done){
                    print(imglist);
                    if(imglist!.length == null) {
                      return const Text('data');
                    }

                    return   Column(
                      children: [
                        Text(widget.model!.itemModel ?? ''),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              IconButton(onPressed: () { minusImage(imglist!.length); setState(() {});}, icon: const Icon(Icons.arrow_back_ios_new)),
                              Container(
                                height: 200,
                                width: 200,
                                child: Image.network(imglist![ind]),
                              ),
                              IconButton(onPressed: () { plusImage(imglist!.length); setState(() {

                              });}, icon: const Icon(Icons.arrow_forward_ios)),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  if(snapshot == null) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return Container();
                }),
          ],
        ),
      ),
    );
  }
  @override
  void initState() {
    imglist = widget.model!.image;
    super.initState();
  }
}
