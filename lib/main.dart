import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/form_screen.dart';
import 'screens/list_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://xpziiukuryoftcuhbmnm.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhwemlpdWt1cnlvZnRjdWhibW5tIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzQ0ODQ0NzksImV4cCI6MjA1MDA2MDQ3OX0.OzDAAM0UCAHymmqoXz99Icl_5yFOEjUM9KISKmuDhTg',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supabase Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ListScreen(), // Tampilan daftar data
    );
  }
}
