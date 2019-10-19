import 'package:flutter/material.dart';
import './list_page.dart';
import './fridge_page.dart';
import 'ListItem.dart';
import 'ItemsList.dart';

class FoodItem{
    String fooditem;
    int expiryindays;
    
    FoodItem(this.fooditem, this.expiryindays);

    FoodItem.fromJson(Map<String, dynamic> json)
        : fooditem = json['fooditem'],
            expiryindays = json['expiryindays']; 
    
    Map<String, dynamic> toJson() =>
        {
            'fooditem': fooditem,
            'expiryindays': expiryindays,
        };   
} 
  

