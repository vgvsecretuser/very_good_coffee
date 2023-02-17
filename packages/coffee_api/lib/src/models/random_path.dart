import 'package:json_annotation/json_annotation.dart';

part 'random_path.g.dart';

/// {@template random_path}
/// A model representing the random coffee json request.
///
/// Example:
/// ```json
/// {
///   "file": "https://coffee.alexflipnote.dev/7eAokF8_ro4_coffee.jpg"
/// }
/// ```
/// {@endtemplate}
@JsonSerializable()
class RandomPath {

  /// {@macro random_path}
  const RandomPath(this.file);

  /// Factory which returns a [RandomPath] based on the provided [json].
  factory RandomPath.fromJson(Map<String, dynamic> json) =>
      _$RandomPathFromJson(json);

  /// URL form a random coffee image.
  final String file;
}
