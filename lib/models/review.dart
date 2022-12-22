// ignore_for_file: public_member_api_docs, sort_constructors_first
class Review {
  final int rate;
  final String comment;
  final String workshopID;
  final String userName;
  Review({
    required this.workshopID,
    required this.userName,
    required this.rate,
    required this.comment,
  });
}
