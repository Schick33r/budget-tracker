import 'package:budget_tracker/Widgets/add_budget_dialog.dart';
import 'package:budget_tracker/screens/Profile.dart';
import 'package:budget_tracker/screens/home_page.dart';
import 'package:budget_tracker/services/budget_view_model.dart';

import 'package:budget_tracker/services/theme_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<BottomNavigationBarItem> bottomNavItems = const [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
        ),
        label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
  ];

  List<Widget> pages = const [
    HomePage(),
    Profile(),
  ];

  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        elevation: 0,
        //backgroundColor: Colors.black45,
        title: const Text('Budget Tracker'),
        leading: IconButton(
          onPressed: () {
            themeService.darkTheme = !themeService.darkTheme;
          },
          icon: Icon(themeService.darkTheme ? Icons.sunny : Icons.dark_mode),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AddBudgetDialog(
                        budgetToAdd: (budget) {
                          final budgetService = Provider.of<BudgetViewModel>(
                              context,
                              listen:
                                  false); //notice the listen false => don´t rebuild that widget
                          budgetService.budget = budget;
                        },
                      );
                    });
              },
              icon: const Icon(Icons.attach_money)),
        ],
      ),
      body: pages[_currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black12,
        currentIndex: _currentPageIndex,
        selectedItemColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.grey,
        items: bottomNavItems,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
      ),
    );
  }
}
