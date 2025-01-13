// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:picgalapp/picture_gallery_page/picture_gallery_bloc.dart';
import 'package:picgalapp/picture_gallery_page/picture_gallery_repo.dart';
import 'package:picgalapp/picture_gallery_page/picture_gallery_screen.dart';
import 'package:picgalapp/utils/colors.dart';
import 'package:picgalapp/utils/theme_notifier.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PictureGalleryBloc>(
          create: (_) => PictureGalleryBloc(picGalRepo: PicGalRepoImpl()),
        ),
        ChangeNotifierProvider(create: (_) {
          final isDarkTheme =
              WidgetsBinding.instance.window.platformBrightness ==
                  Brightness.dark;
          return ThemeNotifier(isDarkTheme);
        }),
      ],
      child: Consumer<ThemeNotifier>(builder: (context, themeNotifier, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'PicGal',
          theme: ThemeData(
            scaffoldBackgroundColor: cFFFFFF,
            appBarTheme: AppBarTheme(
              backgroundColor: cFFFFFF,
              elevation: 1,
            ),
            colorScheme: ColorScheme.light(
              primary: cE3530F,
              onPrimary: Colors.white,
              secondary: Colors.red,
            ),
            cardTheme: CardTheme(
              color: Colors.white,
              elevation: 4,
            ),
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            textTheme: TextTheme(
              headline6: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              subtitle2: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
              bodyText1: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          darkTheme: ThemeData(
            scaffoldBackgroundColor: c0B0F1C,
            appBarTheme: AppBarTheme(
              backgroundColor: c1E2230,
              elevation: 1,
            ),
            colorScheme: ColorScheme.dark(
              primary: cE3530F,
              onPrimary: Colors.white,
              secondary: Colors.red,
            ),
            cardTheme: CardTheme(
              color: Colors.black,
              elevation: 4,
            ),
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            textTheme: TextTheme(
              headline6: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              subtitle2: TextStyle(
                color: Colors.white70,
                fontSize: 18.0,
              ),
              bodyText1: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          themeMode:
              themeNotifier.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
          home: PictureGalleryScreen(),
        );
      }),
    );
  }
}
