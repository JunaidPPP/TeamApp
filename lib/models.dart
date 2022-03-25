class LeaderShipModel {
  int id;
  String name;
  String startDate;
  String contactNumber;
  String designation;
  String province;
  String division;
  String district;
  LeaderShipModel({
    required this.id,
    required this.name,
    required this.startDate,
    required this.contactNumber,
    required this.designation,
    required this.province,
    required this.division,
    required this.district,
  });
}

class EventsModel {
  int id;
  String name;
  String startDate;
  String contactNumber;
  String designation;
  String province;
  String division;
  String district;
  EventsModel({
    required this.id,
    required this.name,
    required this.startDate,
    required this.contactNumber,
    required this.designation,
    required this.province,
    required this.division,
    required this.district,
  });
}

class TaranyModel {
  int id;
  String name;
  String song;
  String thumbnail;
  String artist;

  TaranyModel({
    required this.id,
    required this.name,
    required this.song,
    required this.thumbnail,
    required this.artist,
  });
}
