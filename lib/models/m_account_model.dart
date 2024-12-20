class AccountModel {
  String accId;
  int accBalance;
  String accName;
  String accType;
  String accSubType;

  AccountModel({
    required this.accId,
    required this.accBalance,
    required this.accName,
    required this.accType,
    required this.accSubType,
  });

  factory AccountModel.fromAPI({required Map<String, dynamic> data}) {
    return AccountModel(
      accId: data['id'].toString(),
      accBalance: int.tryParse(data['balance'].toString()) ?? -1,
      accName: data['name'].toString(),
      accType: data['accountType'].toString(),
      accSubType: data['accountSubType'].toString(),
    );
  }
}
// {
//     "id": "c88b1c85-f611-46c8-bd6c-e48213bde3f5",
//     "name": "My Kpay",
//     "balance": 500000,
//     "accountSu  bType": "KBZPAY",
//     "accountType": "PAY",
//     "userId": "9a2d2d96-7191-4e33-8fbd-f735cd875059",
//     "createdAt": "2024-12-18T04:07:32.537Z",
//     "updatedAt": "2024-12-18T04:07:32.537Z",
//     "transaction": [],
//     "totalIncome": 0,
//     "totalExpenses": 0
//   }
// "name": "Wallet",
//       "type": "WALLET",
//       "subType": "WALLET",
//       "balance": 250000