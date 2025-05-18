import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_ce/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 2)
class UserModel {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String number;

  @HiveField(3)
  String email;

  @HiveField(4)
  String profile;

  /// Constructor for UserModel.
  UserModel({
    this.id,
    required this.name,
    required this.number,
    required this.email,
    required this.profile,
  });

  /// Factory method to create a UserModel instance from JSON data.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      name: json['name'],
      number: json['number'],
      email: json['email'],
      profile: json['profile'],
    );
  }

  /// Factory method to create an empty UserModel instance.
  factory UserModel.empty() {
    return UserModel(
      id: '',
      name: '',
      number: '',
      email: '',
      profile: '',
    );
  }

  /// Convert the UserModel instance to a map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'number': number,
      'email': email,
      'profile': profile,
    };
  }

  /// Factory method to create a UserModel instance from a map.
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      number: map['number'],
      email: map['email'],
      profile: map['profile'],
    );
  }

  /// Convert the UserModel instance to JSON format.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'number': number,
      'email': email,
      'profile': profile,
    };
  }

  /// Factory method to create a UserModel instance from a document snapshot.
  factory UserModel.fromSnapshot(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    return UserModel(
      id: data['id'] ?? "N/A",
      name: data['name'] ?? "N/A",
      number: data['number'] ?? "N/A",
      email: data['email'] ?? "N/A",
      profile: data['profile'] ?? "N/A",
    );
  }

  /// Get formatted phone number.
  // String get formattedPhoneNo => Formatter.formatPhoneNumber(number);

  /// Split name into parts.
  static List<String> nameParts(String name) => name.split(' ');
}
