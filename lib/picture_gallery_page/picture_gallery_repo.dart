import 'dart:convert';

import 'package:picgalapp/picture_gallery_page/picture_gallery_data_model.dart';
import 'package:http/http.dart' as http;

abstract class PicGalRepo {
  Future<List<PictureGalleryDataModel>> fetchPictures({required pageNumber});
}

class PicGalRepoImpl extends PicGalRepo {
  @override
  Future<List<PictureGalleryDataModel>> fetchPictures({pageNumber}) async {
    List<PictureGalleryDataModel> pictures = [];
    try {
      final uri = Uri.https(
        'picsum.photos',
        '/v2/list',
        {'page': pageNumber.toString()},
      );

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        pictures = jsonResponse
            .map((item) => PictureGalleryDataModel.fromJson(item))
            .toList();

        return pictures; // Emit loaded state
      }
      return pictures;
    } catch (e) {
      rethrow;
    }
  }
}
