import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc_events.dart';
import '../bloc/earnings_bloc.dart';
import 'graph_screen.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final TextEditingController _tickerController = TextEditingController();

  @override
  void dispose() {
    _tickerController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enter Company Ticker'),automaticallyImplyLeading: false,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tickerController,
              decoration: const InputDecoration(labelText: 'Company Ticker (e.g., MSFT)'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_tickerController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a company ticker.')),
                  );
                  return;
                }context.read<EarningsBloc>().add(FetchEarningsData(_tickerController.text));
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GraphScreen(ticker:_tickerController.text)),
                );
              },
              child: const Text('Get Earnings Data'),
            ),
          ],
        ),
      ),
    );
  }
}

