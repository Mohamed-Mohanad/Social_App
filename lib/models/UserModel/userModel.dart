class UserModel {
  String? name;
  String? email;
  String? phone;
  String? personalImage;
  String? coverImage;
  String? bio;
  String? uId;
  bool? isEmailVerified;

  UserModel({
    this.email,
    this.name,
    this.phone,
    this.personalImage,
    this.coverImage,
    this.bio,
    this.uId,
    this.isEmailVerified,
  });

  UserModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    email = json['email'];
    phone = json['phone'];
    personalImage = json['personalImage'];
    coverImage = json['coverImage'];
    bio = json['bio'];
    uId = json['uId'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'personalImage': personalImage,
      'coverImage': coverImage,
      'bio' : bio,
      'uId': uId,
      'isEmailVerified': isEmailVerified,
    };
  }
}
