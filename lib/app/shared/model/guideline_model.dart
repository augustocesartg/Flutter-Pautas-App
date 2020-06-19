import 'package:mobx/mobx.dart';
import 'package:json_annotation/json_annotation.dart';

part 'guideline_model.g.dart';

@JsonSerializable()
class GuidelineModel extends GuidelineModelBase with _$GuidelineModel {
  factory GuidelineModel.fromJson(Map<String, dynamic> json) => _$GuidelineModelFromJson(json);
  Map<String, dynamic> toJson() => _$GuidelineModelToJson(this);
  
  
  GuidelineModel({int id, String title, String description, String details, String author, int userId, int status}) : 
    super(id: id, title: title, description: description, details: details, author: author, userId: userId, status: status);
}

abstract class GuidelineModelBase with Store {
  int id;

  @observable
  String title;
  @action
  changeTitle(String newTitle) => title = newTitle;

  @observable
  String description;
  @action
  changeDescription(String newDescription) => description = newDescription;

  @observable
  String details;
  @action
  changeDetails(String newDetails) => details = newDetails;

  @observable
  String author;
  @action
  changeAuthor(String newAuthor) => author = newAuthor;

  @observable
  int userId;
  @action
  changeUserId(int newUserId) => userId = newUserId;

  @observable
  int status;
  @action
  changeStatus(int newStatus) => status = newStatus;

  GuidelineModelBase({this.id, this.title, this.description, this.details, this.author, this.userId, this.status});
}