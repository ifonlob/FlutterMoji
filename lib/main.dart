import 'package:flutter/material.dart';
import 'package:emojihub_app/core/theme/app_theme.dart';
import 'package:emojihub_app/features/home/home_view.dart';
import 'package:emojihub_app/features/categories/category_view.dart';
import 'package:emojihub_app/features/random/random_view.dart';

void main() {
  runApp(const EmojiHubApp());
}

class EmojiHubApp extends StatelessWidget {
  const EmojiHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EmojiHub',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme, 
      home: const MainNavigator(),
    );
  }
}

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeView(),
    CategoryView(),
    RandomView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey.shade400,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 10,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_outlined),
            activeIcon: Icon(Icons.grid_view_rounded),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            activeIcon: Icon(Icons.category_rounded),
            label: 'Categorías',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shuffle_outlined),
            activeIcon: Icon(Icons.shuffle_rounded),
            label: 'Aleatorio',
          ),
        ],
      ),
    );
  }
}