import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:recipe_app/domain/bloc/States/app_states.dart';

class CameraCubit extends Cubit<CameraStates> {
  CameraCubit()
      : super(
          CameraStates(status: CameraTakenStatus.inital),
        );

  XFile? image;
  InputImage? inputImage;
  ImageLabeler? imageLabeler;
  List<ImageLabel> labels = [];
  List<String> expectedLabels = [];

  Future<void> takeImage(
      CameraController cameraController, Future<void> init) async {
    try {
      await init;
      image = await cameraController.takePicture();
    } catch (e) {
      print(e);
    }
  }

  Future<void> applyImageLabelling() async {
    emit(state.copyWith(cameraTakenStatus: CameraTakenStatus.loading));
    expectedLabels.clear();
    try {
      inputImage = InputImage.fromFilePath(image!.path);
      imageLabeler = GoogleMlKit.vision.imageLabeler();
      labels = await imageLabeler!.processImage(inputImage!);
      for (ImageLabel label in labels) {
        final String text = label.label;
        final double confidence = label.confidence;
        if (confidence > 0.7) {
          expectedLabels.add(text);
        }
      }
      emit(state.copyWith(
          cameraTakenStatus: CameraTakenStatus.success,
          expectedLabels: expectedLabels));
    } on Exception catch (e) {
      emit(state.copyWith(
          cameraTakenStatus: CameraTakenStatus.failure, exception: e));
    }
  }
}
