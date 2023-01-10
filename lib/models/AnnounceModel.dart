class AnnounceModel {
  int? id;
  String? publicId;
  String? start;
  String? end;
  String? date;
  int? places;
  int? price;
  String? conductorPublicId;

  AnnounceModel(
      {this.id,
        this.publicId,
        this.start,
        this.end,
        this.date,
        this.places,
        this.price,
        this.conductorPublicId});

  AnnounceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    publicId = json['publicId'];
    start = json['start'];
    end = json['end'];
    date = json['date'];
    places = json['places'];
    price = json['price'];
    conductorPublicId = json['conductorPublicId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['publicId'] = this.publicId;
    data['start'] = this.start;
    data['end'] = this.end;
    data['date'] = this.date;
    data['places'] = this.places;
    data['price'] = this.price;
    data['conductorPublicId'] = this.conductorPublicId;
    return data;
  }
}