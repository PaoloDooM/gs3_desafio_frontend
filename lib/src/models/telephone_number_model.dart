class TelephoneNumberModel {
  late int id;
  late int userId;
  late String description;
  late String number;
  late bool principal;
  DateTime? createdAt;
  DateTime? updatedAt;

  TelephoneNumberModel(
      {required this.id,
      required this.userId,
      required this.description,
      required this.number,
      required this.principal,
      this.createdAt,
      this.updatedAt});

  TelephoneNumberModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    description = json['description'];
    number = json['number'];
    principal = json['principal'];
    createdAt = DateTime.tryParse(json['created_at'] ?? "");
    updatedAt = DateTime.tryParse(json['updated_at'] ?? "");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['description'] = description;
    data['number'] = number;
    data['principal'] = principal;
    data['created_at'] = createdAt?.toIso8601String();
    data['updated_at'] = updatedAt?.toIso8601String();
    return data;
  }
}
