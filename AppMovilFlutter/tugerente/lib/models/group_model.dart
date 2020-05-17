import 'dart:convert';

Group groupFromJson(String str) => Group.fromJson(json.decode(str));

String groupToJson(Group data) => json.encode(data.toJson());

class Group {
  int groupcode;
  String name;
  Group({
    this.groupcode,
    this.name = '',
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return new Group(
      groupcode: json["groupcode"],
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() => {
        // "groupcode"         : groupcode,
        "name": name,
      };
}
