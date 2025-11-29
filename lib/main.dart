import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/app.dart';
//import 'firebase_test.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized(); // ← IMPORTANTE

  // Inicializar Firebase
  await Firebase.initializeApp(); // ← NUEVO


  // ✅ EJECUTAR PRUEBA DE CONEXIÓN
//  await FirebaseTest.testConnection();

  runApp(const MyApp());
}