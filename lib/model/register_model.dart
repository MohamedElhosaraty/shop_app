class RegisterModel {
  final bool status;
  final String message;
  final Data? data;

  RegisterModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  final String name;
  final String email;
  final String phone;
  final int id;
  final String image;
  final String token;

  Data({
    required this.name,
    required this.email,
    required this.phone,
    required this.id,
    required this.image,
    required this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    id: json["id"],
    image: json["image"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "phone": phone,
    "id": id,
    "image": image,
    "token": token,
  };
}
