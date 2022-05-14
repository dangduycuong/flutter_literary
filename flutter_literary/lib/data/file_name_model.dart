import 'package:json_annotation/json_annotation.dart';

part 'file_name_model.g.dart';

@JsonSerializable()
class FileNameModel {
  final String id;
  final String fileName;
  final String description;
  final bool isFavorite;

  FileNameModel({
    required this.id,
    required this.fileName,
    required this.description,
    required this.isFavorite,
  });

  factory FileNameModel.fromJson(Map<String, dynamic> json) =>
      _$FileNameModelFromJson(json);

  Map<String, dynamic> toJson() => _$FileNameModelToJson(this);
}
