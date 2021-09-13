class PostModel {
  String? name;
  String? personalImage;
  String? uId;
  String? dateTime;
  String? text;
  String? postImage;

  PostModel({
    this.name,
    this.personalImage,
    this.uId,
    this.dateTime,
    this.text,
    this.postImage,
  });

  PostModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    personalImage = json['personalImage'];
    dateTime = json['dateTime'];
    text = json['text'];
    postImage = json['postImage'];
    uId = json['uId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'personalImage': personalImage,
      'uId': uId,
      'postImage': postImage,
      'text': text,
      'dateTime': dateTime,
    };
  }
}
