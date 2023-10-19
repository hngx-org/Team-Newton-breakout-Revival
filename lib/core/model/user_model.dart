import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    final String? message;
    final bool? success;
    final String? email;
    final String? name;

    UserModel({
        this.message,
        this.success,
        this.email,
        this.name,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        message: json["message"],
        success: json["success"],
        email: json["email"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "email": email,
        "name": name,
    };
}
