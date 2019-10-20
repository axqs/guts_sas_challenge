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

class AddPage extends StatefulWidget {
  AddPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

	final TextEditingController textController = new TextEditingController();
	List<FoodItem> duplicate;

	@override
	void initState(){
		if( globals.FoodItems == null ){
			duplicate.addAll(globals.FoodItems);
			super.initState();
		} else {
			duplicate = new List<FoodItem>();
		}
	}

	void filterSearchResults(String query) {
		query = query.toLowerCase();
		List<FoodItem> dummySearchList = List<FoodItem>();
		dummySearchList.addAll(duplicate);
		if(query.isNotEmpty) {
			List<FoodItem> dummyListData = List<FoodItem>();
			dummySearchList.forEach((i) {
				if(i.fooditem.contains(query)) {
					dummyListData.add(i);
				}
			});
			setState(() {
				duplicate.clear();
				duplicate.addAll(dummyListData);
			});
			return;
		} else {
			setState(() {
				duplicate.clear();
				duplicate.addAll(duplicate);
			});
		}
	}

	@override
	Widget build(BuildContext context) {

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
									helperText: "eg. Milk",
									hintText: "Search",
									prefixIcon: Icon(Icons.search),
								),
							),
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
											context, ListItem(textController.text, DateTime.now())
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
