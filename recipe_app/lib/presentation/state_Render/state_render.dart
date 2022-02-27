import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:recipe_app/app/functions.dart';
import 'package:recipe_app/presentation/resources/asset_manager.dart';
import 'package:recipe_app/presentation/resources/string_manager.dart';

import '../resources/value_manager.dart';

enum StateRenderState {
  loading,
}

class StateRender extends StatelessWidget {
  final StateRenderState stateRenderState;
  final String message;
  const StateRender(
      {Key? key, required this.stateRenderState, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRenderState) {
      case StateRenderState.loading:
        return const LoadingView();
      default:
        return Container();
    }
  }
}

class LoadingView extends StatefulWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  State<LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView>
    with TickerProviderStateMixin {
  late AnimationController _lottieAnimation;

  @override
  void initState() {
    _lottieAnimation = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _lottieAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: ValuesManager.v1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ValuesManager.v20),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ValuesManager.v20),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              AssetManager.searchAnimation,
              controller: _lottieAnimation,
              height: ValuesManager.v150,
              repeat: true,
              onLoaded: (composition) {
                _lottieAnimation
                  ..duration = composition.duration
                  ..forward()
                  ..repeat();
              },
            ),
            Text(
              StringsManager.loadingMessage,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            whiteSpaceHeight(ValuesManager.v10),
          ],
        ),
      ),
    );
  }
}
