abstract class PictureGalleryEvent {}

class LoadMoreItemsEvent extends PictureGalleryEvent {
  final int pageNumber;

  LoadMoreItemsEvent(this.pageNumber);
}
