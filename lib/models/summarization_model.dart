class SummarizationModel {
  Status status;
  String summary;

  SummarizationModel({this.status, this.summary});

  SummarizationModel.fromJson(Map<String, dynamic> json) {
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    summary = json['summary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    data['summary'] = this.summary;
    return data;
  }
}

class Status {
  String code;
  String msg;
  String credits;
  String remainingCredits;

  Status({this.code, this.msg, this.credits, this.remainingCredits});

  Status.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    credits = json['credits'];
    remainingCredits = json['remaining_credits'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    data['credits'] = this.credits;
    data['remaining_credits'] = this.remainingCredits;
    return data;
  }
}
