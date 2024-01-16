import 'dart:convert';

SolveResult solveResultFromJson(String str) =>
    SolveResult.fromJson(json.decode(str));

String solveResultToJson(SolveResult data) => json.encode(data.toJson());

class SolveResult {
  SolveResult({
    this.success = false,
    required this.message,
    this.prediction,
    this.orb,
    this.ssim,
  });

  final bool success;
  final String message;
  final String? prediction;
  final double? orb;
  final double? ssim;

  SolveResult copyWith({
    bool? success,
    String? message,
    String? prediction,
    double? orb,
    double? ssim,
  }) =>
      SolveResult(
        success: success ?? this.success,
        message: message ?? this.message,
        prediction: prediction ?? this.prediction,
        orb: orb ?? this.orb,
        ssim: ssim ?? this.ssim,
      );

  factory SolveResult.fromJson(Map<String, dynamic> json) => SolveResult(
        success: json["success"] ?? false,
        message: json["message"],
        prediction: json["prediction"],
        orb: json["orb"],
        ssim: json["ssim"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "prediction": prediction,
        "orb": orb,
        "ssim": ssim,
      };

  @override
  String toString() {
    return 'SolveResult(success: $success, message: $message, prediction: $prediction, orb: $orb, ssim: $ssim)';
  }
}
