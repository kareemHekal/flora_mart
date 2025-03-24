/// firstName : "Mariam"
/// lastName : "Shahir"
/// email : "mariamshahir2000@gmail.com"
/// gender : "female"
/// phone : "+201554195222"
/// photo : "default-profile.png"
/// role : "user"
/// wishlist : []
/// _id : "67dfe0e1836ee8be7062578c"
/// addresses : []
/// createdAt : "2025-03-23T10:22:25.485Z"

class UserEntity {
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  String? phone;
  String? photo;
  String? role;
  List<dynamic>? wishlist;
  String? id;
  List<dynamic>? addresses;
  String? createdAt;

  UserEntity({
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.phone,
    this.photo,
    this.role,
    this.wishlist,
    this.id,
    this.addresses,
    this.createdAt,
  });
}
