class ChefEntity {
  final String name;
  final String email;
  final String phoneNumber;
  final String address;
  final num? salary;
  ChefEntity({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
    this.salary,
  });
}
