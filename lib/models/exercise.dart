class Exercise {
  final String name;
  final String image;
  final String category;
  int sets;
  int reps;
  bool isTimed;
  int durationSeconds;
  bool isCompleted;
  bool isSkipped;

  Exercise({
    required this.name,
    required this.image,
    required this.category,
    required this.sets,
    required this.reps,
    this.isTimed = false,
    this.durationSeconds = 0,
    this.isCompleted = false,
    this.isSkipped = false,
  });
}
