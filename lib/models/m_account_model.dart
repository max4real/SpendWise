class AccountModel {
  int accBalance;
  String accName;
  String accType;
  String accSubType;

  AccountModel({
    required this.accBalance,
    required this.accName,
    required this.accType,
    required this.accSubType,
  });

  factory AccountModel.fromAPI({required Map<String, dynamic> data}) {
    return AccountModel(
      accBalance: data['balance'] as int,
      accName: data['name'].toString(),
      accType: data['type'].toString(),
      accSubType: data['subType'].toString(),
    );
  }
}
// "name": "Wallet",
//       "type": "WALLET",
//       "subType": "WALLET",
//       "balance": 250000