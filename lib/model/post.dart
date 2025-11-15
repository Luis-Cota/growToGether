

class Post {
  late String? _id;
  late String _title;
  late String _description;
  late DateTime  _date;
  late String? _urlimage;

  Post(
    this._title,
    this._description,
    this._date,
    [this._urlimage,]
);




  Post.vacio() {
    _title = "";
    _description = "";
    _date = DateTime.now();
    _urlimage = "";
  }

  String get title => _title;
  String get description => _description;
  DateTime get date => _date;
  String? get urlimage => _urlimage;

  set title(String title) => _title;
  set description(String description) => _description;
  set date(int date) => _date;
  set urlimage(String? image) => _urlimage;

  Post.fromJson(Map<String, dynamic> json): 
  _title = json['title'],
  _description = json['description'],
  _date = json['date'],
  _urlimage = json['image'];

  Map<String, dynamic> toJson() => {
    'title': _title,
    'description': _description,
    'date': _date,
    'image': _urlimage,
  };



  @override
  String toString() {
    return "Album{id: $_id, title: $_title, description, $_description, date: $_date, image:$_urlimage}";}}
