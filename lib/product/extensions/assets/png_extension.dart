enum PngItems{
    man_working,
    woman_shopping
}

extension PngItemsExtension on PngItems{

  String path(){
    return "assets/png/$name.png";
  }

} 