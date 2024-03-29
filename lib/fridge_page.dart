import 'package:flutter/material.dart';
import './list_page.dart';
import 'ListItem.dart';
import 'ItemsList.dart';
import 'globals.dart' as globals;
import 'SaveAndLoad.dart';


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

    globals.FridgeItems.sort((a, b) => a.date.compareTo(b.date));

		return Scaffold(
			appBar: AppBar(
				title: Text(widget.title),
		/*actions: <Widget>[
					Dont make this for this in the fridge page
					 IconButton(

						icon: const Icon(Icons.clear),
						tooltip: 'Clear all',
						onPressed: () {
							clearAllList();
						},
					),
				]*/
			),
			drawer: new Drawer(
				child: new ListView(
					children: <Widget>[
						DrawerHeader(
							child: Text(
								"My Shopping List",
								textAlign: TextAlign.center,
								style: new TextStyle(
									fontSize: 40.0,
								),
							),
							decoration: BoxDecoration(
								image: DecorationImage(
									image: ExactAssetImage('assets/images/notes.png'),
									fit: BoxFit.cover,
								),
							),
						),
						new ListTile(
							title: new Text("Shopping List"),
							onTap: () {
								print("tapped list");
								// Save when you switch screen
								Navigator.push(context,MaterialPageRoute(builder: (context) => ListPage(title: "Shopping List")),);
							},
							trailing: new Icon(Icons.arrow_right),
						),
						new ListTile(
							title: new Text("Fridge"),
							onTap: () {
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
