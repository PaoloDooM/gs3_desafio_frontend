class AddressModel {
  late int id;
  late int userId;
  late String description;
  late String address;
  late bool principal;
  DateTime? createdAt;
  DateTime? updatedAt;

  AddressModel(
      {required this.id,
      required this.userId,
      required this.description,
      required this.address,
      required this.principal,
      this.createdAt,
      this.updatedAt});

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    description = json['description'];
    address = json['address'];
    principal = json['principal'];
    createdAt = DateTime.tryParse(json['created_at'] ?? "");
    updatedAt = DateTime.tryParse(json['updated_at'] ?? "");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['description'] = description;
    data['address'] = address;
    data['principal'] = principal;
    data['created_at'] = createdAt?.toIso8601String();
    data['updated_at'] = updatedAt?.toIso8601String();
    return data;
  }
}
