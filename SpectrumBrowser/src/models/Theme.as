package models
{
  public class Theme
  {
    /**
     * static class
     */
    private function Theme(){}
    public static var app:SpectrumBrowser;
    public static function getTheme():String{
      return app.colorstop;
    }
    public static function setTheme(value:String):void{
      app.colorstop = value;
    }
    public static function getSize():String{
      return app.appScale;
    }
    public static function setSize(value:String):void{
      app.appScale = value;
    }
  }
}