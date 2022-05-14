// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_name_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileNameModel _$FileNameModelFromJson(Map<String, dynamic> json) =>
    FileNameModel(
      id: json['id'] as String,
      fileName: json['fileName'] as String,
      description: json['description'] as String,
      isFavorite: json['isFavorite'] as bool,
    );

Map<String, dynamic> _$FileNameModelToJson(FileNameModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fileName': instance.fileName,
      'description': instance.description,
      'isFavorite': instance.isFavorite,
    };
