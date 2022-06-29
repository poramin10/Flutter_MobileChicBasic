import 'package:image_picker/image_picker.dart';

class CreateEvaluationParam {
  List<XFile?>? locationImage;
  double? maxWidth;
  double? maxHeight;
  double? imageQuality;

  CreateEvaluationParam({
    required locationImage,
    required maxWidth,
    required maxHeight,
    required imageQuality,
  });
}