import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:recipe_app/domain/bloc/States/app_states.dart';

class CameraCubit extends Cubit<CameraStates> {
  CameraCubit()
      : super(
          CameraStates(cameraTakenStatus: CameraTakenStatus.inital),
        );

  XFile? image;
  InputImage? inputImage;
  ImageLabeler? imageLabeler;
  List<ImageLabel> labels = [];
  List<String> expectedLabels = [];

  @override
  void onChange(Change<CameraStates> change) {
    super.onChange(change);
    print(change.currentState.cameraTakenStatus);
  }

  Future<void> takeImage(
      CameraController cameraController, Future<void> init) async {
    try {
      await init;
      image = await cameraController.takePicture();
      emit(state.copyWith(cameraTakenStatus: CameraTakenStatus.imageToken));
    } catch (e) {
      print(e);
    }
  }

  Future<void> applyImageLabelling() async {
    emit(CameraStates(cameraTakenStatus: CameraTakenStatus.loading));
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
      emit(
        CameraStates(
            cameraTakenStatus: CameraTakenStatus.success,
            lables: expectedLabels),
      );
    } on Exception catch (e) {
      emit(state.copyWith(
          cameraTakenStatus: CameraTakenStatus.failure, exception: e));
    }
  }
}
