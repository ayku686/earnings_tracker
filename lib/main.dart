import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'bloc/earnings_bloc.dart';
import 'screens/input_screen.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => EarningsBloc(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392.7,826.9),
      child: MaterialApp(
        title: 'Earnings Tracker',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const InputScreen(),
      ),
    );
  }
}
