class Contact {
  final int? id;
  final String name;
  final String phone;

  Contact({this.id, required this.name, required this.phone});
  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'name': name,
      'phone': phone,
    };
  }
  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
    );
  }
  // Helper method for updating contact with new data (used in Provider)
  Contact copyWith({
    int? id,
    String? name,
    String? phone,
  }) {
    return Contact(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }
}
