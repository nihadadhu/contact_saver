class ContactModel {
  String id;
  String name;
  String phone;
  String email;
  String? imagePath;
  bool isFavorite;
  DateTime? updatedAT;
  ContactModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    this.imagePath,
    this.isFavorite = false,
    this.updatedAT,
  });
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "email": email,
    "imagePath": imagePath,
    "isFavorite": isFavorite,
    "updateAt": updatedAT?.toIso8601String(),
  };
  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json["id"],
      name: json["name"],
      phone: json["phone"],
      email: json["email"],
      imagePath: json["imagePath"],
      isFavorite: json["isFavorite"],
     updatedAT: json["updateAt"] != null ? DateTime.parse(json["updateAt"]) : null,

    );
  }
}
