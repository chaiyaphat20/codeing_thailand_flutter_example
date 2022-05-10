import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/models/news/news_body_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  String apiKey = dotenv.get('API_KEY', fallback: 'Default fallback API_KEY');
  int totalResults = 0;
  List<Articles> articles = []; //ไปดูว่าเราจะใช้อะไร
  int page = 1, pageSize = 5;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 700));

    //call data new  when pull refresh
    setState(() {
      articles.clear();
      page = 1;
      pageSize = 5;
    });
    getData();

    // if failed,use refreshFailed()
    _refreshController.refreshCompleted(
        resetFooterState: true); // or  // _refreshController.resetNoData();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 500));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    //setData add page
    if (page < (totalResults / pageSize).ceil()) {
      if (mounted) {
        setState(() {
          page = ++page;
        });
      }
      getData();
      _refreshController.loadComplete();
    } else {
      _refreshController.resetNoData();
      _refreshController.loadNoData();
    }
  }

  Future<void> getData() async {
    try {
      var url = Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=th&apiKey=$apiKey&page=$page&pageSize=$pageSize');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = NewsBodyModel.fromJson(jsonDecode(response.body));
        setState(() {
          totalResults = data.totalResults ?? 0;
          // articles = data.articles;
          articles.addAll(data.articles);
        });
      } else {}
    } catch (e) {
      print('Error $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: totalResults > 0 ? Text('ข่าวสาร $totalResults ข่าว') : null),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: const WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus? mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = const Text("กำลังโหลดข้อมูล");
            } else if (mode == LoadStatus.loading) {
              body = const CircularProgressIndicator();
            } else if (mode == LoadStatus.failed) {
              body = const Text("Load Failed!Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = const Text("release to load more");
            } else {
              body = TextButton(
                  onPressed: () {}, child: const Text("ไม่พบข้อมูลแล้ว"));
            }
            return SizedBox(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
          itemBuilder: (ctx, index) => Card(
            child: InkWell(
              onTap: () {
                Get.toNamed('/website', arguments: {
                  'name': articles[index].source.name,
                  'url': articles[index].url
                });
              },
              child: Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: '${articles[index].urlToImage}',
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      '${articles[index].title}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  )
                ],
              ),
            ),
          ),
          itemCount: articles.length,
        ),
      ),
    );
  }
}
