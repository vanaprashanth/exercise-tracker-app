class WorkoutLog {
  final String exerciseName;
  final DateTime date;
  final int sets;
  final int reps;
  final int duration;
  final bool skipped;

  WorkoutLog({
    required this.exerciseName,
    required this.date,
    required this.sets,
    required this.reps,
    required this.duration,
    required this.skipped,
  });

  Map<String, dynamic> toJson() => {
    'exerciseName': exerciseName,
    'date': date.toIso8601String(),
    'sets': sets,
    'reps': reps,
    'duration': duration,
    'skipped': skipped,
  };

  factory WorkoutLog.fromJson(Map<String, dynamic> json) => WorkoutLog(
    exerciseName: json['exerciseName'],
    date: DateTime.parse(json['date']),
    sets: json['sets'],
    reps: json['reps'],
    duration: json['duration'],
    skipped: json['skipped'],
  );
}
