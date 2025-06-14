import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:fluffyhelpers_meditation/constants/private_data.dart';
import 'package:fluffyhelpers_meditation/screens/player/embedded_music.dart';
import 'package:fluffyhelpers_meditation/screens/user_mixes_list/list_audio_controller.dart';
import 'package:fluffyhelpers_meditation/screens/user_mixes_list/mixes_fetching.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../constants/app_colors.dart';
import '../constants/app_routes.dart';
import '../screens/library/library.dart';
import '../screens/profile/profile.dart';
import 'constants/main_text_theme.dart';
import 'firebase_config.dart';
import 'l10n/app_localizations.dart';
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
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final prefs = await SharedPreferences.getInstance();
  final language = prefs.getString('language') ?? "en";
  final pet = prefs.getString('pet') ?? "cat";

  runApp(
    ChangeNotifierProvider(
      create: (_) => AudioController(),
      child: MyApp(locale: Locale(language), pet: pet),
    ),
  );
}

void Function(String)? changeLanguageCallback;
void Function(String)? changePetCallback;

class MyApp extends StatefulWidget {
  final Locale locale;
  final String pet;

  const MyApp({super.key, required this.locale, required this.pet});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale _locale;
  String? _pet;

  void _changeLanguage(String languageCode) async {
    setState(() {
      _locale = Locale(languageCode);
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', languageCode);
  }

  void _changePet(String petCode) async {
    setState(() {
      _pet = petCode;
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('pet', petCode);
  }

  @override
  void initState() {
    super.initState();
    _locale = widget.locale;
    _pet = widget.pet;
    changeLanguageCallback = _changeLanguage;
    changePetCallback = _changePet;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FluffyHelpers',
      theme: MainAppTheme.appTheme,
      initialRoute: '/auth',
      onGenerateRoute: AppRoutes.onGenerateRoute,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FirebaseUILocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('uk')
      ],
      locale: _locale,

      debugShowCheckedModeBanner: false,
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
  List<Map<String, dynamic>>? mixes;

  @override
  void initState() {
    super.initState();
    _loadMixes();
  }

  Future<void> _loadMixes() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var fetchedMixes = await MixesFetching().fetchMixesByUser(user.uid);
      if (fetchedMixes.isNotEmpty) {
        setState(() {
          mixes = fetchedMixes;
        });
      }else{
        fetchedMixes = await EmbeddedMusic().fetchEmbeddedMixes();
        setState(() {
          mixes = fetchedMixes;
        });
      }
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final String navBarItemText = localizations.bottomNavBarItem;

    FlutterNativeSplash.remove();

    if (mixes == null) {
      return const Scaffold(
        backgroundColor: AppColors.primaryBackground,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final List<Widget> screens = [
      const Library(),
      const Feed(),
      Player(mixes: mixes!),
      Constructor(onCreated: _loadMixes),
      const Profile(),
    ];

    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: IndexedStack(
        index: _selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        unselectedFontSize: 0,
        selectedFontSize: 0,
        backgroundColor: AppColors.secondaryBackground,
        selectedItemColor: AppColors.accent,
        unselectedItemColor: AppColors.highlight,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: const Icon(Icons.my_library_music_rounded, size: 40),
              label: navBarItemText),
          BottomNavigationBarItem(
              icon: const Icon(Icons.rss_feed_rounded, size: 40),
              label: navBarItemText),
          BottomNavigationBarItem(
              icon: const Icon(Icons.play_circle_rounded, size: 70),
              label: navBarItemText),
          BottomNavigationBarItem(
              icon: const Icon(Icons.music_note_rounded, size: 40),
              label: navBarItemText),
          BottomNavigationBarItem(
              icon: const Icon(Icons.account_circle_rounded, size: 40),
              label: navBarItemText),
        ],
      ),
    );
  }
}