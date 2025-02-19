import 'package:flutter/material.dart';

class MealsScreen extends StatefulWidget {
  const MealsScreen({super.key});

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    _buildPage("Add Meal", Icons.restaurant, "Add your meals and track nutrients."),
    _buildPage("Track Calories", Icons.local_fire_department, "Monitor your daily calorie intake."),
    _buildPage("Log Water Intake", Icons.local_drink, "Stay hydrated by tracking your water intake."),
    _buildPage("Set Calorie Limit", Icons.settings, "Manage your daily calorie goals."),
    _buildPage("Meal & Snack Recommendations", Icons.recommend, "Get personalized meal suggestions."),
  ];

  static Widget _buildPage(String title, IconData icon, String description) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 80, color: Colors.blueAccent),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nutrition & Meal Tracker"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.restaurant), label: "Meals"),
          BottomNavigationBarItem(icon: Icon(Icons.local_fire_department), label: "Calories"),
          BottomNavigationBarItem(icon: Icon(Icons.local_drink), label: "Water"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Limits"),
          BottomNavigationBarItem(icon: Icon(Icons.recommend), label: "Suggestions"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        backgroundColor: Colors.blueAccent,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}