// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserModel {
  final String email;
  final String name;
  final String uid;
  UserModel({
    required this.email,
    required this.name,
    required this.uid,
  });

  UserModel copyWith({
    String? email,
    String? name,
    String? uid,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'uid': uid,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] as String,
      name: map['name'] as String,
      uid: map['\$id'] as String,
    );
  }

  @override
  String toString() => 'UserModel(email: $email, name: $name, uid: $uid)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.email == email && other.name == name && other.uid == uid;
  }

  @override
  int get hashCode => email.hashCode ^ name.hashCode ^ uid.hashCode;
}
