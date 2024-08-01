class DetectionResult {
  final int? id;
  final String label;
  final double confidence;
  final String imagePath;

  DetectionResult({
    this.id,
    required this.label,
    required this.confidence,
    required this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'label': label,
      'confidence': confidence,
      'imagePath': imagePath,
    };
  }

  factory DetectionResult.fromMap(Map<String, dynamic> map) {
    return DetectionResult(
      id: map['id'],
      label: map['label'],
      confidence: map['confidence'],
      imagePath: map['imagePath'],
    );
  }
}
