import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:manage_gym/common/extensions/context.dart';
import 'package:manage_gym/features/athlete/presentation/pages/athlete_list_screen.dart';
import 'package:manage_gym/features/gym/presentation/blocs/gym_bloc/gym_bloc.dart';
import 'package:manage_gym/features/menu/presentation/menu_screen.dart';

import '../../locator.dart';
import '../gym/presentation/pages/gym_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 1;
  final pageViewController = PageController(initialPage: 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: SnakeNavigationBar.color(
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.white,
          snakeViewColor: context.colorScheme.primary,
          shadowColor: Colors.black,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          snakeShape: SnakeShape.rectangle,
          showSelectedLabels: true,
          currentIndex: selectedIndex,
          height: 65,
          selectedLabelStyle: context.textTheme.labelMedium,
          onTap: (index) => setState(() {
            selectedIndex = index;
            pageViewController.animateToPage(index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease);
          }),
          items: [
            BottomNavigationBarItem(
                icon: const Icon(Icons.fitness_center), label: 'gym'.tr()),
            BottomNavigationBarItem(
                icon: const Icon(Icons.home), label: 'home'.tr()),
            BottomNavigationBarItem(
                icon: const Icon(Icons.menu), label: 'menu'.tr()),
          ],
        ),
        body: SafeArea(
          child: PageView(
            controller: pageViewController,
            children: <Widget>[
              BlocProvider(
                create: (context) => sl<GymBloc>(),
                child: const GymScreen(),
              ),
              const AthleteListScreen(),
              const MenuScreen()
            ],
            onPageChanged: (index) => setState(() => selectedIndex = index),
          ),
        ));
  }
}
