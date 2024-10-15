class ProfileModel {
  String userId;
  String userName;
  String userEmail;
  String userImage;
  DateTime createDateTime;

  ProfileModel({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userImage,
    required this.createDateTime,
  });
}
