class Prayer {
  final String name;
  final DateTime startTime;
  final DateTime endTime;

  Prayer({
    required this.name,
    required this.startTime,
    required this.endTime,
  });

  @override
  String toString() => '$name: ${startTime.toIso8601String()} -> ${endTime.toIso8601String()}';
}
