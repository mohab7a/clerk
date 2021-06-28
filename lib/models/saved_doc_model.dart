class SavedDocModel {
  String docName;
  String docContent;

  SavedDocModel({
    this.docName,
    this.docContent,
  });
  SavedDocModel.fromJson(Map<String, dynamic> json) {
    docName = json["docName"];
    docContent = json["docContent"];
  }
  Map<String, dynamic> toMap() {
    return {
      'docName': docName,
      'docContent': docContent,
    };
  }
}
