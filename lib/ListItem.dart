///
/// Class used for displaying list items on list views
///
class ListItem{
  String title;
  DateTime date;
  bool selected;
  
  ListItem(this.title, this.date, {this.selected=false});


  ListItem.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        date = DateTime.parse(json['date']);

  Map<String, dynamic> toJson() =>
      {
        'title': title,
        'date': date.toString(),
      };
}