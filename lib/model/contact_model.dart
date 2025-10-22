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
}
