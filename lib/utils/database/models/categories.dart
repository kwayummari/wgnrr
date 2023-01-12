final String Categories = 'feeds';
class CategoriesFields {
static final String id = '_id' ;
static final String image = 'image';
static final String title = 'title';
static final String date = 'date';
static final String author = 'author';
static final String caption = 'caption';
static final String description = 'description';
}
class Category {
final int? id;
final String image;
final String title;
final String date;
final String author;
final String caption;
final String description;

const Category({
this.id,
required this.image,
required this.title,
required this.date,
required this.author,
required this.caption,
required this.description,
});
}