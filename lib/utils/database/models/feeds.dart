final String Feeds = 'feeds';

class FeedFields {
  static final List<String> values = [
/// Add all fields
id, image, title, date, author, caption, description,
];
  static final String id = 'id';
  static final String image = 'image';
  static final String title = 'title';
  static final String date = 'date';
  static final String author = 'author';
  static final String caption = 'caption';
  static final String description = 'description';
}

class Feed {
  final int? id;
  final String image;
  final String title;
  final String date;
  final String author;
  final String caption;
  final String description;

  const Feed({
    this.id,
    required this.image,
    required this.title,
    required this.date,
    required this.author,
    required this.caption,
    required this.description,
  });

  Feed copy({
    int? id,
    String? image,
    String? title,
    String? date,
    String? author,
    String? caption,
    String? description,
  }) =>
      Feed(
        id: id ?? this.id, 
        author: author ?? this.author,
        caption: caption ?? this.caption, 
        date: date ?? this.date, 
        description: description ?? this.description, 
        image: image ?? this.image, 
        title: title ?? this.title,

        );

  Map<String, Object?> toJson() => {
        FeedFields.id: id,
        FeedFields.title: title,
        FeedFields.date: date,
        FeedFields.author: author,
        FeedFields.caption: caption,
        FeedFields.description: description,
      };
}
