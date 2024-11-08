import 'dart:convert';

List<Travel> travelFromJson(String str) =>
    List<Travel>.from(json.decode(str).map((x) => Travel.fromJson(x)));

String travelToJson(List<Travel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Travel {
  int? id;
  String? name;
  String? description;

  Travel({
    this.id,
    this.name,
    this.description,
  });

  factory Travel.fromJson(Map<String, dynamic> json) => Travel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
      };
}
