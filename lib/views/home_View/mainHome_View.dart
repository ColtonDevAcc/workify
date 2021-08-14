import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:workify/theme/theme.dart';
import 'package:workify/views/home_View/_widgets/navigationRail_Widget.dart';
import 'package:workify/views/home_View/_widgets/nutritionStatisticsContainer_Widget.dart';
import 'package:workify/views/home_View/_widgets/progressStatisticsList_Widget.dart';
import 'package:workify/views/home_View/_widgets/workoutList_Widget.dart';
import 'package:workify/views/mealPlan_View/NutritonMain_View.dart';
import 'package:workify/views/recovery/recoveryView.dart';
import 'package:workify/views/relationShip_View/relationshipMain_View.dart';
import 'package:workify/views/saved/savedView.dart';
import 'package:workify/views/trainer/trainerView.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int indexSelected = 1;
  var _currentIndex = 0;
  final List<Widget> _children = [
    MainView(),
    Nutrition_View(),
    SavedView(),
    GroupView(),
    RecoveryView(),
    TrainerView(),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Apptheme.mainBackgroundColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              color: Apptheme.mainBackgroundColor,
              width: size.width * .2,
              height: size.height,
              child: NavigationRail_Widget(),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: size.height,
              width: size.width * .82,
              color: Apptheme.mainBackgroundColor,
              child: _currentIndex == 0 ? homeView(context: context) : _children[_currentIndex],
            ),
          ),
        ],
      ),
    );
  }

  Container homeView({context: BuildContext}) {
    return Container(
      color: Apptheme.mainBackgroundColor,
      child: ListView(
        children: [
          SizedBox(height: AppBar().preferredSize.height - 45),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'HOW YOUR DAY LOOKS',
                  textScaleFactor: 1.4,
                  style: TextStyle(
                    color: Apptheme.mainButonColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Stats',
                  textScaleFactor: 1.2,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                NutritionStatisticsContainer_Widget(
                  color: Color.fromRGBO(253, 117, 5, 1),
                  icon: LineIcons.tint,
                  value: .73,
                ),
                NutritionStatisticsContainer_Widget(
                  color: Color.fromRGBO(230, 64, 64, 1),
                  icon: Icons.local_fire_department,
                  value: .30,
                ),
                NutritionStatisticsContainer_Widget(
                  color: Color.fromRGBO(87, 54, 232, 1),
                  icon: LineIcons.drumstickWithBiteTakenOut,
                  value: .9,
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 0, 10),
                child: Text(
                  'Daily workouts',
                  textScaleFactor: 1.2,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * .35,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * .02),
                    WorkoutList_Widget(),
                    WorkoutList_Widget(),
                    WorkoutList_Widget(),
                  ],
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                child: Text(
                  'Progress',
                  textScaleFactor: 1.2,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * .02),
                    ProgressStatisticsList_Widget(),
                    ProgressStatisticsList_Widget(),
                    ProgressStatisticsList_Widget(),
                    ProgressStatisticsList_Widget(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}