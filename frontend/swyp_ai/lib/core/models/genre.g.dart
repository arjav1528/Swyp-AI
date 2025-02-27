// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genre.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GenreImpl _$$GenreImplFromJson(Map<String, dynamic> json) => _$GenreImpl(
  name: json['name'] as String,
  label: json['label'] as String,
  icon: const IconDataConverter().fromJson((json['icon'] as num).toInt()),
);

Map<String, dynamic> _$$GenreImplToJson(_$GenreImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'label': instance.label,
      'icon': const IconDataConverter().toJson(instance.icon),
    };
