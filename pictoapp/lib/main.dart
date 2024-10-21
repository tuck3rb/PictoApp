import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pictoapp/firebase_options.dart';
import 'package:pictoapp/currentuser.dart';
import 'package:go_router/go_router.dart'; 
import 'home_page.dart';
import 'chat_page.dart';

CurrentUser user = CurrentUser(displayName: "", color: Colors.black);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // ensures portrait mode only
  ]);
  runApp(App(user: user));
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(title: 'PictoApp', user: user),
      routes: [
        GoRoute(
          path: 'chatpage',
          builder: (context, state) {
            return ChatPage(title: 'Chat', user: user);
          },
        ),
      ],
    ),
  ],
);

class App extends StatelessWidget {
  const App({super.key, required this.user});

  final CurrentUser user;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'PictoApp',
      theme: ThemeData(textTheme: Theme.of(context).textTheme.apply(
        fontSizeFactor: 1.3,
        fontSizeDelta: 2.0,
        fontFamily: 'Pictochat',
      ), 
        buttonTheme: Theme.of(context).buttonTheme.copyWith(
              highlightColor: Colors.blue,
            ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      routerConfig: _router, // assists with navigation
    );
  }
}
