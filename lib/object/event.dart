class EventData {
  late final String image;
  late final String headline;
  late final String summary;
  late final List<int> trend;
  late final Map<String, List<dynamic>> news;
  late final List<String> stocks;
  late final List<double> stockImpacts;
  late final Map<String, double> prediction;
  late final Map<String, String> stats;
  late final List<dynamic> relevant;
  EventData(Map<String, dynamic> data, this.image) {
    headline = data['headline'];
    summary = data['summary'];
    trend = List<int>.from(data['trend']);
    news = Map<String, List<dynamic>>.from(data['news']);
    stocks = List<String>.from(data['stocks']);
    stockImpacts = List<double>.from(data['stockImpacts']);
    prediction = Map<String, double>.from(data['prediction']);
    stats = Map<String, String>.from(data['stats']);
    relevant = List.from(data['relevant']);
  }
}
