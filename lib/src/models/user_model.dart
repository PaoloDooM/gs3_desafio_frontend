import 'package:gs3_desafio_front/src/models/profile_model.dart';
import 'package:gs3_desafio_front/src/models/telephone_number_model.dart';

import 'address_model.dart';

class UserModel {
  late int id;
  late String name;
  late String email;
  late String cpf;
  DateTime? emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  late List<AddressModel> addresses;
  late List<TelephoneNumberModel> telephoneNumbers;
  late ProfileModel profile;

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.cpf,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      required this.addresses,
      required this.telephoneNumbers,
      required this.profile});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    cpf = json['cpf'];
    emailVerifiedAt = DateTime.tryParse(json['email_verified_at'] ?? "");
    createdAt = DateTime.tryParse(json['created_at'] ?? "");
    updatedAt = DateTime.tryParse(json['updated_at'] ?? "");
    addresses = <AddressModel>[];
    if (json['addresses'] != null) {
      json['addresses'].forEach((v) {
        addresses.add(AddressModel.fromJson(v));
      });
    }
    telephoneNumbers = <TelephoneNumberModel>[];
    if (json['telephone_numbers'] != null) {
      json['telephone_numbers'].forEach((v) {
        telephoneNumbers.add(TelephoneNumberModel.fromJson(v));
      });
    }
    profile = ProfileModel.fromJson(json['profile']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['cpf'] = cpf;
    data['email_verified_at'] = emailVerifiedAt?.toIso8601String();
    data['created_at'] = createdAt?.toIso8601String();
    data['updated_at'] = updatedAt?.toIso8601String();
    data['addresses'] = addresses.map((v) => v.toJson()).toList();
    data['telephone_numbers'] =
        telephoneNumbers.map((v) => v.toJson()).toList();
    data['profile'] = profile.toJson();
    return data;
  }
}
