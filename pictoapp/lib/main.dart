import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pictoapp/app_state.dart';
import 'package:pictoapp/firebase_options.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:pictoapp/currentuser.dart';
import 'package:go_router/go_router.dart'; 
import 'package:provider/provider.dart';
import 'home_page.dart';
import 'chat_page.dart';

CurrentUser user = CurrentUser(displayName: "", color: Colors.black);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(App(user: user));
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(title: 'PictoApp', user: user),
      routes: [
        // GoRoute(
        //   path: 'sign-in',
        //   builder: (context, state) {
        //     return SignInScreen(
        //       actions: [
        //         ForgotPasswordAction(((context, email) {
        //           final uri = Uri(
        //             path: '/sign-in/forgot-password',
        //             queryParameters: <String, String?>{
        //               'email': email,
        //             },
        //           );
        //           context.push(uri.toString());
        //         })),
        //         AuthStateChangeAction(((context, state) {
        //           final user = switch (state) {
        //             SignedIn state => state.user,
        //             UserCreated state => state.credential.user,
        //             _ => null
        //           };
        //           if (user == null) {
        //             return;
        //           }
        //           if (state is UserCreated) {
        //             user.updateDisplayName(user.email!.split('@')[0]);
        //           }
        //           if (!user.emailVerified) {
        //             user.sendEmailVerification();
        //             const snackBar = SnackBar(
        //                 content: Text(
        //                     'Please check your email to verify your email address'));
        //             ScaffoldMessenger.of(context).showSnackBar(snackBar);
        //           }
        //           context.pushReplacement('/');
        //         })),
        //       ],
        //     );
        //   },
        //   routes: [
        //     GoRoute(
        //       path: 'forgot-password',
        //       builder: (context, state) {
        //         final arguments = state.uri.queryParameters;
        //         return ForgotPasswordScreen(
        //           email: arguments['email'],
        //           headerMaxExtent: 200,
        //         );
        //       },
        //     ),
        //   ],
        // ),

        // GoRoute(
        //   path: 'profile',
        //   builder: (context, state) {
        //     return ProfileScreen(
        //       providers: const [],
        //       actions: [
        //         SignedOutAction((context) {
        //           context.pushReplacement('/');
        //         }),
        //       ],
        //     );
        //   },
        // ),
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
        // visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}
