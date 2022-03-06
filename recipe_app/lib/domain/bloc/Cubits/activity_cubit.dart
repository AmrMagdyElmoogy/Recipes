import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/domain/bloc/States/app_states.dart';

class ActivityCubit extends Cubit<ActivityStates> {
  //what these????
  ActivityCubit()
      : super(
          ActivityStates(activityStatus: ActivityStatus.inital),
        );

  int index = 0;
  var play = Icons.play_arrow;
  var pause = Icons.pause;
  var icon = Icons.play_arrow;
  bool ended = false;

  double widthPrimaryContainer = 400;
  double heightPrimaryContainer = 350;
  double widthSecondContainer = 160;
  double heightSecondContainer = 80;

  List<int> minutes = [2, 1, 4, 3];
  List<int> seconds = [0, 30, 30, 30];
  double barValue = 120;
  //continue here
  List<String> comments = [
    'Arrange a rack in the middle of the oven and heat to 425°F. While the oven heats, marinate the salmon and soak the onions',
    'Whisk the olive oil, vinegar, lemon juice, garlic, oregano, salt, and pepper together in large bowl. Transfer 3 tablespoons of the vinaigrette to a baking dish large enough to hold all the pieces of salmon in one layer',
    'Add the salmon, turning them over gently a few times to evenly coat in the vinaigrette. Cover and refrigerate. Place the onion and water in a small bowl and set aside for 10 minutes to make the onion less potent',
    'Uncover the salmon and roast until it is cooked through and flakes easily, 8 to 12 minutes. An instant-read thermometer into the middle of the thickest fillet should register 120°F to 130°F for medium-rare, or 135°F to 145°F if you prefer it more well-done.',
  ];

  Timer? timer;
  void startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      if (seconds[index] == 0 && minutes[index] > 0) {
        seconds[index] = 60;
        minutes[index]--;
        seconds[index]--;
        barValue--;
        emit(ActivityStates(activityStatus: ActivityStatus.startTimerFirst));
      } else if (seconds[index] <= 60) {
        if (seconds[index] == 0 && minutes[index] == 0) {
          stopTimer(reset: false);
        } else {
          seconds[index]--;
          barValue--;
          emit(ActivityStates(activityStatus: ActivityStatus.startTimerSecond));
        }
      }
    });
  }

  void stopTimer({bool reset = true}) {
    timer!.cancel();
    emit(ActivityStates(activityStatus: ActivityStatus.timerCancelation));
  }

  void changeIconToPlay() {
    icon = play;
    emit(ActivityStates(activityStatus: ActivityStatus.iconChanged));
  }

  void changeIconToPause() {
    icon = pause;
    emit(ActivityStates(activityStatus: ActivityStatus.iconChanged));
  }

  void changeIndex(int i) {
    index = i;
    emit(ActivityStates(activityStatus: ActivityStatus.indexChanged));
  }

  void reinitalBarValue() {
    barValue = minutes[index] * 60;
    emit(ActivityStates(activityStatus: ActivityStatus.barValueReinital));
  }

  void endOfSuggestion() {
    ended = true;
    emit(ActivityStates(
        activityStatus: ActivityStatus.endedOfSuggestionOfToday));
  }

  void changeConstraints() {
    double widthPrimaryContainer = 0;
    double heightPrimaryContainer = 0;
    double widthSecondContainer = 0;
    double heightSecondContainer = 0;
    emit(ActivityStates(
        activityStatus: ActivityStatus.changeConstraintsOfContainer));
  }
}
