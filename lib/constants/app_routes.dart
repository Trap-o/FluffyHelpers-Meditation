import 'package:flutter/material.dart';

import '../main.dart';
import '../screens/auth_screens/auth.dart';
import '../screens/constructor/constructor.dart';
import '../screens/feed/feed.dart';
import '../screens/library/models/sub_category.dart';
import '../screens/library/playlist_creator.dart';
import '../screens/player/player.dart';
import '../screens/profile/profile.dart';
import '../screens/settings/settings.dart';
import '../screens/sub_category_details/sub_category_details.dart';

class AppRoutes {
  static const String main = "/";
  static const String library = "/library";
  static const String feed = "/feed";
  static const String player = "/player";
  static const String constructor = "/constructor";
  static const String profile = "/profile";
  static const String settingsScreen = "/settings";
  static const String subCategoryDetails = "/subCategoryDetails";
  static const String auth = "/auth";
  static const String newPlaylistDialog = "/newPlaylist";
  static const String playlistCreator = "/playlistCreator";
  //static const String webBrowser = "/innerBrowser";

  static MaterialPageRoute? onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (BuildContext context) {
        switch (settings.name) {
          case main:
            return const MainPage();
          case library:
            return const Library();
          case feed:
            return const Feed();
          case player:
            return const Player();
          case constructor:
            return const Constructor();
          case profile:
            return const Profile();
          case settingsScreen:
            return const Settings();
          case subCategoryDetails:
            final subCategory = settings.arguments as SubCategory;
            return SubCategoryDetails(subCategory: subCategory);
          case auth:
            return const Auth();
          case newPlaylistDialog:
            return const NewPlaylistDialog();
          case playlistCreator:
            return const PlaylistCreator();
          // case webBrowser:
          //   return const InnerBrowser();
          default:
            return const Auth();
        }
      },
    );
  }
}