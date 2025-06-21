import 'package:flutter/material.dart';
import '../models/exercise.dart';
import 'exercise_detail_page.dart';
import 'workout_summary_page.dart';

class ExerciseListPage extends StatefulWidget {
  const ExerciseListPage({super.key});

  @override
  _ExerciseListPageState createState() => _ExerciseListPageState();
}

class _ExerciseListPageState extends State<ExerciseListPage> {
  String selectedCategory = 'All';
  String searchQuery = '';

  final List<Exercise> exercises = [
    Exercise(
      name: 'Neck Rolls',
      image: 'assets/images/Neck Rolls.jpg',
      sets: 1,
      reps: 0,
      category: 'Warm-Up',
      isTimed: true,
      durationSeconds: 30,
    ),
    Exercise(
      name: 'Shoulder Rolls',
      image: 'assets/images/Shoulder_Rolls.png',
      sets: 1,
      reps: 0,
      category: 'Warm-Up',
      isTimed: true,
      durationSeconds: 30,
    ),
    Exercise(
      name: 'Arm Swings',
      image: 'assets/images/Arm_Swings.png',
      sets: 1,
      reps: 0,
      category: 'Warm-Up',
      isTimed: true,
      durationSeconds: 30,
    ),
    Exercise(
      name: 'Torso Twists',
      image: 'assets/images/Torso_Twists.png',
      sets: 1,
      reps: 0,
      category: 'Warm-Up',
      isTimed: true,
      durationSeconds: 30,
    ),
    Exercise(
      name: 'March in Place or Jumping Jacks',
      image: 'assets/images/Jumping_Jacks.jpeg',
      sets: 1,
      reps: 0,
      category: 'Warm-Up',
      isTimed: true,
      durationSeconds: 30,
    ),

    // Cardio Machine Warm-Up
    Exercise(
      name: 'Ankle Circles',
      image: 'assets/images/Ankle_Circles.jpeg',
      sets: 1,
      reps: 0,
      category: 'Cardio Warm-Up',
      isTimed: true,
      durationSeconds: 30,
    ),
    Exercise(
      name: 'Arm Swings (forward & backward)',
      image: 'assets/images/Arm_Swings.png',
      sets: 1,
      reps: 0,
      category: 'Cardio Warm-Up',
      isTimed: true,
      durationSeconds: 30,
    ),
    Exercise(
      name: 'Leg Swings (front & back)',
      image: 'assets/images/Leg Swings.png',
      sets: 1,
      reps: 0,
      category: 'Cardio Warm-Up',
      isTimed: true,
      durationSeconds: 30,
    ),
    Exercise(
      name: 'Hip Circles',
      image: 'assets/images/Hip Circles.jpeg',
      sets: 1,
      reps: 0,
      category: 'Cardio Warm-Up',
      isTimed: true,
      durationSeconds: 30,
    ),
    Exercise(
      name: 'Torso Twists (Cardio)',
      image: 'assets/images/Torso_Twists.png',
      sets: 1,
      reps: 0,
      category: 'Cardio Warm-Up',
      isTimed: true,
      durationSeconds: 30,
    ),
    Exercise(
      name: 'High Knees (marching in place)',
      image: 'assets/images/High Knees.jpeg',
      sets: 1,
      reps: 0,
      category: 'Cardio Warm-Up',
      isTimed: true,
      durationSeconds: 30,
    ),
    Exercise(
      name: 'Light Walk on Treadmill or Elliptical',
      image: 'assets/images/Threadmill.jpeg',
      sets: 1,
      reps: 0,
      category: 'Cardio Warm-Up',
      isTimed: true,
      durationSeconds: 60,
    ),

    // Full-Body Stretching
    Exercise(
      name: 'Standing Side Bend',
      image: 'assets/images/Standing Side Bend.jpeg',
      sets: 2,
      reps: 0,
      category: 'Stretching',
      isTimed: true,
      durationSeconds: 30,
    ),
    Exercise(
      name: 'Butterfly Stretch',
      image: 'assets/images/Butterfly Stretch.jpeg',
      sets: 2,
      reps: 0,
      category: 'Stretching',
      isTimed: true,
      durationSeconds: 30,
    ),
    Exercise(
      name: 'Cobra Pose',
      image: 'assets/images/Cobra Pose.png',
      sets: 2,
      reps: 0,
      category: 'Stretching',
      isTimed: true,
      durationSeconds: 30,
    ),
    Exercise(
      name: 'Childs Pose',
      image: 'assets/images/Childs Pose.png',
      sets: 2,
      reps: 0,
      category: 'Stretching',
      isTimed: true,
      durationSeconds: 30,
    ),
    Exercise(
      name: 'Legs-Up-The-Wall Pose',
      image: 'assets/images/Legs-Up-The-Wall Pose.jpeg',
      sets: 2,
      reps: 0,
      category: 'Stretching',
      isTimed: true,
      durationSeconds: 60,
    ),
    Exercise(
      name: 'Neck + Shoulder Rolls',
      image: '',
      sets: 2,
      reps: 0,
      category: 'Stretching',
      isTimed: true,
      durationSeconds: 30,
    ),

    // Thigh Fat Exercises
    Exercise(
      name: 'Sumo Squats',
      image: 'assets/images/Sumo Squats.jpeg',
      sets: 3,
      reps: 15,
      category: 'Thigh Fat',
    ),
    Exercise(
      name: 'Forward Lunges',
      image: 'assets/images/Forward Lunges.png',
      sets: 3,
      reps: 15,
      category: 'Thigh Fat',
    ),
    Exercise(
      name: 'Side Lunges',
      image: 'assets/images/Side Lunges.png',
      sets: 3,
      reps: 15,
      category: 'Thigh Fat',
    ),
    Exercise(
      name: 'Glute Bridge',
      image: 'assets/images/Glute Bridge.png',
      sets: 3,
      reps: 15,
      category: 'Thigh Fat',
    ),
    Exercise(
      name: 'Wall Sit',
      image: 'assets/images/Wall Sit.jpeg',
      sets: 3,
      reps: 0,
      category: 'Thigh Fat',
      isTimed: true,
      durationSeconds: 45,
    ),
    Exercise(
      name: 'Step-Ups',
      image: 'assets/images/Step-Ups.jpeg',
      sets: 3,
      reps: 15,
      category: 'Thigh Fat',
    ),

    // Belly Fat Exercises
    Exercise(
      name: 'Mountain Climbers',
      image: 'assets/images/Mountain Climbers.jpeg',
      sets: 3,
      reps: 0,
      category: 'Belly Fat',
      isTimed: true,
      durationSeconds: 45,
    ),
    Exercise(
      name: 'Leg Raises',
      image: 'assets/images/Leg Raises.png',
      sets: 3,
      reps: 15,
      category: 'Belly Fat',
    ),
    Exercise(
      name: 'Russian Twists',
      image: 'assets/images/Russian Twists.jpeg',
      sets: 3,
      reps: 20,
      category: 'Belly Fat',
    ),
    Exercise(
      name: 'Forearm Plank',
      image: 'assets/images/Forearm Plank.png',
      sets: 3,
      reps: 0,
      category: 'Belly Fat',
      isTimed: true,
      durationSeconds: 45,
    ),

    // Full-Body Strengthening
    Exercise(
      name: 'Push-Ups',
      image: 'assets/images/Push-Ups.jpeg',
      sets: 3,
      reps: 15,
      category: 'Strengthening',
    ),
    Exercise(
      name: 'Bird-Dog',
      image: 'assets/images/Bird-Dog.png',
      sets: 3,
      reps: 20,
      category: 'Strengthening',
    ),
    Exercise(
      name: 'Chair Pose Hold',
      image: 'assets/images/Chair Pose Hold.jpeg',
      sets: 3,
      reps: 0,
      category: 'Strengthening',
      isTimed: true,
      durationSeconds: 45,
    ),
    Exercise(
      name: 'Triceps Dips',
      image: 'assets/images/Triceps Dips.jpeg',
      sets: 3,
      reps: 15,
      category: 'Strengthening',
    ),
    Exercise(
      name: 'Squat to Knee Raise',
      image: 'assets/images/Squat to Knee Raise.jpeg',
      sets: 3,
      reps: 15,
      category: 'Strengthening',
    ),
    Exercise(
      name: 'High Plank to Low Plank',
      image: 'assets/images/High Plank to Low Plank.jpeg',
      sets: 3,
      reps: 0,
      category: 'Strengthening',
      isTimed: true,
      durationSeconds: 30,
    ),

    // Recovery
    Exercise(
      name: 'Childs Pose (Recovery)',
      image: 'assets/images/Childs Pose.png',
      sets: 2,
      reps: 0,
      category: 'Recovery',
      isTimed: true,
      durationSeconds: 60,
    ),
    Exercise(
      name: 'Legs-Up-The-Wall Pose (Recovery)',
      image: 'assets/images/Legs-Up-The-Wall Pose.jpeg',
      sets: 1,
      reps: 0,
      category: 'Recovery',
      isTimed: true,
      durationSeconds: 60,
    ),
    Exercise(
      name: 'Neck Stretch (Side to Side)',
      image: 'assets/images/Neck Rolls.jpg',
      sets: 2,
      reps: 0,
      category: 'Recovery',
      isTimed: true,
      durationSeconds: 60,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final categories = exercises.map((e) => e.category).toSet().toList();
    final filtered =
        exercises.where((e) {
          final matchCategory =
              selectedCategory == 'All' || e.category == selectedCategory;
          final matchSearch = e.name.toLowerCase().contains(
            searchQuery.toLowerCase(),
          );
          return matchCategory && matchSearch;
        }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Exercise Tracker')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search Exercises',
                border: OutlineInputBorder(),
              ),
              onChanged: (val) => setState(() => searchQuery = val),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => selectedCategory = 'All'),
                  child: const Text('All'),
                ),
                ...categories.map(
                  (cat) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ElevatedButton(
                      onPressed: () => setState(() => selectedCategory = cat),
                      child: Text(cat),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final exercise = filtered[index];
                final icon =
                    exercise.isCompleted
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : exercise.isSkipped
                        ? const Icon(Icons.cancel, color: Colors.red)
                        : const Icon(Icons.fitness_center);

                return ListTile(
                  tileColor:
                      exercise.isCompleted
                          ? Colors.green[100]
                          : exercise.isSkipped
                          ? Colors.red[100]
                          : null,
                  leading: icon,
                  title: Text(exercise.name),
                  subtitle: Text(
                    '${exercise.sets} Sets | ${exercise.isTimed ? '${exercise.durationSeconds}s' : '${exercise.reps} Reps'} | ${exercise.category}',
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => ExerciseDetailPage(
                              exerciseName: exercise.name,
                              isTimed: exercise.isTimed,
                              initialReps: exercise.reps,
                              initialSets: exercise.sets,
                              durationSeconds: exercise.durationSeconds,
                              imagePath: exercise.image,
                            ),
                      ),
                    );
                    if (result != null && result is Map) {
                      setState(() {
                        exercise.isCompleted = result['completed'] == true;
                        exercise.isSkipped = result['completed'] == false;
                      });
                    }
                  },
                );
              },
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 10),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.flag),
                label: const Text("Workout Complete"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const WorkoutSummaryPage(),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
