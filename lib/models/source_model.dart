import 'package:hive_flutter/hive_flutter.dart';
part 'source_model.g.dart';

@HiveType(typeId: 2)
class SourceModel {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  SourceModel({this.id, this.name});

  SourceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
