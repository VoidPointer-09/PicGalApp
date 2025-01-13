import 'package:picgalapp/picture_gallery_page/picture_gallery_data_model.dart';

abstract class PictureGalleryState {}

class PictureGalleryInitial extends PictureGalleryState {}

class PictureGalleryLoading extends PictureGalleryState {}

class PictureGalleryLoaded extends PictureGalleryState {
  final List<PictureGalleryDataModel> pictures;

  PictureGalleryLoaded(this.pictures);
}

class PictureGalleryError extends PictureGalleryState {
  final String message;

  PictureGalleryError(this.message);
}
