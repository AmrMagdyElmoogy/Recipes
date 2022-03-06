import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/functions.dart';
import '../../domain/bloc/Cubits/activity_cubit.dart';
import '../../domain/bloc/States/app_states.dart';
import '../activity/page1.dart';
import '../activity/page2.dart';
import '../activity/part3.dart';
import '../activity/part4.dart';
import '../resources/asset_manager.dart';
import '../resources/string_manager.dart';

Widget timerWidget(ActivityCubit cubit,BuildContext context)
  {

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Step ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: Colors.pink,
                                      fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                  text: '${cubit.index + 1} ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color: Colors.pink,
                                          fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: 'Of 4',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                        color: Colors.pink,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          whiteSpaceHeight(10),
                          //here what i will do ? i want to make a list of comment recipe and seconds and minutes
                          SizedBox(
                            height: 500,
                            child: PageView(
                              scrollDirection: Axis.horizontal,
                              onPageChanged: (i) {
                                cubit.changeIndex(i);
                                cubit.changeIconToPlay();
                                cubit.reinitalBarValue();
                              },
                              children: const [
                                Page1(),
                                Page2(),
                                Page3(),
                                Page4(),
                              ],
                            ),
                          ),
                        ],
                      );
  }

  Widget suggestionOfToday(ActivityCubit cubit, BuildContext context){
    return Stack(
                overflow: Overflow.visible,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      color: Colors.pink,
                      child: Opacity(
                        opacity: 0.8,
                        child: AnimatedContainer(
                          onEnd: () {
                            cubit.endOfSuggestion();
                          },
                          curve: Curves.easeIn,
                          width: cubit.widthPrimaryContainer,
                          height: cubit.heightPrimaryContainer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: const DecorationImage(
                                image: AssetImage(AssetManager.salad),
                                fit: BoxFit.cover),
                          ),
                          duration: const Duration(seconds: 1),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 250),
                    child: Center(
                      child: Text(
                        StringsManager.recipeName,
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    bottom: -30,
                    left: 90,
                    duration: const Duration(seconds: 1),
                    child: Container(
                      width: cubit.widthSecondContainer,
                      height: cubit.heightSecondContainer,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                      ),
                      child: InkWell(
                        onTap: () {
                          cubit.changeConstraints();
                        },
                        child: Container(
                          width: 140,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.pink,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.play_arrow,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                Text(
                                  StringsManager.letsTry,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
  }