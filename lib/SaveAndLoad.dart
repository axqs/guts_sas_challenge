
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:sas_grocery_list/ItemsList.dart';
import 'ListItem.dart';
import 'FoodItem.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> SaveItemListData(List<ItemsList> items, String filePath){
  return SaveAll(jsonEncode(items), filePath);
}

Future<File> SaveAll(String JSONstring, String filename) async{
  final path = await _localPath;
  File f = File('$path/$filename.json');
  bool bv = f.existsSync();
  if(bv == false){
      f.create(recursive: true);
    }
  try {
    return File('$path/$filename.json').writeAsString(JSONstring);
  }catch(e){
      return null;
  }
}

Future<String> LoadDataFromLocalFile(String filename) async {
  String contents = await File('$filename.json').readAsString();

  return contents;
}

Future<String> LoadData(String filename) async {
  final path = await _localPath;
  String contents = await File('$path/$filename.json').readAsString();

  return contents;
}

Future<List<FoodItem>> ReadListFromFileFoodItem(String filename) async {
  try {
    //rootBundle.loadString('assets/test.json');
  	/*new File('C:/Users/rdmen/Desktop/GUTS/test.json').create(recursive:true).then((file)=>{
  	  file.writeAsString(jsonEncode(List<ListItem>.generate(20, (int index) =>
          ListItem("Item "+index.toString(), DateTime.now()
          ))
      ))
  	});*/
    String LoadedData = await rootBundle.loadString(filename);
    print(LoadedData);
    print(json.decode(LoadedData));
    //List<FoodItem> JSONDecodedLoadedData = json.decode(LoadedData).map((i) => FoodItem.fromJson(i)).toList();
	List<dynamic> JSONDecodedLoadedData = json.decode(LoadedData).map((i) => FoodItem.fromJson(i)).toList();
	//List<FoodItem> JSONDecodedLoadedData = new List<FoodItem>();
	print("ITS WORKING");

    return JSONDecodedLoadedData.cast<FoodItem>();
  }
  catch (e) {
    print("Failed to load jSON file");
  	print(e.toString());
    // If encountering an error, return 0.
    return new List<FoodItem>();
  }
}

Future<List<ListItem>> ReadListFromFile(String filename) async {
  try {
    String LoadedData = await LoadData(filename);
    List<ListItem> JSONDecodedLoadedData = json.decode(LoadedData).map((i) =>
        ListItem.fromJson(i)).toList();

    return JSONDecodedLoadedData;
  }
  catch (e) {
    // If encountering an error, return 0.
    return new List<ListItem>();
  }
}
