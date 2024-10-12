import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pictoapp/firebase_options.dart';
import 'home_page.dart';
import 'chat_page.dart';

Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized(); // Forces portrait mode
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Initialize Firebase with the options
    );
    SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    ]);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PictoApp',
      theme: ThemeData(
        buttonTheme: Theme.of(context).buttonTheme.copyWith(
              highlightColor: Colors.blue,
            ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        // visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      // If you want to view ChatPage before it is connected via navigation, 
      // then comment out the below line and uncomment the other.
      home: const HomePage(title: 'PictoApp'), 
      // home: const ChatPage(title: 'PictoApp'),
      routes: {
        '/chatpage':(context) => const ChatPage(title: 'Chat'),
        '/homepage':(context) => const HomePage(title: 'Home'),
      }
    );
  }
}
