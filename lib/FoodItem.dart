
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
  

