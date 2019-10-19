///
/// Class used for displaying list items on list views
///
class ListItem{
  String title;
  DateTime date;
  bool selected;

  ListItem(this.title, this.date, {this.selected=false});
}