class MeModel {
  String userID;
  String name;
  String email;
  String image;
  int totalBalance;
  int totalIncome;
  int totoalExpense;
  MeModel({
    required this.userID,
    required this.name,
    required this.email,
    required this.image,
    required this.totalBalance,
    required this.totalIncome,
    required this.totoalExpense,
  });

  factory MeModel.fromAPI({required Map<String, dynamic> data}) {
    return MeModel(
      userID: data['id'].toString(),
      name: data['name'].toString(),
      email: data['email'].toString(),
      image: data['image'].toString(),
      totalBalance: int.tryParse(data['totalBalance'].toString()) ?? -1,
      totalIncome: int.tryParse(data['totalIncome'].toString()) ?? -1,
      totoalExpense: int.tryParse(data['totalExpenses'].toString()) ?? -1,
    );
  }
}
//  "profile": {
//     "id": "9a2d2d96-7191-4e33-8fbd-f735cd875059",
//     "name": "max",
//     "email": "myintmyatsoe10@gmail.com",
//     "image": null,
//     "totalBalance": 798000,
//     "totalIncome": 15000,
//     "totalExpenses": 23000
//   }