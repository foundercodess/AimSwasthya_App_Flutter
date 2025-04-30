class GetLocationModel {
  bool? status;
  String? message;
  Locations? patientLocation;
  List<Locations>? locations;

  GetLocationModel(
      {this.status, this.message, this.patientLocation, this.locations});

  GetLocationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    patientLocation = json['patient_location'] != {}
        ? Locations.fromJson(json['patient_location'])
        : null;
    if (json['locations'] != null) {
      locations = <Locations>[];
      json['locations'].forEach((v) {
        locations!.add(Locations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (patientLocation != null) {
      data['patient_location'] = patientLocation!.toJson();
    }
    if (locations != null) {
      data['locations'] = locations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// class PatientLocation {
//   String? road;
//   String? city;
//   String? county;
//   String? stateDistrict;
//   String? state;
//   String? iSO31662Lvl4;
//   String? postcode;
//   String? country;
//   String? countryCode;
//
//   PatientLocation(
//       {this.road,
//       this.city,
//       this.county,
//       this.stateDistrict,
//       this.state,
//       this.iSO31662Lvl4,
//       this.postcode,
//       this.country,
//       this.countryCode});
//
//   PatientLocation.fromJson(Map<String, dynamic> json) {
//     road = json['road'];
//     city = json['city'];
//     county = json['county'];
//     stateDistrict = json['state_district'];
//     state = json['state'];
//     iSO31662Lvl4 = json['ISO3166-2-lvl4'];
//     postcode = json['postcode'];
//     country = json['country'];
//     countryCode = json['country_code'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['road'] = road;
//     data['city'] = city;
//     data['county'] = county;
//     data['state_district'] = stateDistrict;
//     data['state'] = state;
//     data['ISO3166-2-lvl4'] = iSO31662Lvl4;
//     data['postcode'] = postcode;
//     data['country'] = country;
//     data['country_code'] = countryCode;
//     return data;
//   }
// }

class Locations {
  int? locationId;
  String? name;
  String? latitude;
  String? longitude;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Locations(
      {this.locationId,
      this.name,
      this.latitude,
      this.longitude,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Locations.fromJson(Map<String, dynamic> json) {
    locationId = json['location_id'];
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['location_id'] = locationId;
    data['name'] = name;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

