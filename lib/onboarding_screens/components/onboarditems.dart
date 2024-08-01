// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OnBoardItems {
  final String image;
  final String title;
  final String shortDescription;
  OnBoardItems({
    required this.image,
    required this.title,
    required this.shortDescription,
  });


  OnBoardItems copyWith({
    String? image,
    String? title,
    String? shortDescription,
  }) {
    return OnBoardItems(
      image: image ?? this.image,
      title: title ?? this.title,
      shortDescription: shortDescription ?? this.shortDescription,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'title': title,
      'shortDescription': shortDescription,
    };
  }

  factory OnBoardItems.fromMap(Map<String, dynamic> map) {
    return OnBoardItems(
      image: map['image'] as String,
      title: map['title'] as String,
      shortDescription: map['shortDescription'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OnBoardItems.fromJson(String source) => OnBoardItems.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'OnBoardItems(image: $image, title: $title, shortDescription: $shortDescription)';

  @override
  bool operator ==(covariant OnBoardItems other) {
    if (identical(this, other)) return true;

    return
      other.image == image &&
          other.title == title &&
          other.shortDescription == shortDescription;
  }

  @override
  int get hashCode => image.hashCode ^ title.hashCode ^ shortDescription.hashCode;
}
