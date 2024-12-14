import 'package:flutter/material.dart';
// import 'package:apii/screens/list_mahasiswa.dart';
import 'package:apii/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:apii/services/auth_service.dart';
import 'package:apii/screens/dashboard_screen.dart';
import 'package:apii/screens/login_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';


void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MyApp());

  //beri waktu splash screen 2 detik
  await Future.delayed(const Duration(seconds: 2));
// hapus splash screen dengan function remove()
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  final AuthService _authService = AuthService();
  // const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: 'Auth Demo',
      theme: ThemeData(
        useMaterial3: false,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: StreamBuilder<User?>(
          stream: _authService.user,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              User? user = snapshot.data;
              return user == null ? LoginScreen() : DashboardScreen(user: user);
            }
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }),
    );
  }
}
