class Products {
  Products({
    required this.data,
    required this.meta,
  });
  late final List<Data> data;
  late final Meta meta;

  Products.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    meta = Meta.fromJson(json['meta']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['meta'] = meta.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.title,
    required this.detail,
    required this.date,
    required this.view,
    required this.picture,
  });
  late final int id;
  late final String title;
  late final String detail;
  late final String date;
  late final int view;
  late final String picture;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    detail = json['detail'];
    date = json['date'];
    view = json['view'];
    picture = json['picture'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['detail'] = detail;
    _data['date'] = date;
    _data['view'] = view;
    _data['picture'] = picture;
    return _data;
  }
}

class Meta {
  Meta({
    required this.status,
    required this.statusCode,
  });
  late final String status;
  late final int statusCode;

  Meta.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['status_code'] = statusCode;
    return _data;
  }
}
