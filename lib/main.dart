import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Initializing firebase
  await Firebase.initializeApp();

  //initializing my app
  runApp(const MyApp());
}
