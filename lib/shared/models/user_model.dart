class User {
  final String id;
  final String name;
  final String email;
  final String? phoneNumber;
  final String role; // 'member', 'admin', 'guest'
  final String? photoUrl;
  final DateTime createdAt;
  final bool isActive;
  final bool bodyHolicsRegistrationFeePaid;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
    required this.role,
    this.photoUrl,
    required this.createdAt,
    this.isActive = true,
    this.bodyHolicsRegistrationFeePaid = false,
  });

  factory User.fromJson(Map<String, dynamic> json, String uid) {
    return User(
      id: uid,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber']?.toString(),
      role: json['role'] ?? 'member',
      photoUrl: json['photoUrl'],
      createdAt: _parseTimestamp(json['createdAt']),
      isActive: json['isActive'] ?? true,
      bodyHolicsRegistrationFeePaid:
          json['bodyHolicsRegistrationFeePaid'] ?? false,
    );
  }

    static DateTime _parseTimestamp(dynamic timestamp) {
      if (timestamp == null) return DateTime.now();
      if (timestamp is DateTime) return timestamp;
      // Handle Firestore Timestamp
      if (timestamp.runtimeType.toString().contains('Timestamp')) {
        return timestamp.toDate();
      }
      // Handle string
      if (timestamp is String) {
        try {
          return DateTime.parse(timestamp);
        } catch (_) {
          return DateTime.now();
        }
      }
      return DateTime.now();
    }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'role': role,
      'photoUrl': photoUrl,
      'createdAt': createdAt,
      'isActive': isActive,
      'bodyHolicsRegistrationFeePaid': bodyHolicsRegistrationFeePaid,
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? role,
    String? photoUrl,
    DateTime? createdAt,
    bool? isActive,
    bool? bodyHolicsRegistrationFeePaid,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      isActive: isActive ?? this.isActive,
      bodyHolicsRegistrationFeePaid:
          bodyHolicsRegistrationFeePaid ?? this.bodyHolicsRegistrationFeePaid,
    );
  }
}
