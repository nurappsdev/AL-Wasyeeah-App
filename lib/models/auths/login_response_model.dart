// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel {
  final int? statusCode;
  final bool? status;
  final LoginData? data;
  final String? message;

  LoginResponseModel({
    this.statusCode,
    this.status,
    this.data,
    this.message,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        statusCode: json["statusCode"],
        status: json["status"],
        data: json["data"] == null ? null : LoginData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "data": data?.toJson(),
        "message": message,
      };
}

class LoginData {
  final String? token;

  LoginData({
    this.token,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}

