class TransactionModel {
  String tranType;
  double tranAmount;
  String categoryTag;
  String tranRemark;
  String tranDescription;
  String tranAccount;
  DateTime createDateTime;
  String tranAttachement;
  TransactionModel({
    required this.tranType,
    required this.tranAmount,
    required this.categoryTag,
    required this.tranRemark,
    required this.tranDescription,
    required this.tranAccount,
    required this.createDateTime,
    required this.tranAttachement,
  });
}
