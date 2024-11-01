import '../models/earnings_data.dart';

abstract class EarningsState {
  final bool isLoading;

  EarningsState({required this.isLoading});
}

class EarningsInitial extends EarningsState {
  EarningsInitial({required isLoading}) : super(isLoading: isLoading);
}

class EarningsLoading extends EarningsState {
  EarningsLoading({required isLoading}) : super(isLoading: isLoading);
}

class EarningsLoaded extends EarningsState {
  final List<EarningsData> data;
  EarningsLoaded({required this.data,required isLoading}) : super(isLoading: isLoading);
}

class TranscriptLoaded extends EarningsState {
  final String transcript;
  TranscriptLoaded({required this.transcript,required isLoading}) : super(isLoading: isLoading);
}