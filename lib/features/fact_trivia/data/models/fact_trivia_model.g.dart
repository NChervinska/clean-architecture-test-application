// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fact_trivia_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FactTriviaModel _$FactTriviaModelFromJson(Map<String, dynamic> json) =>
    FactTriviaModel(
      fact: json['fact'] as String,
      length: json['length'] as int,
    );

Map<String, dynamic> _$FactTriviaModelToJson(FactTriviaModel instance) =>
    <String, dynamic>{
      'fact': instance.fact,
      'length': instance.length,
    };
