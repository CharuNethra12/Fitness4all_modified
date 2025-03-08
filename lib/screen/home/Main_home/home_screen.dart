import 'package:fitness4all/common/color_extensions.dart';
import 'package:fitness4all/screen/home/Main_home/line_chart.dart';
import 'package:fitness4all/screen/home/Meals/meals_screen.dart';
import 'package:fitness4all/screen/home/exercises/exercises_screen.dart';
import 'package:fitness4all/screen/home/goals/main_goal_page.dart';
import 'package:fitness4all/screen/home/settings/profile_screen.dart';
import 'package:fitness4all/screen/home/settings/settings_screen.dart';
import 'package:fitness4all/screen/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Container(), // ⚠️ Prevents infinite loop
    const MealsScreen(),
    const ProfileScreen(),
    const SettingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Profile') {
                _onItemTapped(2);
              } else if (value == 'Settings') {
                _onItemTapped(3);
              } else if (value == 'Logout') {
                FirebaseAuth.instance.signOut().then((_) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                });
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'Profile', child: Text('Profile')),
              const PopupMenuItem(value: 'Settings', child: Text('Settings')),
              const PopupMenuItem(value: 'Logout', child: Text('Logout')),
            ],
            child: const CircleAvatar(
              radius: 20.0,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, color: Colors.white),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),

      body: _selectedIndex == 0
          ? ListView( 
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Today"),
                      Text(
                        "February 20, 2025",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildCategoryItem(
                        context,
                        "assets/img/health.png",
                        "Fitness & Health Goals",
                        () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SpecificGoalSettingPage())),
                      ),
                      _buildCategoryItem(
                        context,
                        "assets/img/dumbell.png",
                        "Exercise & Activity",
                        () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ExerciseScreen())),
                      ),
                      _buildCategoryItem(
                        context,
                        "assets/img/Meals.png",
                        "Nutrition & Diet",
                        () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MealsScreen())),
                      ),
                      _buildCategoryItem(
                        context,
                        "assets/img/data.png",
                        "Personalized\nInsights and Recommendations",
                        () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen())),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Progress Gauge
                SizedBox(
                  height: 200,
                  width: 200,
                  child: SfRadialGauge(
                    axes: <RadialAxis>[
                      RadialAxis(
                        axisLineStyle: const AxisLineStyle(
                          thickness: 0.2,
                          thicknessUnit: GaugeSizeUnit.factor,
                          cornerStyle: CornerStyle.bothCurve,
                        ),
                        showTicks: false,
                        showLabels: false,
                        pointers: <GaugePointer>[
                          RangePointer(
                            color: TColor.btnNavColor,
                            value: 60,
                            cornerStyle: CornerStyle.bothCurve,
                            enableDragging: true,
                            width: 0.2,
                            sizeUnit: GaugeSizeUnit.factor,
                          ),
                        ],
                        annotations: const <GaugeAnnotation>[
                          GaugeAnnotation(
                            widget: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("2.0", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                                Text("KM", style: TextStyle(fontSize: 14)),
                              ],
                            ),
                            positionFactor: 0.0002,
                            angle: 0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 60,
                  transform: Matrix4.translationValues(0.0, -60, 0.0),
                  child: Image.asset('assets/img/running_img.jpeg'),
                ),
                Container(
                  transform: Matrix4.translationValues(0.0, -60, 0.0),
                  child: const MyLineChart(),
                ),
              ],
            )
          : _pages[_selectedIndex],

      floatingActionButton: FloatingActionButton(
        backgroundColor: TColor.secondaryColor,
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        color: TColor.btnNavColor,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              color: Colors.white,
              onPressed: () => _onItemTapped(0),
            ),
            IconButton(
              icon: const Icon(Icons.fastfood),
              color: Colors.white,
              onPressed: () => _onItemTapped(1),
            ),
            const SizedBox(width: 50),
            IconButton(
              icon: const Icon(Icons.person),
              color: Colors.white,
              onPressed: () => _onItemTapped(2),
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              color: Colors.white,
              onPressed: () => _onItemTapped(3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, String imagePath, String text, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: Image.asset(imagePath, fit: BoxFit.cover),
            ),
            const SizedBox(height: 10),
            Text(text, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12.0)),
          ],
        ),
      ),
    );
  }
}

