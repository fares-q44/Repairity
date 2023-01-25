// ignore_for_file: public_member_api_docs, sort_constructors_first

class Post {
  String id;
  String title = '';
  String contact = '';
  String description = '';
  String ownerId = '';
  DateTime date;
  int imgCount;
  Post({
    required this.id,
    required this.title,
    required this.contact,
    required this.description,
    required this.ownerId,
    required this.date,
    required this.imgCount,
  });
}
