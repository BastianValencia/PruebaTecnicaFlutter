import 'package:freezed_annotation/freezed_annotation.dart';

/// A robust converter that ensures a String is always returned.
///
/// - If value is `null`, returns `""` (empty string).
/// - If value is `String`, returns it as is.
/// - If value is `num`, `bool` or other, returns `value.toString()`.
class RobustStringConverter implements JsonConverter<String, dynamic> {
  const RobustStringConverter();

  @override
  String fromJson(dynamic json) {
    if (json == null) {
      return '';
    }
    if (json is String) {
      return json;
    }
    return json.toString();
  }

  @override
  dynamic toJson(String object) => object;
}

/// A robust converter that ensures a double is always returned.
///
/// - If value is `null`, returns `0.0`.
/// - If value is `num` (int/double), returns `value.toDouble()`.
/// - If value is `String`:
///   - Tries to parse it to double.
///   - If parsing fails, returns `0.0`.
class RobustDoubleConverter implements JsonConverter<double, dynamic> {
  const RobustDoubleConverter();

  @override
  double fromJson(dynamic json) {
    if (json == null) {
      return 0.0;
    }
    if (json is num) {
      return json.toDouble();
    }
    if (json is String) {
      return double.tryParse(json) ?? 0.0;
    }
    return 0.0;
  }

  @override
  dynamic toJson(double object) => object;
}
