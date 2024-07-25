enum JsonItems{
  loot
}

extension JsonItemsExtension on JsonItems{

  String path(){
    return "assets/json/$name.json";
  }

}