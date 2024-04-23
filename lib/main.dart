import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:foundit/firebase/firebase_messaging.dart';
import 'package:foundit/providers/item_provider.dart';
import 'package:foundit/providers/user_provider.dart';
import 'package:foundit/screens/main/main_screen.dart';
import 'package:foundit/screens/main_chat/chat/chat_screen.dart';
import 'package:foundit/theme/my_theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAdqxz5L9jvf-XWdgzi2H59_aJbsUzOgGY',
      appId: '1:463178975903:android:48dc72a0f8d2c2ada6f0aa',
      messagingSenderId: '463178975903',
      projectId: 'foundit-4b1d6',
      storageBucket: 'foundit-4b1d6.appspot.com',
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ItemProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      builder: (context, child) {
        FirebaseMessage().requestPermission();
        FirebaseMessage().sendMessage();
        return MaterialApp(
          routes: {
            '/': (context) => const MainScreen(),
          },
          initialRoute: '/',
          theme: myTheme,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
