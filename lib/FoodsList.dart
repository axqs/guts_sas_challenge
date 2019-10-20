import 'package:flutter/material.dart';
import 'FoodItem.dart';

class FoodsList extends StatefulWidget {

  final List<FoodItem> items;
  const FoodsList({ Key key, this.items, List<FoodItem> selected,}) : super(key: key);

  @override
  _FoodsList createState() => _FoodsList();
}

class _FoodsList extends State<FoodsList> {

	void removeListItem(index){
		widget.items.removeAt(index);
	}

  Widget build(BuildContext context) {
    //List<FoodItem> items = widget.items;
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        //padding: const EdgeInsets.all(8),
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          FoodItem item = widget.items[index];

          return ListTile(
            leading: IconButton(
              icon: Icon(item.selected ? Icons.check_box : Icons.check_box_outline_blank),
              color: item.selected ? Colors.green : null,
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
              item.fooditem,
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
