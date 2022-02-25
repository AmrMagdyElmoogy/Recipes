import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:recipe_app/app/functions.dart';
import 'package:recipe_app/domain/bloc/Cubits/camera_cubit.dart';
import 'package:recipe_app/domain/bloc/States/app_states.dart';
import 'package:recipe_app/presentation/resources/routes_manager.dart';
import 'package:recipe_app/presentation/resources/string_manager.dart';
import 'package:recipe_app/presentation/resources/value_manager.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/presentation/state_Render/state_render.dart';

class TakePictureView extends StatefulWidget {
  final CameraDescription? camera;
  const TakePictureView({Key? key, this.camera}) : super(key: key);

  @override
  _TakePictureViewState createState() => _TakePictureViewState();
}

class _TakePictureViewState extends State<TakePictureView> {
  late CameraController _cameraController;
  late Future<void> initalizeCameraControllerFuture;
  @override
  void initState() {
    _cameraController =
        CameraController(widget.camera!, ResolutionPreset.ultraHigh);
    initalizeCameraControllerFuture = _cameraController.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CameraCubit, CameraStates>(listener: (context, state) {
      if (state.status == CameraTakenStatus.loading) {
        const StateRender(
            stateRenderState: StateRenderState.loading,
            message: StringsManager.loadingMessage);
      }
    }, builder: (context, state) {
      CameraCubit cubit = BlocProvider.of<CameraCubit>(context);
      return Scaffold(
        body: Stack(
          children: [
            FutureBuilder(
              future: initalizeCameraControllerFuture,
              builder: (BuildContext context, AsyncSnapshot snapShot) {
                if (snapShot.connectionState == ConnectionState.done) {
                  final scale = ValuesManager.v1 /
                      (_cameraController.value.aspectRatio *
                          MediaQuery.of(context).size.aspectRatio);
                  return Center(
                    child: Transform.scale(
                      scale: scale,
                      child: CameraPreview(_cameraController),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: ValuesManager.v50),
              child: Align(
                alignment: Alignment.topCenter,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close,
                          color: Colors.white, size: ValuesManager.v30),
                    ),
                    whiteSpaceWidth(ValuesManager.v60),
                    Text(
                      StringsManager.recipeLens,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            ShowButtomSheetView(
              cameraStates: state,
              cubit: cubit,
              cameraController: _cameraController,
              initalizeCameraControllerFuture: initalizeCameraControllerFuture,
            ),
          ],
        ),
      );
    });
  }
}

class ShowButtomSheetView extends StatefulWidget {
  late CameraCubit cubit;
  late CameraStates cameraStates;
  late CameraController cameraController;
  late Future<void> initalizeCameraControllerFuture;
  ShowButtomSheetView(
      {Key? key,
      required this.cubit,
      required this.cameraStates,
      required this.cameraController,
      required this.initalizeCameraControllerFuture})
      : super(key: key);

  @override
  _ShowButtomSheetViewState createState() => _ShowButtomSheetViewState();
}

class _ShowButtomSheetViewState extends State<ShowButtomSheetView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: ValuesManager.v20),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: InkWell(
          onTap: () async {
            await widget.cubit.takeImage(widget.cameraController,
                widget.initalizeCameraControllerFuture);
            await widget.cubit.applyImageLabelling();
            Navigator.of(context).pushNamed(Routes.searchWebView,
                arguments: widget.cameraStates.expectedLabels);
          
          },
          child: Container(
            width: ValuesManager.v100,
            height: ValuesManager.v100,
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Padding(
              padding: const EdgeInsets.all(ValuesManager.v5),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(ValuesManager.v50),
                  color: Colors.white,
                ),
                child: const Icon(
                  Icons.fastfood_rounded,
                  size: ValuesManager.v40,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
