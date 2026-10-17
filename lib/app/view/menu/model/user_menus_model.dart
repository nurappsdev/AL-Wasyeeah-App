// To parse this JSON data, do
//
//     final userMenus = userMenusFromJson(jsonString);

import 'dart:convert';

List<UserMenus> userMenusFromJson(String str) =>
    List<UserMenus>.from(json.decode(str).map((x) => UserMenus.fromJson(x)));

String userMenusToJson(List<UserMenus> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserMenus {
  final String menuId;
  final String menuName;
  final String activeYn;
  final String basePath;
  final int menuOrderNo;
  final List<SubMenu> subMenus;

  UserMenus({
    required this.menuId,
    required this.menuName,
    required this.activeYn,
    required this.basePath,
    required this.menuOrderNo,
    required this.subMenus,
  });

  factory UserMenus.fromJson(Map<String, dynamic> json) => UserMenus(
        menuId: json["menuId"],
        menuName: json["menuName"],
        activeYn: json["activeYn"],
        basePath: json["basePath"],
        menuOrderNo: json["menuOrderNo"],
        subMenus: List<SubMenu>.from(
            json["subMenus"].map((x) => SubMenu.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "menuId": menuId,
        "menuName": menuName,
        "activeYn": activeYn,
        "basePath": basePath,
        "menuOrderNo": menuOrderNo,
        "subMenus": List<dynamic>.from(subMenus.map((x) => x.toJson())),
      };
}

class SubMenu {
  final String submenuId;
  final String submenuName;
  final String contexts;

  SubMenu({
    required this.submenuId,
    required this.submenuName,
    required this.contexts,
  });

  factory SubMenu.fromJson(Map<String, dynamic> json) => SubMenu(
        submenuId: json["submenuId"],
        submenuName: json["submenuName"],
        contexts: json["contexts"],
      );

  Map<String, dynamic> toJson() => {
        "submenuId": submenuId,
        "submenuName": submenuName,
        "contexts": contexts,
      };
}
