class PersonalModal {
  int? id;
  String? firstname;
  String? lastname;
  PersonalModal({
    this.id,
    this.firstname,
    this.lastname,
  });

  factory PersonalModal.fromJson(Map<String, dynamic> json) {
    return PersonalModal(
      id: json['id'] as int,
      firstname: json['first_name'] as String,
      lastname: json['last_name'] as String,
    );
  }
    Map<String, dynamic> toMap() => {
        "id": id,
        "first_name": firstname,
        "last_name": lastname,
    };
}
