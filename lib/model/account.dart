import 'package:json_annotation/json_annotation.dart';
part 'account.g.dart';

@JsonSerializable()
class Account{
  Account(this.userName, this.title, this.name, this.middlename, this.surname, this.gender, this.dob, this.registered, this.email, this.phone);
  String userName = "";
  String title = "";
  String name = "";
  String middlename = "";
  String surname = "";
  String gender = "";
  DateTime dob = DateTime.fromMicrosecondsSinceEpoch(0);
  String email = "";
  String phone = "";
  DateTime registered = DateTime.fromMicrosecondsSinceEpoch(0);

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);
  Map<String, dynamic> toJson () => _$AccountToJson(this);

  Account.fromJsonRandomPerson(Map<String, dynamic> json){
    gender = json["gender"];
    userName = json[""];
    title = json["name"]["title"];
    name = json["name"]["first"];
    middlename = json["name"]["title"];
    surname = json["name"]["surname"];
    dob = json["dob"]["date"];
    email = json["email"];
    phone = json["cell"];
    registered = json["registered"]["date"];
  }
}