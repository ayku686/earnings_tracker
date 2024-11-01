class EarningsData {
  final String priceDate;
  final String ticker;
  final double actualEps;
  final double estimatedEps;
  final int actualRevenue;
  final int estimatedRevenue;


  EarningsData(this.priceDate, this.ticker, this.actualEps, this.estimatedEps,
      this.actualRevenue, this.estimatedRevenue);

  factory EarningsData.fromJson(Map<String, dynamic> json) {
    return EarningsData(
      json['pricedate'],
      json['ticker'],
      json['actual_eps'],
      json['estimated_eps'],
      json['actual_revenue'],
      json['estimated_revenue'],
    );
  }
}
