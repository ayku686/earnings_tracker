import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/api_service.dart';
import 'bloc_events.dart';
import 'bloc_states.dart';



class EarningsBloc extends Bloc<EarningsEvent, EarningsState> {
  final ApiService apiService = ApiService();

  EarningsBloc() : super(EarningsInitial(isLoading: true)) {
    on<FetchEarningsData>(_onFetchEarningsData);
    on<FetchTranscript>(_onFetchTranscript);
  }

  void _onFetchEarningsData(
      FetchEarningsData event, Emitter<EarningsState> emit) async {
    emit(EarningsLoading(isLoading: true));
    final data = await apiService.fetchEarningsData(event.ticker);
    emit(EarningsLoaded(data: data,isLoading: false));
  }

  void _onFetchTranscript(FetchTranscript event, Emitter<EarningsState> emit) async {
    emit(EarningsLoading(isLoading: true));
    final transcript = await apiService.fetchTranscript(event.ticker, event.quarter, event.year);
    emit(TranscriptLoaded(transcript: transcript,isLoading: false));
  }
}
