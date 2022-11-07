import 'package:json_annotation/json_annotation.dart';

part 'stat_data.g.dart';

@JsonSerializable(createToJson: false)

/// Stat Data
class StatData {
  /// const constructor of the StatData model
  const StatData({
    required this.name,
    required this.url,
  });

  /// it returns StatData from json
  factory StatData.fromJson(Map<String, dynamic> json) =>
      _$StatDataFromJson(json);

  /// stat name
  final String name;

  /// stat url
  final String url;
}
