import 'dart:convert';

import 'package:flutter/material.dart';
import './fridge_page.dart';
import './add_page.dart';
import 'ListItem.dart';
import 'ItemsList.dart';

import 'globals.dart' as globals;
import 'SaveAndLoad.dart';

class ListPage extends StatefulWidget {
	ListPage({Key key, this.title}) : super(key: key);
	final String title;

	@override
	_ListPageState createState() => _ListPageState();
}


class _ListPageState extends State<ListPage> {

	//Remove this when finished app
	//List<ListItem> shoppingItems = globals.ShoppingItems;
	// = List<ListItem>.generate(0, (int index) => ListItem("Item "+index.toString(), DateTime.now()));

	static bool readFile = false;

	void clearAllList(){
		setState(() {
			globals.ShoppingItems.clear();
		});

	}

	void addItemAndSave(ListItem itemAdded){
		globals.ShoppingItems.add(itemAdded);
		SaveAll(jsonEncode(globals.ShoppingItems), "ShoppingList.json");
		for(ListItem item in globals.ShoppingItems){
			print(item.title);
		}

	}

	void moveSelectedItemstoFridge(){
		for(ListItem item in List.from(globals.ShoppingItems)){
			if (item.selected){
        setState(() {
          globals.ShoppingItems.remove(item);
          globals.FridgeItems.add(item);
        });
			}
		}
	}

	@override
	Widget build(BuildContext context) {
	/*if(readFile == false) {
		ReadListFromFile("ShoppingList.json").then((loadedListItems) =>
		{
			shoppingItems = loadedListItems
		});
		print("ReadFile");
		readFile = true;
	}*/

		if(globals.ShoppingItems == null) { globals.ShoppingItems = new List<ListItem>();}


		return Scaffold(
			appBar: AppBar(
				title: Text(widget.title),
				actions: <Widget>[
					IconButton(
						icon: const Icon(Icons.delete),
						tooltip: 'Clear all',
						onPressed: () {
							clearAllList();
						},
					),
				]
			),
			drawer: new Drawer(
				child: new ListView(
					children: <Widget>[
						DrawerHeader(
							child: Text("My Shopping List"),
							decoration: BoxDecoration(
								color: Colors.blue,
							),
						),
						new ListTile(
							title: new Text("Shopping List"),
							onTap: () {
								print("tapped list");
								// Save when you switch screen
								//SaveAll(jsonEncode(shoppingItems), "ShoppingList.json");
								Navigator.push(context,MaterialPageRoute(builder: (context) => ListPage(title: "Shopping List")),);
							},
							trailing: new Icon(Icons.arrow_right),
						),
						new ListTile(
							title: new Text("Fridge"),
							onTap: () {
								//SaveAll(jsonEncode(shoppingItems), "ShoppingList.json");
								print("tapped fridge");
								Navigator.push(context,MaterialPageRoute(builder: (context) => FridgePage(title: "Fridge Page")),);
							},
							trailing: new Icon(Icons.arrow_right),
						),
						new Divider(),
						new ListTile(
							title: new Text("Close"),
							onTap: () => Navigator.of(context).pop(),
							trailing: new Icon(Icons.cancel),
						),
					],
				),
			),

			body:
			Container(
				padding: const EdgeInsets.all(8),
				child:Column(
			children:  <Widget>[
				/*TextField(
					obscureText: true,
					decoration: InputDecoration(
						labelText: 'Add Item',
					),
				),*/
				new Expanded(
				child:ItemsList(

				items:globals.ShoppingItems,
			)),
				const SizedBox(height: 30),
				RaisedButton(
					onPressed: () {

							moveSelectedItemstoFridge();

					},
					child: const Text(
							'Move to Fridge',
							style: TextStyle(fontSize: 20)
					),
				),
			])),
			floatingActionButton: FloatingActionButton(
				tooltip: 'Increment',
				child: Icon(Icons.add),
				onPressed: () {
					print("add grocery");

					Navigator.push(context,MaterialPageRoute(builder: (context) => AddPage(title: "Add To List")),).then((itemAdded) => {
					if(itemAdded != null && itemAdded.title != ""){
						addItemAndSave(itemAdded)
					}
					});
				},
			), // This trailing comma makes auto-formatting nicer for build methods.
		);
	}
}
