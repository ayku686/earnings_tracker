import 'package:expense_tracker/screens/input_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../bloc/bloc_states.dart';
import '../bloc/earnings_bloc.dart';

class TranscriptScreen extends StatefulWidget {
  const TranscriptScreen({super.key});

  @override
  State<TranscriptScreen> createState() => _TranscriptScreenState();
}

class _TranscriptScreenState extends State<TranscriptScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Earnings Transcript'),leading:
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => InputScreen()),
            );
          },
        ),
      ),
      body: BlocBuilder<EarningsBloc, EarningsState>(
        builder: (context, state) {
          //print(state);
          if (state is EarningsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TranscriptLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0.sp),
                child: Text(state.transcript),
              ),
            );
          } else {
            return const Center(child: Text('No transcript available'));
          }
        },
      ),
    );
  }
}
