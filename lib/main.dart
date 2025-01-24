import 'package:flutter/material.dart';
import 'package:flutter_duo_practice/constants/app_text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_colors.dart';
import '../constants/app_routes.dart';
import '../screens/home/home.dart';
import '../screens/profile/profile.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'screens/player/player.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meditation',
      theme: ThemeData(
        textTheme: TextTheme(titleLarge: AppTextStyles.body),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.highlight,
          surface: AppColors.primaryBackground
        ),
        useMaterial3: true,
      ),
      onGenerateInitialRoutes: (String initialRoute) {
        return [
          AppRoutes.onGenerateRoute(
            RouteSettings(
              name: isLoggedIn ? AppRoutes.main : AppRoutes.landingScreen,
            ),
          )!,
        ];
      },
      onGenerateRoute: AppRoutes.onGenerateRoute,
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
  bool isPlayerPageOpened = false;

  final List<Widget> _screens = [
    const Home(),
    const Player(),
    const Profile(),
  ];

  void _onItemTapped(int index) {
    if (index == 1 && !isPlayerPageOpened) {
      isPlayerPageOpened = true;
      Navigator.pushNamed(context, AppRoutes.player).then((_) {
        setState(() {
          isPlayerPageOpened = false;
        });
      });
    } else if (index != 1) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedFontSize: 0,
        selectedFontSize: 0,
        backgroundColor: AppColors.secondaryBackground,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 40),
              label: ""
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_rounded, size: 70),
            label: "",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded, size: 40),
              label: ""
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.accent,
        unselectedItemColor: AppColors.highlight,
        onTap: _onItemTapped,
      ),
    );
  }
}
