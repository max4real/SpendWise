class TransactionModel {
  String tranType;
  double tranAmount;
  String categoryID;
  String tranRemark;
  String tranDescription;
  String tranAccountID;
  DateTime createDateTime;
  String tranAttachement;
  TransactionModel({
    required this.tranType,
    required this.tranAmount,
    required this.categoryID,
    required this.tranRemark,
    required this.tranDescription,
    required this.tranAccountID,
    required this.createDateTime,
    required this.tranAttachement,
  });
  
}
