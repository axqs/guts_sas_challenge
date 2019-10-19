import 'package:flutter/material.dart';
import 'ListItem.dart';

class ItemsList extends StatefulWidget {

  final List<ListItem> items;
  const ItemsList({ Key key, this.items}) : super(key: key);

  @override
  _ItemsList createState() => _ItemsList();
}

class _ItemsList extends State<ItemsList> {

  void removeListItem(index){
    widget.items.removeAt(index);
  }


  Widget build(BuildContext context) {
    //List<ListItem> items = widget.items;
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        //padding: const EdgeInsets.all(8),
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          ListItem item = widget.items[index];
          return ListTile(
              title: Text(
              item.title,
              style: Theme.of(context).textTheme.display1,
          ),
            trailing: IconButton(
                icon: Icon(Icons.delete, size: 24.0),
                onPressed: () {
                  setState(() {
                    removeListItem(index);
                  });
                }
            ),
            
          );
        }
    );
  }
}
