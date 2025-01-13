import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:picgalapp/picture_gallery_page/picture_gallery_bloc.dart';
import 'package:picgalapp/picture_gallery_page/picture_gallery_data_model.dart';
import 'package:picgalapp/picture_gallery_page/picture_gallery_events.dart';
import 'package:picgalapp/picture_gallery_page/picture_gallery_states.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:picgalapp/utils/assets.dart';
import 'package:picgalapp/utils/colors.dart';
import 'package:picgalapp/utils/theme_notifier.dart';
import 'package:picgalapp/widgets/custom_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PictureGalleryScreen extends StatefulWidget {
  const PictureGalleryScreen({Key? key}) : super(key: key);

  @override
  State<PictureGalleryScreen> createState() => _PictureGalleryScreenState();
}

class _PictureGalleryScreenState extends State<PictureGalleryScreen>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  int pageNumber = 1;
  bool isListMode = true;
  bool isDarkTheme = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    isDarkTheme =
        Provider.of<ThemeNotifier>(context, listen: false).isDarkTheme;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PictureGalleryBloc>().add(LoadMoreItemsEvent(pageNumber));
    });
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isLoading) {
      _loadMoreItems();
    }
  }

  void _loadMoreItems() {
    if (_isLoading ||
        context.read<PictureGalleryBloc>().state is PictureGalleryError) return;

    setState(() {
      _isLoading = true;
    });

    context.read<PictureGalleryBloc>().add(LoadMoreItemsEvent(pageNumber));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            Provider.of<ThemeNotifier>(context).appTheme?.cFFFFFF_c0B0F1C,
        // AppBar(
        //   backgroundColor:
        //       Provider.of<ThemeNotifier>(context).appTheme?.cFFFFFF_c1E2230,
        //   toolbarHeight: 70,
        //   elevation: 1,
        //   automaticallyImplyLeading: false,
        //   actions: [
        //     Expanded(
        //       child: Container(
        //         height: 70,
        //         padding: const EdgeInsets.all(10),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Stack(
        //               children: [
        //                 Container(
        //                   height: 27,
        //                   width: 60,
        //                   decoration: BoxDecoration(
        //                     border: Border.all(
        //                         width: 1,
        //                         color: Provider.of<ThemeNotifier>(context)
        //                             .appTheme
        //                             ?.cE7E8EA_c444444),
        //                     borderRadius: BorderRadius.circular(8),
        //                   ),
        //                 ),
        //                 CupertinoSlidingSegmentedControl(
        //                   groupValue: isListMode ? 0 : 1,
        //                   backgroundColor: Colors.transparent,
        //                   thumbColor: cC4C8CD,
        //                   padding: EdgeInsets.zero,
        //                   children: <int, Widget>{
        //                     0: Visibility(
        //                       visible: isListMode,
        //                       child: SvgPicture.asset(
        //                         Assets.listModeIcon,
        //                         color: c000000,
        //                         width: isListMode ? 14 : 10,
        //                       ),
        //                     ),
        //                     1: Visibility(
        //                       visible: !isListMode,
        //                       child: SvgPicture.asset(
        //                         Assets.listModeIcon,
        //                         color: c000000,
        //                         width: !isListMode ? 14 : 10,
        //                       ),
        //                     ),
        //                   },
        //                   onValueChanged: (dynamic selectedModeIndex) {
        //                     setState(() {
        //                       isListMode = !isListMode;
        //                     });
        //                   },
        //                 )
        //               ],
        //             ),
        //             Text(
        //               "PicGal",
        //               style: TextStyle(color: cFFFFFF, fontSize: 24),
        //             ),
        //             Stack(
        //               children: [
        //                 Container(
        //                   height: 27,
        //                   width: 60,
        //                   decoration: BoxDecoration(
        //                     border: Border.all(
        //                         width: 1,
        //                         color: Provider.of<ThemeNotifier>(context)
        //                             .appTheme
        //                             ?.cE7E8EA_c444444),
        //                     borderRadius: BorderRadius.circular(8),
        //                   ),
        //                 ),
        //                 CupertinoSlidingSegmentedControl(
        //                   groupValue: !isDarkTheme ? 0 : 1,
        //                   backgroundColor: Colors.transparent,
        //                   thumbColor: cC4C8CD,
        //                   padding: EdgeInsets.zero,
        //                   children: <int, Widget>{
        //                     0: Visibility(
        //                       visible: !isDarkTheme,
        //                       child: SvgPicture.asset(
        //                         Assets.lightModeIcon,
        //                         color: c000000,
        //                         width: !isDarkTheme ? 14 : 10,
        //                       ),
        //                     ),
        //                     1: Visibility(
        //                       visible: isDarkTheme,
        //                       child: SvgPicture.asset(
        //                         Assets.darkModeIcon,
        //                         color: c000000,
        //                         width: isDarkTheme ? 14 : 10,
        //                       ),
        //                     ),
        //                   },
        //                   onValueChanged: (dynamic selectedModeIndex) {
        //                     setState(() {
        //                       isDarkTheme = !isDarkTheme;
        //                     });
        //                     Provider.of<ThemeNotifier>(context, listen: false)
        //                         .onThemeChange(isDarkTheme);
        //                   },
        //                 )
        //               ],
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        body: BlocConsumer<PictureGalleryBloc, PictureGalleryState>(
          listener: (context, state) {
            if (state is PictureGalleryLoaded) {
              setState(() {
                pageNumber++;
                _isLoading = false;
              });
            } else if (state is PictureGalleryError) {
              setState(() {
                _isLoading = false;
              });
            }
          },
          builder: (context, state) {
            List<PictureGalleryDataModel?> pictures = [];
            if (state is PictureGalleryLoaded) {
              pictures = state.pictures;
            }
    
            if (_isLoading) {
              pictures = [...pictures, ...List.generate(5, (index) => null)];
            }
    
            return Column(
              children: [
                Expanded(
                  child: MasonryGridView.count(
                    key: PageStorageKey("picGalApp"),
                    controller: _scrollController,
                    crossAxisCount: isListMode ? 1 : 2,
                    itemCount: pictures.length,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    itemBuilder: (context, index) {
                      final picture = pictures[index];
                      String pictureNumber = "0";
                      try {
                        if (picture != null) {
                          int? picNumber =
                              int.tryParse((picture.id ?? "0").toString());
                          pictureNumber = ((picNumber ?? 0) + 1).toString();
                        }
                      } catch (e) {
                        pictureNumber = "";
                      }
                      return Card(
                        elevation: 2,
                        clipBehavior: Clip.hardEdge,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                child: picture == null
                                    ? Shimmer(
                                        borderRadius: 10,
                                        child: SizedBox(
                                          height: isListMode ? 200 : 100,
                                          width: double.infinity,
                                        ),
                                      )
                                    : CachedNetworkImage(
                                        key: PageStorageKey(pictureNumber),
                                        imageUrl: picture.downloadUrl ?? "",
                                        fadeInDuration: Duration(),
                                        fadeOutDuration: Duration(),
                                        placeholder: (context, url) => Shimmer(
                                          borderRadius: 10,
                                          child: SizedBox(
                                            height: isListMode ? 200 : 100,
                                          ),
                                        ),
                                      )),
                            Visibility(
                              visible: picture != null,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 5),
                                child: Text(
                                  "#$pictureNumber ${picture?.author ?? ""}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
