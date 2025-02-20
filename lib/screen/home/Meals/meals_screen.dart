import 'package:flutter/material.dart';

class MealsScreen extends StatefulWidget {
  const MealsScreen({super.key});

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  int _selectedIndex = 0;
  final TextEditingController _mealController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _waterController = TextEditingController();
  final TextEditingController _calorieLimitController = TextEditingController();

  int _calories = 0;
  int _calorieLimit = 2000;
  int _waterIntake = 0;
  final List<Map<String, dynamic>> _savedMeals = [];
  final List<String> _waterLogs = [];
  final List<String> _mealRecommendations = [
    "🥗 Salad with Grilled Chicken",
    "🍳 Scrambled Eggs with Avocado Toast",
    "🍲 Lentil Soup with Whole Grain Bread",
    "🥑 Greek Yogurt with Berries & Nuts",
    "🥜 Peanut Butter Banana Smoothie"
  ];

  final Map<int, Color> _pageColors = {
    0: Colors.green,
    1: Colors.orange,
    2: Colors.blue,
    3: Colors.red,
    4: Colors.purple,
    5: Colors.teal,
  };

  final List<String> _mealCategories = ["Breakfast", "Lunch", "Dinner", "Snack"];
  String _selectedCategory = "Lunch";

  void _showSnackBar(String message, {Color color = Colors.green}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _saveMeal() {
    if (_mealController.text.isNotEmpty && _caloriesController.text.isNotEmpty) {
      setState(() {
        _savedMeals.add({
          "name": _mealController.text,
          "calories": int.tryParse(_caloriesController.text) ?? 0,
          "category": _selectedCategory,
          "notes": _notesController.text,
          "date": DateTime.now(),
        });

        _calories += int.tryParse(_caloriesController.text) ?? 0;
        _mealController.clear();
        _caloriesController.clear();
        _notesController.clear();
      });

      _showSnackBar("Meal saved successfully!", color: Colors.green);
    } else {
      _showSnackBar("Enter meal name & calories!", color: Colors.red);
    }
  }

  void _setCalorieLimit() {
    if (_calorieLimitController.text.isNotEmpty) {
      setState(() {
        _calorieLimit = int.tryParse(_calorieLimitController.text) ?? _calorieLimit;
      });
      _showSnackBar("Calorie limit updated to $_calorieLimit kcal", color: Colors.red);
    }
  }

  void _addWaterIntake() {
    if (_waterController.text.isNotEmpty) {
      setState(() {
        _waterIntake += int.tryParse(_waterController.text) ?? 0;
        _waterLogs.add("${_waterController.text} ml at ${DateTime.now().toString().split('.')[0]}");
        _waterController.clear();
      });
      _showSnackBar("Water intake added!", color: Colors.blue);
    } else {
      _showSnackBar("Enter water intake!", color: Colors.red);
    }
  }

  Widget _mealCard(Map<String, dynamic> meal) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.fastfood, size: 40, color: Colors.green),
        title: Text(meal["name"], style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("🍽️ Category: ${meal["category"]}"),
            Text("🔥 ${meal["calories"]} kcal"),
            if (meal["notes"].isNotEmpty) Text("📝 Notes: ${meal["notes"]}"),
            Text("📅 ${meal["date"].toString().split('.')[0]}"),
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

  @override
  void initState() {
    super.initState();
    _pages = [
      _buildPage(
        "Add Meal",
        Icons.restaurant,
        "Add your meals and track nutrients.",
        Column(
          children: [
            TextField(controller: _mealController, decoration: const InputDecoration(labelText: "Enter meal name")),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: _selectedCategory,
              items: _mealCategories.map((String category) {
                return DropdownMenuItem(value: category, child: Text(category));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
            ),
            const SizedBox(height: 10),
            TextField(controller: _caloriesController, decoration: const InputDecoration(labelText: "Enter calories"), keyboardType: TextInputType.number),
            const SizedBox(height: 10),
            TextField(controller: _notesController, decoration: const InputDecoration(labelText: "Add notes (optional)")),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _saveMeal, child: const Text("Save Meal")),
            const SizedBox(height: 20),
            _savedMeals.isNotEmpty
                ? Expanded(
              child: ListView.builder(
                itemCount: _savedMeals.length,
                itemBuilder: (context, index) => _mealCard(_savedMeals[index]),
              ),
            )
                : const Text("No meals saved yet."),
          ],
        ),
        _pageColors[0]!,
      ),
      _buildPage(
        "Set Calorie Limit",
        Icons.settings,
        "Manage your daily calorie goals.",
        Column(
          children: [
            Text("📏 Current Calorie Limit: $_calorieLimit kcal", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            TextField(controller: _calorieLimitController, decoration: const InputDecoration(labelText: "Enter new limit"), keyboardType: TextInputType.number),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _setCalorieLimit, child: const Text("Update Limit")),
          ],
        ),
        _pageColors[3]!,
      ),
      _buildPage(
        "Water Intake",
        Icons.local_drink,
        "Track your daily water intake.",
        Column(
          children: [
            Text("💧 Total Water Intake: $_waterIntake ml", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            TextField(controller: _waterController, decoration: const InputDecoration(labelText: "Enter water intake (ml)"), keyboardType: TextInputType.number),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _addWaterIntake, child: const Text("Add Water Intake")),
            const SizedBox(height: 20),
            if (_waterLogs.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _waterLogs.length,
                  itemBuilder: (context, index) => ListTile(title: Text(_waterLogs[index])),
                ),
              )
            else
              const Text("No water intake logged yet."),
          ],
        ),
        _pageColors[2]!,
      ),
      _buildPage(
        "Meal & Snack Recommendations",
        Icons.recommend,
        "Get personalized meal suggestions.",
        Column(
          children: _mealRecommendations.map((meal) => Text(meal, style: const TextStyle(fontSize: 16))).toList(),
        ),
        _pageColors[4]!,
      ),
      _buildPage(
        "Calorie Tracker",
        Icons.track_changes,
        "Track your total calorie intake.",
        Column(
          children: [
            Text("🔥 Total Calories Consumed: $_calories kcal", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _calories = 0; // Reset calories if needed
                });
                _showSnackBar("Calories reset!", color: Colors.red);
              },
              child: const Text("Reset Calories"),
            ),
          ],
        ),
        _pageColors[5]!,
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _mealController.dispose();
    _caloriesController.dispose();
    _notesController.dispose();
    _waterController.dispose();
    _calorieLimitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nutrition & Meal Tracker"), backgroundColor: _pageColors[_selectedIndex], centerTitle: true),
      body: AnimatedSwitcher(duration: const Duration(milliseconds: 300), child: _pages[_selectedIndex]),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        _buildNavItem(Icons.restaurant, "Meals", 0),
        _buildNavItem(Icons.settings, "Limits", 1),
        _buildNavItem(Icons.local_drink, "Water", 2),
        _buildNavItem(Icons.track_changes, "Calories", 3),
        _buildNavItem(Icons.recommend, "Suggestions", 4),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.blue,
      onTap: onItemTapped,
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: selectedIndex == index ? Colors.blue : Colors.transparent,
          border: Border.all(
            color: selectedIndex == index ? Colors.white : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          icon,
          color: selectedIndex == index ? Colors.white : Colors.grey,
        ),
      ),
      label: label,
    );
  }
}