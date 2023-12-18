
class RndmBackGround {
  String category = 'nature';
  late final String _url;
  final Map<String, String> _data = {
    'X-Api-Key': 'Ik8iNnAkNgZuKsaXhRkWLw==bGfS6seX4Y5LttQU',
    'Accept': 'image/jpg'
  };
  RndmBackGround() {
    _url = 'https://api.api-ninjas.com/v1/randomimage?category=$category';
  }
  String get urlNinja => _url;
  Map<String,String>? get dataNinja => _data;
}