import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:recipe_app/app/functions.dart';
import 'package:recipe_app/domain/bloc/Cubits/activity_cubit.dart';
import 'package:recipe_app/domain/bloc/States/app_states.dart';
import 'package:recipe_app/presentation/activity/page1.dart';
import 'package:recipe_app/presentation/activity/page2.dart';
import 'package:recipe_app/presentation/activity/part3.dart';
import 'package:recipe_app/presentation/activity/part4.dart';
import 'package:recipe_app/presentation/resources/asset_manager.dart';
import 'package:recipe_app/presentation/resources/string_manager.dart';

import '../widgets/all_widgets.dart';

class Activity extends StatefulWidget {
  const Activity({Key? key}) : super(key: key);

  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(StringsManager.suggestionOfToday,
                style: Theme.of(context).textTheme.headline6),
            whiteSpaceHeight(20),
            const CircleAvatar(
              backgroundColor: Colors.pink,
              radius: 30,
              backgroundImage: AssetImage(AssetManager.person),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 12),
              child: Text(
                StringsManager.chefName,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            BlocBuilder<ActivityCubit, ActivityStates>(
              builder: (context, state) {
                ActivityCubit cubit = BlocProvider.of<ActivityCubit>(context);
                return cubit.ended
                // Here is problem
                    ? timerWidget(cubit, context)
                    : Visibility(
                        visible: cubit.ended == true ? false : true,
                        child: suggestionOfToday(cubit,context),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
