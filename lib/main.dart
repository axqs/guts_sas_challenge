import 'package:flutter/material.dart';
import './fridge_page.dart';
import './list_page.dart';
import 'globals.dart' as globals;
import 'SaveAndLoad.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ReadListFromFile("ShoppingList.json").then((loadedListItems) =>
    {
    globals.ShoppingItems = loadedListItems
    });
    ReadListFromFileFoodItem("fooditems.json").then((loadedListItems) =>
    {
      globals.FoodItems = loadedListItems
    });

    return MaterialApp(
      title: 'Grocery List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          display1: TextStyle(fontSize: 24.0, fontFamily: 'Hind')
        ),
      ),
      home: ListPage(title: "Shopping List"),
    );
  }
}
