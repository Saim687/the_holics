import 'package:cloud_firestore/cloud_firestore.dart';

class Subscription {
  final String userId;
  final String plan; // 'monthly', 'quarterly', 'yearly'
  final DateTime startDate;
  final DateTime endDate;
  final String status; // 'active', 'cancelled', 'expired'
  final String? stripeCustomerId;
  final String? stripeSubscriptionId;
  final double? price;

  Subscription({
    required this.userId,
    required this.plan,
    required this.startDate,
    required this.endDate,
    required this.status,
    this.stripeCustomerId,
    this.stripeSubscriptionId,
    this.price,
  });

  factory Subscription.fromJson(Map<String, dynamic> json, String userId) {
    DateTime parseDate(dynamic value) {
      if (value is DateTime) return value;
      if (value is Timestamp) return value.toDate();
      if (value is String && value.isNotEmpty) return DateTime.parse(value);
      return DateTime.now();
    }

    return Subscription(
      userId: userId,
      plan: json['plan'] ?? 'monthly',
      startDate: parseDate(json['startDate']),
      endDate: parseDate(json['endDate']),
      status: json['status'] ?? 'active',
      stripeCustomerId: json['stripeCustomerId'],
      stripeSubscriptionId: json['stripeSubscriptionId'],
      price: (json['price'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'plan': plan,
      'startDate': startDate,
      'endDate': endDate,
      'status': status,
      'stripeCustomerId': stripeCustomerId,
      'stripeSubscriptionId': stripeSubscriptionId,
      'price': price,
    };
  }

  bool get isActive => status == 'active' && endDate.isAfter(DateTime.now());

  Subscription copyWith({
    String? userId,
    String? plan,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    String? stripeCustomerId,
    String? stripeSubscriptionId,
    double? price,
  }) {
    return Subscription(
      userId: userId ?? this.userId,
      plan: plan ?? this.plan,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
      stripeCustomerId: stripeCustomerId ?? this.stripeCustomerId,
      stripeSubscriptionId: stripeSubscriptionId ?? this.stripeSubscriptionId,
      price: price ?? this.price,
    );
  }
}
