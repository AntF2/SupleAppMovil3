import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyBMvmjnmDJfyamXGSG_ByMe1H4oonNVFSk',
      appId: '1:334398861229:android:daf88937a5aab4ae7ebb24',
      messagingSenderId: '334398861229',  
      projectId: 'supletorio-d4f36',
    ),
  );
  runApp(
    const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicación de Mensajería',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(uid: ''), 
    );
  }
}
