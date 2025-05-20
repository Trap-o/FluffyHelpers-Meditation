import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:fluffyhelpers_meditation/constants/app_button_styles.dart';
import 'package:fluffyhelpers_meditation/constants/private_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../constants/app_colors.dart';
import '../constants/app_routes.dart';
import '../screens/library/library.dart';
import '../screens/profile/profile.dart';
import 'constants/app_text_styles.dart';
import 'firebase_config.dart';
import 'screens/constructor/constructor.dart';
import 'screens/feed/feed.dart';
import 'screens/player/player.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: './dotenv');
  await Firebase.initializeApp(options: firebaseConfig);
  await Supabase.initialize(
    url: PrivateData.supabaseId,
    anonKey: PrivateData.supabaseApi,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FluffyHelpers',
      theme: ThemeData(
        useMaterial3: true,
          textTheme: TextTheme(
            titleLarge: AppTextStyles.title,
            titleMedium: AppTextStyles.title,
            titleSmall: AppTextStyles.title,
            bodyLarge: AppTextStyles.body,
            bodyMedium: AppTextStyles.body,
            bodySmall: AppTextStyles.body,
            displayLarge: AppTextStyles.body,
            displayMedium: AppTextStyles.body,
            displaySmall: AppTextStyles.body,
            headlineLarge: AppTextStyles.title,
            headlineMedium: AppTextStyles.title,
            headlineSmall: AppTextStyles.title,
            labelLarge: AppTextStyles.body,
            labelMedium: AppTextStyles.body,
            labelSmall: AppTextStyles.body
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.highlight,
            surface: AppColors.primaryBackground,
            brightness: Brightness.light,
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                  color: AppColors.highlight
              )
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                  color: AppColors.highlight
              )
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                  color: AppColors.highlight
              )
            ),
            labelStyle: AppTextStyles.form,
          ),
          iconButtonTheme: IconButtonThemeData(
            style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all(AppColors.text)
            )
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: AppButtonStyles.secondary
          )
      ),
      initialRoute: '/auth',
      onGenerateRoute: AppRoutes.onGenerateRoute,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FirebaseUILocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('uk')
      ],
      locale: const Locale('uk'),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const Library(),
    const Feed(),
    const Player(),
    const Constructor(),
    const Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.my_library_music_rounded, size: 40),
            label: ""
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rss_feed_rounded, size: 40),
            label: ""
          ),
          BottomNavigationBarItem(
          icon: Icon(Icons.play_circle_rounded, size: 70),
          label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note_rounded, size: 40),
            label: ""
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded, size: 40),
            label: ""
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedFontSize: 0,
        selectedFontSize: 0,
        backgroundColor: AppColors.secondaryBackground,
        selectedItemColor: AppColors.accent,
        unselectedItemColor: AppColors.highlight,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}
