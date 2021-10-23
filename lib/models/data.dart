class Data {
  String submissionId='';
  String submissionUrl='';
  String submissionTitle='';
  String permalink='';
  String author='';
  String created='';
  String timestamp='';

  Data({
      required this.submissionId,
      required this.submissionUrl,
      required this.submissionTitle,
      required this.permalink,
      required this.author,
      required this.created,
      required this.timestamp
  });

  Data.fromJson(Map<String, dynamic> json) {
    submissionId = json['submission_id'];
    submissionUrl = json['submission_url'];
    submissionTitle = json['submission_title'];
    permalink = json['permalink'];
    author = json['author'];
    created = json['created'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['submission_id'] = this.submissionId;
    data['submission_url'] = this.submissionUrl;
    data['submission_title'] = this.submissionTitle;
    data['permalink'] = this.permalink;
    data['author'] = this.author;
    data['created'] = this.created;
    data['timestamp'] = this.timestamp;
    return data;
  }
}