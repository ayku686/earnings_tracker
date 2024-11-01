abstract class EarningsEvent {}

class FetchEarningsData extends EarningsEvent {
  final String ticker;
  FetchEarningsData(this.ticker);
}

class FetchTranscript extends EarningsEvent {
  final String ticker;
  final int quarter;
  final int year;
  FetchTranscript(this.ticker, this.quarter, this.year);
}



