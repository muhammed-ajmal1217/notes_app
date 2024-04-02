import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notesapp_task/controller/login_provider.dart';
import 'package:notesapp_task/firebase_options.dart';
import 'package:notesapp_task/main_widgets/auth_gate.dart';
import 'package:notesapp_task/views/home.dart';
import 'package:provider/provider.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginProvider(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthGatePage(),
      ),
    );
  }
}