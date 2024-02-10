import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_sqflite_bloc/cubit/crud_cubit.dart';

import 'pages/add_todo.dart';
import 'pages/home_page.dart';
import 'pages/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CrudCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

class SqFliteDemo extends StatelessWidget {
  const SqFliteDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Bloc + Sqflite'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.black87,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => const AddTodoPage()));
        },
      ),
      body: const HomePage(),
    );
  }
}
