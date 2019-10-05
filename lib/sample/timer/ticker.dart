class Ticker {
  Stream<int> tick({int tick}) {
    return Stream.periodic(Duration(seconds: 1), (x) => tick - x - 1)
        .take(tick);
  }
}
