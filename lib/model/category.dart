class Category{
  String catName;
  String img;
  String id;
  
  Category({this.catName,
  this.img,
  this.id});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    catName: json["cat_name"],
    img: json["img"],
    id: json["_id"],
  );
}