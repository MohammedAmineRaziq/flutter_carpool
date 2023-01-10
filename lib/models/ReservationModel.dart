class ReservationModel {
  String? publicId;
  String? firstName;
  String? lastName;
  String? profilePicture;
  String? phoneNumber;
  String? cin;
  String? birthday;

  ReservationModel(
      {this.publicId,
        this.firstName,
        this.lastName,
        this.profilePicture,
        this.phoneNumber,
        this.cin,
        this.birthday});

  ReservationModel.fromJson(Map<String, dynamic> json) {
    publicId = json['publicId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    profilePicture = json['profilePicture'];
    phoneNumber = json['phoneNumber'];
    cin = json['cin'];
    birthday = json['birthday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['publicId'] = this.publicId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['profilePicture'] = this.profilePicture;
    data['phoneNumber'] = this.phoneNumber;
    data['cin'] = this.cin;
    data['birthday'] = this.birthday;
    return data;
  }
}