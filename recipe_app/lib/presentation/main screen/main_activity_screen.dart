import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipe_app/domain/bloc/Cubits/main_activity_cubit.dart';
import 'package:recipe_app/domain/bloc/States/app_states.dart';
import 'package:recipe_app/presentation/resources/asset_manager.dart';
import 'package:recipe_app/presentation/resources/color_manager.dart';
import 'package:recipe_app/presentation/resources/routes_manager.dart';
import 'package:recipe_app/presentation/resources/string_manager.dart';
import 'package:recipe_app/presentation/resources/value_manager.dart';

class MainActivityScreen extends StatefulWidget {
  const MainActivityScreen({Key? key}) : super(key: key);

  @override
  _MainActivityScreenState createState() => _MainActivityScreenState();
}

class _MainActivityScreenState extends State<MainActivityScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainActivityCubit, RecipeStates>(
      builder: (context, state) {
        var cubit = BlocProvider.of<MainActivityCubit>(context);
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                const FaIcon(
                  FontAwesomeIcons.sun,
                  color: Colors.blueGrey,
                ),
                const SizedBox(
                  width: ValuesManager.v10,
                ),
                Text(
                  StringsManager.goodMorning,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
          body: cubit.screens[cubit.navBarIndex],
          bottomNavigationBar: BottomAppBar(
            notchMargin: ValuesManager.v5,
            color: Colors.white,
            elevation: ValuesManager.v10,
            shape: const CircularNotchedRectangle(),
            child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      index = cubit.navBarChangeIndex(0);
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.home,
                      color: index == 0
                          ? ColorManager.selectedColor
                          : ColorManager.unSelectedColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      index = cubit.navBarChangeIndex(1);
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.chartArea,
                      color: index == 1
                          ? ColorManager.selectedColor
                          : ColorManager.unSelectedColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      index = cubit.navBarChangeIndex(2);
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.save,
                      color: index == 2
                          ? ColorManager.selectedColor
                          : ColorManager.unSelectedColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      index = cubit.navBarChangeIndex(3);
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.questionCircle,
                      color: index == 3
                          ? ColorManager.selectedColor
                          : ColorManager.unSelectedColor,
                    ),
                  ),
                ]),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              startCamera(context);
            },
            child: const Image(
              image: AssetImage(AssetManager.scanIcon),
              fit: BoxFit.cover,
              width: ValuesManager.v20,
              height: ValuesManager.v20,
            ),
            elevation: ValuesManager.vElevation,
            backgroundColor: Colors.black,
          ),
        );
      },
    );
  }

  Future<void> startCamera(BuildContext context) async {
    final cameras = await availableCameras();
    final camera = cameras.first;

    final result = await Navigator.of(context).pushNamed(Routes.cameraView,arguments: camera);
  }
}
