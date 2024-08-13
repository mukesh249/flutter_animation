class DemoItem {
  int? id;
  String? title;
  String? subTitle;
  num? amount;

  DemoItem({this.id, this.title, this.subTitle, this.amount});

  DemoItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subTitle = json['subTitle'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['subTitle'] = this.subTitle;
    data['amount'] = this.amount;
    return data;
  }
}

