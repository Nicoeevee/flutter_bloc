///Ticker类公开一个tick函数，该函数按照指定时间跨度流逝，
///并每秒钟返回一个推送剩余秒数的Stream。
class Ticker {
  ///
  /// 传入剩余的时间
  ///
  Stream<int> tick({int duration}) {
    return Stream.periodic(Duration(seconds: 1), (x) => duration - x - 1)
        .take(duration);
  }
}
