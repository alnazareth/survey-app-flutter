import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseTest {
  static Future<void> testConnection() async {
    try {
      print('🔄 Iniciando prueba de Firebase...');

      final firestore = FirebaseFirestore.instance;

      // 1. Probar escritura
      print('📝 Probando escritura...');
      final docRef = await firestore.collection('test').add({
        'message': 'Hello from Flutter!',
        'timestamp': FieldValue.serverTimestamp(),
      });

      print('✅ Documento escrito con ID: ${docRef.id}');

      // 2. Probar lectura
      print('📖 Probando lectura...');
      final doc = await docRef.get();
      print('✅ Documento leído: ${doc.data()}');

      // 3. Probar eliminación (limpieza)
      print('🧹 Limpiando prueba...');
      await docRef.delete();
      print('✅ Prueba completada - Firebase funciona correctamente!');

    } catch (e) {
      print('❌ ERROR en conexión Firebase: $e');
      print('💡 Posibles soluciones:');
      print('   • Verifica google-services.json');
      print('   • Verifica internet');
      print('   • Verifica reglas de Firestore');
    }
  }
}