class ReminderNotificationResponseModel {
  final String? lastUpdatedAt;
  final int? daysSinceLastUpdate;
  final String? reminderDateTime;
  final bool? shouldSchedule;
  final String? message;

  ReminderNotificationResponseModel({
    this.lastUpdatedAt,
    this.daysSinceLastUpdate,
    this.reminderDateTime,
    this.shouldSchedule,
    this.message,
  });

  factory ReminderNotificationResponseModel.fromJson(Map<String, dynamic> json) {
    return ReminderNotificationResponseModel(
      lastUpdatedAt: json['lastUpdatedAt']?.toString(),
      daysSinceLastUpdate: json['daysSinceLastUpdate'] != null
          ? int.tryParse(json['daysSinceLastUpdate'].toString())
          : null,
      reminderDateTime: json['reminderDateTime']?.toString(),
      shouldSchedule: json['shouldSchedule'] is bool
          ? json['shouldSchedule']
          : json['shouldSchedule']?.toString().toLowerCase() == 'true',
      message: json['message']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lastUpdatedAt': lastUpdatedAt,
      'daysSinceLastUpdate': daysSinceLastUpdate,
      'reminderDateTime': reminderDateTime,
      'shouldSchedule': shouldSchedule,
      'message': message,
    };
  }
}
