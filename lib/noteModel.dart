class Note {
  String text;
  bool status;
  String category;

  Note({this.category, this.text, this.status});
  Map toJson() => {
        'category': category,
        'status': status,
        'text': text,
      };
}
