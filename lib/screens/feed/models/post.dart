class Post {
  final String? title;
  final String? description;
  final String ownerId;
  final String ownerName;
  final String ownerAvatar;
  final int likesNumber;
  final List<String>? playlistsIdList;
  final String createdAt;

  Post(
      {required this.title,
      required this.description,
      required this.ownerId,
      required this.ownerName,
      required this.ownerAvatar,
      required this.likesNumber,
      required this.playlistsIdList,
      required this.createdAt});
}
