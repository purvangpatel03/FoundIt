import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
      apiKey: 'your Api key',
      appId: 'your app id',
      messagingSenderId: 'your messagingSenderId',
      projectId: 'your projectId',
      storageBucket: 'your storageBucket',
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
