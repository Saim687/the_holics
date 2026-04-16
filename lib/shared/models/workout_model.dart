class Workout {
  final String id;
  final String title;
  final int durationMin;
  final String difficulty; // 'Beginner', 'Intermediate', 'Advanced'
  final bool isLocked;
  final String requiredPlan; // 'monthly', 'quarterly', 'yearly', or 'any'
  final String? videoUrl;

  Workout({
    required this.id,
    required this.title,
    required this.durationMin,
    required this.difficulty,
    required this.isLocked,
    required this.requiredPlan,
    this.videoUrl,
  });

  factory Workout.fromJson(Map<String, dynamic> json, String docId) {
    return Workout(
      id: docId,
      title: json['title'] ?? '',
      durationMin: (json['durationMin'] as num?)?.toInt() ?? 0,
      difficulty: json['difficulty'] ?? 'Intermediate',
      isLocked: json['isLocked'] ?? false,
      requiredPlan: json['requiredPlan'] ?? 'monthly',
      videoUrl: json['videoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'durationMin': durationMin,
      'difficulty': difficulty,
      'isLocked': isLocked,
      'requiredPlan': requiredPlan,
      'videoUrl': videoUrl,
    };
  }
}

class NutritionPlan {
  final String id;
  final String title;
  final String description;
  final bool isLocked;
  final String requiredPlan; // 'monthly', 'quarterly', 'yearly'

  NutritionPlan({
    required this.id,
    required this.title,
    required this.description,
    required this.isLocked,
    required this.requiredPlan,
  });

  factory NutritionPlan.fromJson(Map<String, dynamic> json, String docId) {
    return NutritionPlan(
      id: docId,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      isLocked: json['isLocked'] ?? false,
      requiredPlan: json['requiredPlan'] ?? 'quarterly',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'isLocked': isLocked,
      'requiredPlan': requiredPlan,
    };
  }
}
