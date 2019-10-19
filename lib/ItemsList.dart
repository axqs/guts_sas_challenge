import 'package:flutter/material.dart';
import 'ListItem.dart';

class ItemsList extends StatefulWidget {

  final List<ListItem> items;
  const ItemsList({ Key key, this.items}) : super(key: key);

  @override
  _ItemsList createState() => _ItemsList();
}

class _ItemsList extends State<ItemsList> {

  FixedExtentScrollController fixedExtentScrollController =
  new FixedExtentScrollController();

  Widget build(BuildContext context) {
    List<ListItem> items = widget.items;
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.all(8),
        itemCount: items.length,
        itemBuilder: (context, index) {
          ListItem item = items[index];
          return ListTile(
              title: Text(
              item.title,
              style: Theme.of(context).textTheme.display1,
          ),
            trailing: Icon(Icons.delete, size: 24.0),
          );
        }
    );
  }
}