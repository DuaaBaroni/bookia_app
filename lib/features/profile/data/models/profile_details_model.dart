class ProfileDetailsModel {
  String name;

  ProfileDetailsModel({required this.name});
}

List<ProfileDetailsModel> profileDetails = [
  ProfileDetailsModel(name: "My Orders"),
  ProfileDetailsModel(name: "Edit Profile"),
  ProfileDetailsModel(name: "Reset Password"),
  ProfileDetailsModel(name: "FAQ"),
  ProfileDetailsModel(name: "Contact Us"),
  ProfileDetailsModel(name: "Privacy & Terms"),
];
