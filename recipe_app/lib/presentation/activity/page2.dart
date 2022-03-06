import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:recipe_app/domain/bloc/Cubits/activity_cubit.dart';
import 'package:recipe_app/domain/bloc/States/app_states.dart';
import 'package:recipe_app/presentation/resources/asset_manager.dart';

import '../../app/functions.dart';

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> with TickerProviderStateMixin {
  late AnimationController lottie;
  @override
  void initState() {
    lottie = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    lottie.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ActivityCubit cubit = BlocProvider.of<ActivityCubit>(context);
    return BlocBuilder<ActivityCubit, ActivityStates>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
              child: Text(
                cubit.comments[cubit.index],
                style: Theme.of(context).textTheme.caption!.copyWith(
                      color: Colors.grey,
                    ),
              ),
            ),
            whiteSpaceHeight(10),
            SizedBox(
              width: 150,
              height: 150,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    //here
                    value: cubit.barValue / 120,
                    strokeWidth: 4,
                    valueColor: const AlwaysStoppedAnimation(
                        Color.fromARGB(255, 226, 110, 56)),
                    backgroundColor: Colors.grey,
                  ),
                  Center(
                    child: cubit.minutes[cubit.index] == 0 &&
                            cubit.seconds[cubit.index] == 0
                        ? Lottie.asset(AssetManager.doneAnimation,
                            controller: lottie, onLoaded: (l) {
                            lottie
                              ..duration = l.duration
                              ..forward();
                          })
                        : Lottie.asset(AssetManager.foodAnimation,
                            controller: lottie, onLoaded: (l) {
                            lottie
                              ..duration = l.duration
                              ..forward()
                              ..repeat();
                          }),
                  ),
                ],
              ),
            ),
            whiteSpaceHeight(10),
            Text(
              '${cubit.minutes[cubit.index]} : ${cubit.seconds[cubit.index]}',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.pink,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            whiteSpaceHeight(10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                border: Border.all(
                  color: const Color.fromARGB(255, 248, 180, 149),
                  width: 10,
                ),
              ),
              child: ElevatedButton(
                onPressed: () {
                  if (cubit.icon == cubit.play) {
                    cubit.startTimer();
                    cubit.changeIconToPause();
                  } else {
                    cubit.stopTimer();
                    cubit.changeIconToPlay();
                  }
                },
                child: Icon(cubit.icon, color: Colors.white, size: 35),
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 226, 110, 56),
                  shape: const CircleBorder(),
                  fixedSize: const Size(66, 66),
                  elevation: 1,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
