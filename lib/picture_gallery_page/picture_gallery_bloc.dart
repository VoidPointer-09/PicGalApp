// picture_gallery_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picgalapp/picture_gallery_page/picture_gallery_events.dart';
import 'package:picgalapp/picture_gallery_page/picture_gallery_repo.dart';
import 'package:picgalapp/picture_gallery_page/picture_gallery_states.dart';

class PictureGalleryBloc
    extends Bloc<PictureGalleryEvent, PictureGalleryState> {
      PicGalRepoImpl picGalRepo;
  PictureGalleryBloc({required this.picGalRepo}) : super(PictureGalleryInitial()) {
    on<LoadMoreItemsEvent>((event, emit) async {
      try {
        final newPictures = await picGalRepo.fetchPictures(pageNumber: event.pageNumber);

        if (state is PictureGalleryLoaded) {
          final existingPictures = (state as PictureGalleryLoaded).pictures;
          emit(PictureGalleryLoaded([...existingPictures, ...newPictures]));
        } else {
          emit(PictureGalleryLoaded(newPictures));
        }
      } catch (e) {
        emit(PictureGalleryError(e.toString()));
      }
    });
  }
}
