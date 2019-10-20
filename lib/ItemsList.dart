import 'package:flutter/material.dart';
import 'ListItem.dart';

class ItemsList extends StatefulWidget {

  final List<ListItem> items;
  final bool InShopping;
  const ItemsList({ Key key, this.items, this.InShopping}) : super(key: key);

  @override
  _ItemsList createState() => _ItemsList();
}

class _ItemsList extends State<ItemsList> {

  void removeListItem(index){
    widget.items.removeAt(index);
  }

  bool expired(ListItem item){
    if(item.date.isBefore(DateTime.now().add(new Duration(days: 1)))){
      return true;
    } else {
      return false;
    }
  }

  bool closeToExpiration(ListItem item){
    if(item.date.isBefore(DateTime.now().add(new Duration(days: 3)))){
      return true;
    } else {
      return false;
    }
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

            leading: IconButton(
              icon: Icon(
                widget.InShopping ?
              (item.selected ?
                     Icons.check_box :
                     Icons.check_box_outline_blank) : Icons.brightness_1),
              color: widget.InShopping ?(

                  item.selected ?
                    Colors.green :
                    null
              ) : ( expired(item) ?
                  Colors.red:
                    closeToExpiration(item)?
                      Colors.yellow:
                        Colors.green
              ),
              onPressed: () {
                setState(() {
                  if (item.selected) {
                    item.selected = false;
                  } else {
                    item.selected = true;
                  }
                });
              },
            ),
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
