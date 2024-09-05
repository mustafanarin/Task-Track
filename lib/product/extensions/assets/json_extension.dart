enum JsonItems{
  lottie
}

extension JsonItemsExtension on JsonItems{

  String path(){
    return "assets/json/$name.json";
  }

}