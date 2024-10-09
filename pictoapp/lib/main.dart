import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_page.dart';
import 'chat_page.dart';

void main() {
    WidgetsFlutterBinding.ensureInitialized(); // Forces portrait mode
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
    );
  }
}
