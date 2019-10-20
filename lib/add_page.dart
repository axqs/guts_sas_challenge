import 'package:flutter/material.dart';
import './list_page.dart';
import './fridge_page.dart';
import 'ListItem.dart';
import 'ItemsList.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class AddPage extends StatefulWidget {
  AddPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

  final TextEditingController textController = new TextEditingController();
  String filter;
  DateTime dateTimeOfItem = DateTime.now();

  void dispose() {
    textController.dispose();
    super.dispose();
  }

	@override
	Widget build(BuildContext context) {
		final dFormat = DateFormat("dd/MM/yyyy");

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
			new Padding(
				padding: new EdgeInsets.only(left:10.0),
				//Add a container here to set width
				child:
				ListTile(

					title: //<Widget>[
				//new Flexible(child:
					Text(
								dFormat.format(dateTimeOfItem),
						style: Theme.of(context).textTheme.display1,
						),
						trailing: IconButton(
							icon: Icon(Icons.calendar_today), onPressed: (){

							showDatePicker(
								context: context,
								initialDate: DateTime.now(),
								firstDate: DateTime(DateTime.now().year-1),
								lastDate: DateTime(2030),
								builder: (BuildContext context, Widget child) {
									return Theme(
										data: ThemeData.light(),
										child: child,
									);
								},
							).then((dateChosen) => {
								setState(() {
									dateTimeOfItem = dateChosen;
								})
							});
						},
						)
					,
				),
				/* Use a text field next to a calander icon, click the calander icon to bring up a calander.
				child:DateTimeField(
							format: dFormat,

							initialValue: DateTime.now(),
							onShowPicker: (context, currentValue) async {
								final date = await showDatePicker(
										context: context,
										firstDate: DateTime(1900),
										initialDate: currentValue ?? DateTime.now(),
										lastDate: DateTime(2100));
								dateTimeOfItem = date;
								return date;
							},
						),*/
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
									context, ListItem(textController.text, dateTimeOfItem));
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


// ... add a datefield to allow people to insert the date, make this field optional
// and write "this field is optional because we have average expiry dates stored for select items"

/*class BasicDateField extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Basic date field (${format.pattern})'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
      ),
    ]);
  }
}*/

