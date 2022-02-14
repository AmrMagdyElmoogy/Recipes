import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/app/functions.dart';
import 'package:recipe_app/presentation/resources/asset_manager.dart';
import 'package:recipe_app/presentation/resources/string_manager.dart';
import 'package:recipe_app/presentation/resources/value_manager.dart';

class TakePictureView extends StatefulWidget {
  final CameraDescription camera;
  const TakePictureView({Key? key, required this.camera}) : super(key: key);

  @override
  _TakePictureViewState createState() => _TakePictureViewState();
}

class _TakePictureViewState extends State<TakePictureView> {
  late CameraController _cameraController;
  late Future<void> initalizeCameraControllerFuture;
  @override
  void initState() {
    _cameraController =
        CameraController(widget.camera, ResolutionPreset.ultraHigh);
    initalizeCameraControllerFuture = _cameraController.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            cameraController: _cameraController,
            initalizeCameraControllerFuture: initalizeCameraControllerFuture,
          ),
          // const Align(
          //   alignment: Alignment.bottomCenter,
          //   child: ShowButtomSheetView(),
        ],
      ),
    );
  }
}

class ShowButtomSheetView extends StatefulWidget {
  late CameraController cameraController;
  late Future<void> initalizeCameraControllerFuture;
  ShowButtomSheetView(
      {Key? key,
      required this.cameraController,
      required this.initalizeCameraControllerFuture})
      : super(key: key);

  @override
  _ShowButtomSheetViewState createState() => _ShowButtomSheetViewState();
}

class _ShowButtomSheetViewState extends State<ShowButtomSheetView> {
  XFile? image;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: ValuesManager.v20),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: InkWell( 
          onTap: () async {
            takeImage();
            try {
              await widget.initalizeCameraControllerFuture;
              image =  await widget.cameraController.takePicture();
            } catch (e) {
              print(e);
            }
            showBottomSheet(
              context: context,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black,
                  ),
                  height: 200,
                  child: image == null
                      ? Center(child: Image.asset(AssetManager.food))
                      : Center(
                          child: Image.file(
                          File(image!.path),
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                        )),
                ),
              ),
            );
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

  Future<void> takeImage() async {}
}
