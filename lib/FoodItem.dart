
class FoodItem{
    String fooditem;
    int days;
	bool selected;

    FoodItem(this.fooditem, this.days, {this.selected=false});

    FoodItem.fromJson(Map<String, dynamic> json)
        : fooditem = json['fooditem'],
            days = json['days'];

    Map<String, dynamic> toJson() =>
        {
            'fooditem': fooditem,
            'days': days,
        };
}
