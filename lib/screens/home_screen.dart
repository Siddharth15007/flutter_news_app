import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/helper/data.dart';
import 'package:newsapp/helper/news.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/models/category_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoryModel> categories = <CategoryModel>[];
  List<ArticleModel> articles = <ArticleModel>[];
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(),
      ),
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Text("News"),
            Text(
              "Bee",
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    height: 70.0,
                    child: ListView.builder(
                      itemCount: categories.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return CategoryTile(
                          imageUrl: categories[index].imageUrl,
                          categoryName: categories[index].categoryName,
                        );
                      },
                    ),
                  ),

                  ///BLog
                  ///
                  SingleChildScrollView(
                    child: Container(
                      height: 300,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return BlogTile(
                              title: articles[index].title,
                              imageUrl: articles[index].urlToImage,
                              desc: articles[index].description);
                        },
                        itemCount: articles.length,
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String imageUrl, categoryName;

  CategoryTile({this.categoryName, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 120,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 120,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black26),
              child: Text(
                categoryName,
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc;

  BlogTile(
      {@required this.title, @required this.imageUrl, @required this.desc});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[Image.network(imageUrl), Text(title), Text(desc)],
      ),
    );
  }
}
