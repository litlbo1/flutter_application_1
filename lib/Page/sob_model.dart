import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String? name;
  final String? email;
  final String? role;

  UserData({this.name, this.email, this.role});

  factory UserData.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserData(
        name: data?['name'], email: data?['email'], role: data?['role']);
  }
  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (email != null) "email": email,
      if (role != null) "role": role
    };
  }
}
