import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/repositories/survey_repository.dart';
import '../providers/survey_provider.dart';
import '../screens/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => SurveyRepository()),
        ChangeNotifierProvider(
          create: (context) {
            final repository = context.read<SurveyRepository>();
            final provider = SurveyProvider(repository);

            repository.initialize();
            return provider;
          },
        ),
      ],
      child: MaterialApp(
        title: 'Surveys',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}