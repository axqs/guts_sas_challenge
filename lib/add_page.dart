import 'package:flutter/material.dart';
import './list_page.dart';
import './fridge_page.dart';
import 'ListItem.dart';
import 'ItemsList.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

class AddPage extends StatefulWidget {
  AddPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

  final TextEditingController textController = new TextEditingController();
  String filter;

  void dispose() {
    textController.dispose();
    super.dispose();
  }

	@override
	Widget build(BuildContext context) {

		return Scaffold(
			appBar: AppBar(
				title: Text(widget.title),
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
			body: Center(
				child: new Column(
					children: <Widget>[
						new Padding(
							padding: new EdgeInsets.all(20.0),

							child: new TextField(
								autofocus: true,
								decoration: new InputDecoration(
									labelText: "Search Groceries",
									helperText: "eg. Milk",
								),
							controller: textController,
							),
						),

						Expanded(
							child: Container(
								width: 100,
							),
						),
			Align(
				alignment: Alignment.bottomCenter,
				child: Container(
					padding: const EdgeInsets.all(8),
					width: MediaQuery.of(context).size.width,
					child: RaisedButton(
						onPressed: () {
							Navigator.pop(
									context, ListItem(textController.text, DateTime.now()));
						},
						child: const Text('Add', style: TextStyle(fontSize: 20)),
						color: Colors.green,
					),
				)),
					],
				),
			),
		);
	}
}
