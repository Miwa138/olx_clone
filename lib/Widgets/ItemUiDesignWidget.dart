import 'package:flutter/material.dart';
import 'package:olx_clone_app/ItemScreen/item_screen.dart';
import 'package:olx_clone_app/Widgets/itemList.dart';

class ItemUiDesignWidget extends StatefulWidget {

  Item? model;

  ItemUiDesignWidget({
    this.model,
  });

  @override
  State<ItemUiDesignWidget> createState() => _ItemUiDesignWidgetState();
}

class _ItemUiDesignWidgetState extends State<ItemUiDesignWidget> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => ItemScreen(model: widget.model,)));
      },
      child: Card(
        child: Column(
          children: [
            Card(
              elevation: 0,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                    width: 30,
                  ),
                  const Text("Фото:"), //

                  const SizedBox(
                    height: 10,
                  ),
                   ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.network(
                        widget.model!.image![0],
                        height: 220,
                        width: 220,
                        fit: BoxFit.cover,
                      ),
                      ),
                  const Text("Имя пользователя:"),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.model!.userName.toString(),
                    style: const TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      letterSpacing: 3,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Название товара:"),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.model!.itemModel.toString(),
                    style: const TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      letterSpacing: 3,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Цена:"),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.model!.itemPrice.toString(),
                    style: const TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      letterSpacing: 3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
