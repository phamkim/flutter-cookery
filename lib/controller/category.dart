class Category {
  int id;
  String title;
  List img;
  int recipes;
  String source;
  Category({this.img, this.title, this.recipes, this.source, this.id});

  factory Category.fromJson(Map<dynamic, dynamic> json) {
    return Category(
        id: json['id'],
        title: json['title'],
        source: json['source'],
        img: json['images'],
        recipes: json['recipes']);
  }
}
