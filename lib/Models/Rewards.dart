class Reward {
  late String title;
  late String description;
  late int points;
  late String imageLink;

  Reward(this.title, this.description, this.points, this.imageLink);
  Map<String, dynamic> toMap() {
    var data = Map<String, dynamic>();
    data['title'] = title;
    data['points'] =points;
    data['desccription'] = description;
    data['imageLink'] = imageLink;
    return data;
  }
}
