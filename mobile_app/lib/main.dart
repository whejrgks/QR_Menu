import 'package:flutter/material.dart';
import 'screens/menu_list_screen.dart';
import 'screens/admin_login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR 메뉴판',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: MenuListScreen(),
      routes: {
        '/admin': (context) => const AdminLoginScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

