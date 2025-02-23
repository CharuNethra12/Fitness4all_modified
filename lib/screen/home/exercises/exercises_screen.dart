import 'package:fitness4all/common/color_extensions.dart';
import 'package:fitness4all/screen/home/settings/settings_screen.dart';
import 'package:flutter/material.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({super.key});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  int _selectedIndex = 0;
  final TextEditingController _exerciseController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  // Local variables to store exercise data
  int _totalCaloriesBurned = 0;
  int _totalTimeSpent = 0; // Time spent in minutes
  final List<Map<String, dynamic>> _savedExercises = [];
  final List<String> _exerciseRecommendations = [
    "🏋️‍♂️ Weightlifting",
    "🏃‍♂️ Running",
    "🚴‍♂️ Cycling",
    "🧘‍♀️ Yoga",
    "🏊‍♂️ Swimming",
    "🤸‍♀️ Pilates",
    "🥊 Boxing",
    "🤼‍♂️ Wrestling"
  ];

  final Map<int, Color> _pageColors = {
    0: Colors.green,
    1: Colors.orange,
    2: Colors.blue,
    3: Colors.red,
    4: Colors.purple,
    5: Colors.teal,
  };

  final List<String> _exerciseCategories = ["Cardio", "Strength", "Flexibility", "Endurance"];
  String _selectedCategory = "Cardio";

  void _showSnackBar(String message, {Color color = Colors.green}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Widget _exerciseCard(Map<String, dynamic> exercise) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.fitness_center, size: 40, color: Colors.green),
        title: Text(exercise["name"], style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("🏋️‍♂️ Category: ${exercise["category"]}"),
            Text("🔥 ${exercise["calories"]} kcal burned"),
            if (exercise["notes"].isNotEmpty) Text("📝 Notes: ${exercise["notes"]}"),
            Text("⏱ Time Spent: ${exercise["time"]} minutes"),
            Text("📅 ${exercise["date"].toString().split('.')[0]}"),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(String title, IconData icon, String description, Widget child, Color color) {
    return Container(
      color: color.withOpacity(0.1),
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 80, color: color),
            const SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: color.withOpacity(0.8)),
            ),
            const SizedBox(height: 20),
            child,
          ],
        ),
      ),
    );
  }

  late final List<Widget> _pages;
  late final PageController _pageController;
  late final ScrollController _bottomNavScrollController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
    _bottomNavScrollController = ScrollController();
    _pages = [
      _buildPage(
        "Add Exercise",
        Icons.fitness_center,
        "Log your exercises and track calories burned.",
        Column(
          children: [
            TextField(controller: _exerciseController, decoration: const InputDecoration(labelText: "Enter exercise name")),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: _selectedCategory,
              items: _exerciseCategories.map((String category) {
                return DropdownMenuItem(value: category, child: Text(category));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
            ),
            const SizedBox(height: 10),
            TextField(controller: _caloriesController, decoration: const InputDecoration(labelText: "Enter calories burned"), keyboardType: TextInputType.number),
            const SizedBox(height: 10),
            TextField(controller: _timeController, decoration: const InputDecoration(labelText: "Enter time spent (minutes)"), keyboardType: TextInputType.number),
            const SizedBox(height: 10),
            TextField(controller: _notesController, decoration: const InputDecoration(labelText: "Add notes (optional)")),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_exerciseController.text.isNotEmpty && _caloriesController.text.isNotEmpty && _timeController.text.isNotEmpty) {
                  setState(() {
                    int exerciseCalories = int.parse(_caloriesController.text);
                    int exerciseTime = int.parse(_timeController.text);
                    _totalCaloriesBurned += exerciseCalories;
                    _totalTimeSpent += exerciseTime;
                    _savedExercises.add({
                      "name": _exerciseController.text,
                      "category": _selectedCategory,
                      "calories": exerciseCalories,
                      "time": exerciseTime,
                      "notes": _notesController.text,
                      "date": DateTime.now(),
                    });
                    _exerciseController.clear();
                    _caloriesController.clear();
                    _timeController.clear();
                    _notesController.clear();
                  });
                  _showSnackBar("Exercise logged successfully!");
                } else {
                  _showSnackBar("Please fill in all fields.", color: Colors.red);
                }
              },
              child: const Text("Log Exercise"),
            ),
            const SizedBox(height: 20),
            _savedExercises.isNotEmpty
                ? Expanded(
              child: ListView.builder(
                itemCount: _savedExercises.length,
                itemBuilder: (context, index) => _exerciseCard(_savedExercises[index]),
              ),
            )
                : const Text("No exercises logged yet."),
          ],
        ),
        _pageColors[0]!,
      ),
      _buildPage(
        "Time to Calories",
        Icons.timer,
        "Track calories burned based on time spent.",
        Column(
          children: [
            Text("🔥 Total Calories Burned: $_totalCaloriesBurned kcal", style: const TextStyle(fontSize: 18)),
            Text("⏱ Total Time Spent: $_totalTimeSpent minutes", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _totalCaloriesBurned = 0;
                  _totalTimeSpent = 0;
                });
                _showSnackBar("Calories and time reset!", color: Colors.red);
              },
              child: const Text("Reset Data"),
            ),
          ],
        ),
        _pageColors[1]!,
      ),
      _buildPage(
        "Exercise Recommendations",
        Icons.recommend,
        "Get personalized exercise suggestions.",
        Column(
          children: _exerciseRecommendations.map((exercise) => Text(exercise, style: const TextStyle(fontSize: 16))).toList(),
        ),
        _pageColors[2]!,
      ),
      _buildPage(
        "Time Setter",
        Icons.timer,
        "Set and log your exercise time frame.",
        Column(
          children: [
            Text("⏱ Total Time Spent: $_totalTimeSpent minutes", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            TextField(controller: _timeController, decoration: const InputDecoration(labelText: "Enter time spent (minutes)"), keyboardType: TextInputType.number),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_timeController.text.isNotEmpty) {
                  setState(() {
                    _totalTimeSpent += int.parse(_timeController.text);
                    _timeController.clear();
                  });
                  _showSnackBar("Time logged successfully!");
                } else {
                  _showSnackBar("Please enter a valid time.", color: Colors.red);
                }
              },
              child: const Text("Log Time"),
            ),
          ],
        ),
        _pageColors[3]!,
      ),
      _buildPage(
        "Exercise Templates",
        Icons.save,
        "Save your favorite exercises as templates.",
        Column(
          children: [
            Text("1. Push-ups", style: const TextStyle(fontSize: 16)),
            Text("2. Squats", style: const TextStyle(fontSize: 16)),
            Text("3. Plank", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: () {}, child: const Text("Save Current Exercise as Template")),
          ],
        ),
        _pageColors[4]!,
      ),
      _buildPage(
        "Daily Exercise Plan",
        Icons.calendar_today,
        "View and customize your daily exercise plan.",
        Column(
          children: [
            Text("Morning: Jogging", style: const TextStyle(fontSize: 16)),
            Text("Afternoon: Weightlifting", style: const TextStyle(fontSize: 16)),
            Text("Evening: Yoga", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: () {}, child: const Text("Customize Plan")),
          ],
        ),
        _pageColors[5]!,
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _bottomNavScrollController.animateTo(
        index * 80.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _exerciseController.dispose();
    _caloriesController.dispose();
    _notesController.dispose();
    _timeController.dispose();
    _pageController.dispose();
    _bottomNavScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercise Tracker"),
        backgroundColor: _pageColors[_selectedIndex] ?? Colors.blue,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              context.push(const SettingScreen());
            },
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
            _bottomNavScrollController.animateTo(
              index * 80.0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
        scrollController: _bottomNavScrollController,
      ),
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final ScrollController scrollController;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: Colors.white,
      child: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.fitness_center, "Exercise", 0, Colors.green),
            _buildNavItem(Icons.timer, "Time to Calories", 1, Colors.orange),
            _buildNavItem(Icons.recommend, "Suggestions", 2, Colors.blue),
            _buildNavItem(Icons.timer, "Time Setter", 3, Colors.red),
            _buildNavItem(Icons.save, "Templates", 4, Colors.purple),
            _buildNavItem(Icons.calendar_today, "Daily Plan", 5, Colors.teal),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index, Color color) {
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: selectedIndex == index ? color : Colors.transparent,
                border: Border.all(
                  color: color,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                icon,
                size: 30,
                color: selectedIndex == index ? Colors.white : color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: selectedIndex == index ? Colors.black : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}