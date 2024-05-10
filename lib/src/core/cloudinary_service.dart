import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class CloudinaryService {
//  static const String cloudName = 'your_cloud_name';
  static const String uploadPreset = 'xboh7dxo';
  final Dio dio = Dio();

  Future<String> uploadImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return '';

    String fileName = image.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(image.path, filename: fileName),
      "upload_preset": uploadPreset,
      "api_key": "924864744826299",
    });

    try {
      var response = await dio.post(
        'https://api.cloudinary.com/v1_1/djn5re91w/upload',
        data: formData,
      );

      if (response.statusCode == 200) {
        return response.data['secure_url']; // URL of the uploaded image
      }
      return '';
    } catch (e) {
      print('Error uploading image: $e');
      throw Exception('Failed to upload image');
    }
  }
}
