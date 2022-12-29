class WebtoonModel {
  final String title, thumb, id;

  // json 형태를 쉽게 모델에 적용하는 생성자
  WebtoonModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['thumb'],
        id = json['id'];
}
