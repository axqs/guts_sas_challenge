///
/// Class used for displaying list items on list views
///
class ListItem{
  String title;
  DateTime date;

  ListItem(this.title, this.date);

  ListItem.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        date = DateTime.parse(json['date']);

  Map<String, dynamic> toJson() =>
      {
        'title': title,
        'date': date.toString(),
      };

}