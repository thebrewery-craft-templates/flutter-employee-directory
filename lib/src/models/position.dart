class Position {
  String id;
  String title;

  Position({this.id, this.title});

  Position.fromJson(Map<String, dynamic> data) {
    this.title = data['title'];
  }

}