import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foundit/providers/chat_provider.dart';
import 'package:foundit/screens/create/create_screen.dart';
import 'package:foundit/screens/create/widgets/create_app_bar.dart';
import 'package:foundit/screens/home/home_screen.dart';
import 'package:foundit/screens/home/widgets/home_app_bar.dart';
import 'package:foundit/screens/login_and_signup/login/login_screen.dart';
import 'package:foundit/screens/main/widgets/main_bottom_bar.dart';
import 'package:foundit/screens/main_chat/main_chat_screen.dart';
import 'package:foundit/screens/main_chat/widgets/main_chat_screen_app_bar.dart';
import 'package:foundit/screens/profile/profile_screen.dart';
import 'package:foundit/screens/profile/widgets/profile_app_bar.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return Scaffold(
              appBar: getAppBar(),
              body: getBody(),
              bottomNavigationBar: MainBottomBar(
                index: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            );
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }

  getBody() {
    switch (_currentIndex) {
      case 1:
        return ChangeNotifierProvider(
          create: (_) => ChatProvider(),
          child: const MainChatScreen(),
        );
      case 2:
        return const CreateScreen();
      case 3:
        return const ProfileScreen();
      default:
        return const HomeScreen(
          myItems: false,
        );
    }
  }

  getAppBar() {
    switch (_currentIndex) {
      case 2:
        return const CreateAppBar();
      case 3:
        return const ProfileAppBar();
      case 1:
        return const MainChatAppBar();
      default:
        return const HomeAppBar();
    }
  }
}
