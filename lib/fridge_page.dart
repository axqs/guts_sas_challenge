import 'package:flutter/material.dart';
import './list_page.dart';
import 'ListItem.dart';
import 'ItemsList.dart';
import 'globals.dart' as globals;


class FridgePage extends StatefulWidget {
	FridgePage({Key key, this.title}) : super(key: key);

	final String title;

	@override
	_FridgePageState createState() => _FridgePageState();
}

class _FridgePageState extends State<FridgePage> {
	static List<ListItem> fridgeItems = new List<ListItem>();

	void clearAllList(){
		globals.FridgeItems.clear();
	}

	/*
	ReadListFromFile("FridgeList.json").then((loadedListItems) => {
	shoppingItems = loadedListItems
	});
	*/

	@override
	Widget build(BuildContext context) {

		return Scaffold(
			appBar: AppBar(
				title: Text(widget.title),
				actions: <Widget>[
					IconButton(
						icon: const Icon(Icons.clear),
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
								//SaveAll(jsonEncode(fridgeItems), "FridgeList.json");
								Navigator.push(context,MaterialPageRoute(builder: (context) => ListPage(title: "Shopping List")),);
							},
							trailing: new Icon(Icons.arrow_right),
						),
						new ListTile(
							title: new Text("Fridge"),
							onTap: () {
								//SaveAll(jsonEncode(fridgeItems), "FridgeList.json");
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
			body: Container(
				padding: const EdgeInsets.all(8),
				child:Column(
			children:  <Widget>[
				new Expanded(
				child:ItemsList(
				items:globals.FridgeItems,
					InShopping: false,
			))])),
		);
	}
}
