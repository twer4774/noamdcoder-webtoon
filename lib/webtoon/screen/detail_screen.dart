import 'package:flutter/material.dart';
import 'package:nomad_webtoon/webtoon/model/webtoon_detail_model.dart';
import 'package:nomad_webtoon/webtoon/model/webtoon_episode_model.dart';
import 'package:nomad_webtoon/webtoon/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/episode_widget.dart';

class DetailScreen extends StatefulWidget {
  final String title, thumb, id;

  const DetailScreen(
      {Key? key, required this.title, required this.thumb, required this.id})
      : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // id 파라미터가 필요한 경우 initState()에서 api 호출해야한다. home에서는 파라미터가 없어서 다이렉트 호출 가능
  // id 값이 랜더링할때 가져오기 힘들어서 이 방법 이용
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodModel>> episodes;
  late SharedPreferences prefs; // 기기에 저장하는 저장소 (좋아요기능)
  bool isLiked = false;

  Future initPrefes() async {
    prefs = await SharedPreferences.getInstance();
    final likedToons = prefs.getStringList('likedToons');
    if(likedToons != null){
      if(likedToons.contains(widget.id) == true){
        setState(() {
          isLiked = true;
        });
      }
    } else {
      // 처음 앱 실행 시 빈 리스트 저장
      await prefs.setStringList('likedToons', []);
    }
  }

  @override
  void initState() {
    super.initState();
    webtoon = ApiService.getToonById(widget.id);
    episodes = ApiService.getLatestEpisodeById(widget.id);
    initPrefes();
  }



  onHeartTap() async{
    final likedToons = prefs.getStringList('likedToons');
    if(likedToons != null){
      if(isLiked){
        likedToons.remove(widget.id);
      } else {
        likedToons.add(widget.id);
      }
      await prefs.setStringList('likedToons', likedToons);
      setState(() {
        isLiked = !isLiked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        foregroundColor: Colors.green,
        backgroundColor: Colors.white,
        actions: [
          IconButton(onPressed: onHeartTap, icon:  Icon(isLiked ? Icons.favorite : Icons.favorite_outline_outlined)),
        ],
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.id,
                    child: Container(
                        width: 250,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 15,
                                  offset: const Offset(10, 10),
                                  color: Colors.black.withOpacity(0.5)),
                            ]),
                        child: Image.network(widget.thumb)),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              FutureBuilder(
                  future: webtoon,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data!.about,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            // snapshot.data!.genre,
                            '${snapshot.data!.genre} / ${snapshot.data!.age}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      );
                    }
                    return const Text("...");
                  }),
              const SizedBox(
                height: 25,
              ),
              FutureBuilder(
                future: episodes,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        for (var episode in snapshot.data!)
                          Episode(episode: episode, webtoonId: widget.id)
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

