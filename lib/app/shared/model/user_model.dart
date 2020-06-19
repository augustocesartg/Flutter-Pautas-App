import 'package:mobx/mobx.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends UserModelBase with _$UserModel {
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
  
  
  UserModel({int id, String name, String email, String password}) : 
    super(id: id, name: name, email: email, password: password);
}

abstract class UserModelBase with Store {
  int id;

  @observable
  String name;
  @action
  changeName(String newName) => name = newName;

  @observable
  String email;
  @action
  changeEmail(String newEmail) => email = newEmail;

  @observable
  String password;
  @action
  changePassword(String newPassword) => password = newPassword;

  UserModelBase({this.id, this.name, this.email, this.password});
}