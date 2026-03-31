class PlaceOrderParams {
  final String name;
  final String email;
  final String address;
  final String phone;
  final int governorateId;

  PlaceOrderParams({
    required this.name,
    required this.email,
    required this.address,
    required this.phone,
    required this.governorateId,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'address': address,
      'phone': phone,
      'governorate_id': governorateId,
    };
  }
}