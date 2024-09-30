class ProfileModel {
  late int id;
  late String label;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProfileModel(
      {required this.id, required this.label, this.createdAt, this.updatedAt});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    createdAt = DateTime.tryParse(json['created_at'] ?? "");
    updatedAt = DateTime.tryParse(json['updated_at'] ?? "");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['label'] = label;
    data['created_at'] = createdAt?.toIso8601String();
    data['updated_at'] = updatedAt?.toIso8601String();
    return data;
  }
}
