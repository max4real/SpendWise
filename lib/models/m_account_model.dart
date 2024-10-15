class AccountModel {
  double accBalance;
  String accName;
  String accType;
  String accSubType;

  AccountModel({
    required this.accBalance,
    required this.accName,
    required this.accType,
    required this.accSubType,
  });

  //  factory DetailModel.fromAPI({required Map<String, dynamic> data}) {
  //   return DetailModel(
  //       guestId: data["id"].toString(),
  //       guestName: data["name"].toString(),
  //       guestPhone: data["phone"].toString(),
  //       guestGender: data["gender"].toString(),
  //       guestStartDate:
  //           DateTime.tryParse(data["startDate"].toString()) ?? DateTime.now(),
  //       guestEndDate:
  //           DateTime.tryParse(data["dueDate"].toString()) ?? DateTime.now(),
  //       dueDays: int.tryParse(data["day"].toString()) ?? -1,
  //       spendAmount: int.tryParse(data["spendAmount"].toString()) ?? -1,
  //       totalMonth: int.tryParse(data["totalMonth"].toString()) ?? -1);
  // }
}
