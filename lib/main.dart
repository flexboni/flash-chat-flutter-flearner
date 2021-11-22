import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  FlashChat({Key? key}) : super(key: key);

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              theme: ThemeData.dark().copyWith(
                textTheme: const TextTheme(
                  bodyText2: TextStyle(color: Colors.black54),
                  subtitle1: TextStyle(color: Colors.black),
                ),
              ),
              initialRoute: WelcomeScreen.id,
              routes: <String, WidgetBuilder>{
                WelcomeScreen.id: (BuildContext context) =>
                    const WelcomeScreen(),
                LoginScreen.id: (BuildContext context) => const LoginScreen(),
                RegistrationScreen.id: (BuildContext context) =>
                    const RegistrationScreen(),
                ChatScreen.id: (BuildContext context) => const ChatScreen(),
              },
            );
          }
          return const CircularProgressIndicator();
        });
  }
}
