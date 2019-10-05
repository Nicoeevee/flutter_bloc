///Ticker类公开一个tick函数，该函数按照指定时间跨度流逝，
///并每秒钟返回一个推送剩余秒数的Stream。
class Ticker {
  ///
  /// 传入总时间
  /// 返回剩余时间
  ///
  Stream<int> tick({int totalTime}) {
    return Stream.periodic(Duration(seconds: 1), (int elapsedTime) {
      print('$totalTime $elapsedTime ${totalTime - 1 - elapsedTime}');
      return totalTime - 1 - elapsedTime;
    }).take(totalTime);
  }
}
