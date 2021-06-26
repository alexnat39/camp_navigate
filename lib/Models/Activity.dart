class Activity {
  late String title;
  late String points;

  Activity(this.title, this.points);

  Map<String, dynamic> toMap() {
    var data = Map<String, dynamic>();
    data['title'] = title;
    data['points'] =points;
    return data;
  }
}