class MeModel {
  String name;
  String email;
  String image;
  int totalBalance;
  int totalIncome;
  int totoalExpense;
  MeModel({
    required this.name,
    required this.email,
    required this.image,
    required this.totalBalance,
    required this.totalIncome,
    required this.totoalExpense,
  });

  factory MeModel.fromAPI({required Map<String, dynamic> data}) {
    return MeModel(
      name: data['name'].toString(),
      email: data['email'].toString(),
      image: data['email'].toString(),
      totalBalance: int.tryParse(data['email'].toString()) ?? -1,
      totalIncome: int.tryParse(data['email'].toString()) ?? -1,
      totoalExpense: int.tryParse(data['email'].toString()) ?? -1,
    );
  }
}
// "_data": {
//     "name": "max",
//     "email": "myintmyatsoe10@gmail.com"
//   },