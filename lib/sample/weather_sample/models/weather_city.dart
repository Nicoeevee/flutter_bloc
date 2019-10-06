class WeatherCity {
  String title;
  String locationType;
  String lattLong;
  int woeid;

  WeatherCity({this.title, this.locationType, this.lattLong, this.woeid});

  WeatherCity.fromJson(Map<String, dynamic> json) {
    this.title = json['title'];
    this.locationType = json['location_type'];
    this.lattLong = json['latt_long'];
    this.woeid = json['woeid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['location_type'] = this.locationType;
    data['latt_long'] = this.lattLong;
    data['woeid'] = this.woeid;
    return data;
  }
}
