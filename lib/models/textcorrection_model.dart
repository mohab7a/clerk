class TextCorrectionModel {
  String output;
  int producedOverallCorrections;

  TextCorrectionModel({this.output, this.producedOverallCorrections});

  TextCorrectionModel.fromJson(Map<String, dynamic> json) {
    output = json['Output: '];
    producedOverallCorrections = json['Produced overall corrections: '];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Output: '] = this.output;
    data['Produced overall corrections: '] = this.producedOverallCorrections;
    return data;
  }
}
