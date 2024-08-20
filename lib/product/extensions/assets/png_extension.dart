enum PngItems{
    man_working,
    woman_shopping,
    google_icon
}

extension PngItemsExtension on PngItems{

  String path(){
    return "assets/png/$name.png";
  }

} 