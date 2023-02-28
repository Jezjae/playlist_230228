class MusicItemsModel {

  String? id;
  String? image;
  String? path;
  String? name;
  String? title;
  String? length;
  bool isChecked = false;


  MusicItemsModel(
      {
        this.id,
        this.image,
        this.path,
        this.name,
        this.title,
        this.length,
        required this.isChecked
      }
      );

  MusicItemsModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        image = json['image'],
        path = json['path'],
        name = json['name'],
        title = json['title'],
        length = json['length'],
        isChecked = json['isChecked'];


  Map<String, dynamic> toJson() => {
    'id': id,
    'image': image,
    'path' : path,
    'name' : name,
    'title' : title,
    'length' : length,
    'isChecked' : isChecked,

  };

}
