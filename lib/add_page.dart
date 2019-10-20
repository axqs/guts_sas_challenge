import 'package:flutter/material.dart';
import './list_page.dart';
import './fridge_page.dart';
import 'ListItem.dart';
import 'FoodItem.dart';
import 'ItemsList.dart';
import 'FoodsList.dart';
import 'globals.dart' as globals;
import 'SaveAndLoad.dart';
import  'package:keyboard_actions/keyboard_actions.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class AddPage extends StatefulWidget {
  AddPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

	TextEditingController textController = new TextEditingController();
	List<FoodItem> duplicate = globals.FoodItems != null ? List.from(globals.FoodItems): new List<FoodItem>();
	DateTime dateTimeOfItem = DateTime.now();

	@override
	void initState(){
		super.initState();
		/*if( globals.FoodItems != null ){
			duplicate = List.from(globals.FoodItems);

		} else {
			duplicate = new List<FoodItem>();
		}*/
	}

	void filterSearchResults(String query) {
		duplicate = globals.FoodItems != null ? List.from(globals.FoodItems): new List<FoodItem>();
		query = query.toLowerCase();
		List<FoodItem> dummySearchList = List<FoodItem>();
		dummySearchList = List.from(duplicate);
		if(query.isNotEmpty) {
			List<FoodItem> dummyListData = List<FoodItem>();
			dummySearchList.forEach((i) {
				if(i.fooditem.toLowerCase().contains(query) || query == "") {
					dummyListData.add(i);
				}
			});
			setState(() {
				duplicate.clear();
				duplicate = dummyListData;
			});
			return;
		} else {
			setState(() {
				duplicate.clear();
				duplicate = globals.FoodItems;
			});
		}
	}

	@override
	Widget build(BuildContext context) {
		final dFormat = DateFormat("dd/MM/yyyy");

		return new Scaffold(
			appBar: AppBar(
				title: Text(widget.title),
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
				child: Column(
					children: <Widget>[
						Padding(
							padding: new EdgeInsets.all(20.0),
							child: new TextField(
								onChanged: (value) {
									filterSearchResults(value);
								},
								controller: textController,
								decoration: InputDecoration(
									labelText: "Search Groceries",
									helperText: "eg. Flour",
									hintText: "Search",
									prefixIcon: Icon(Icons.search),
								),
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
							child: ListView.builder(
								shrinkWrap: true,
								itemCount: duplicate.length,
								itemBuilder: (context, index) {
									return ListTile(
										title: Text('${duplicate[index].fooditem}'),
									);
								},
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
											context, ListItem(textController.text, dateTimeOfItem)
										);
									},
									child: const Text('Add', style: TextStyle(fontSize: 20)),
									color: Colors.green,
								),
							),
						),
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
