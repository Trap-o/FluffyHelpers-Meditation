class Music {
  final String name;
  final String creatorName;
  final String creatorId;
  final String url;

  Music({required this.name, required this.creatorName, required this.creatorId, required this.url, });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Music &&
        other.name == name &&
        other.creatorName == creatorName &&
        other.creatorId == creatorId &&
        other.url == url;
  }

  @override
  int get hashCode =>
      name.hashCode ^
      creatorName.hashCode ^
      creatorId.hashCode ^
      url.hashCode;
}