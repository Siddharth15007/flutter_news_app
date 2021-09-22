import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapp/models/article_model.dart';

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    var url =
        "https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=46076f897f8b4421bd02a177168c9270";

    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData['articles'].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            author: element['author'],
            content: element['content'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
          );

          news.add(articleModel);
        }
      });
    }
    return news;
  }
}
