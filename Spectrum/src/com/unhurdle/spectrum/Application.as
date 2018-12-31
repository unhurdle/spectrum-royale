package com.unhurdle.spectrum
{
  import org.apache.royale.core.Application;

  public class Application extends org.apache.royale.core.Application
  {
    public function Application()
    {
      super();
      
      // default values
      _colorstop = "light";
      _appScale = "medium";
    
      this["element"]["className"] = 'Application spectrum spectrum--medium spectrum--light';
      
    }
    private var _colorstop:String;

    /**
     * The colorstop of the app. One of the four ColorStop values
     */
    public function get colorstop():String
    {
    	return _colorstop;
    }

    public function set colorstop(value:String):void
    {
      if(value != _colorstop){
        switch (value){
          // check that values are valid
          case "light":
          case "lightest":
          case "dark":
          case "darkest":
            break;
          default:
            throw new Error("Invalid colorstop: " + value);
        }
        var oldStop:String = valueToCSS(_colorstop);
        var newStop:String = valueToCSS(value);
        toggle(this,newStop, true);
        toggle(this,oldStop, false);
      	_colorstop = value;
      }
    }
    private function valueToCSS(stop:String):String{
      return "spectrum--" + stop;
    }

    private var _appScale:String;

    /**
     * appScale is either medium or large. large is for mobile
     */
    public function get appScale():String
    {
    	return _appScale;
    }

    public function set appScale(value:String):void
    {
      if(value != _appScale){
        switch(value){
          case "medium":
          case "large":
            break;
          default:
            throw new Error("Invalid scale: " + value);
        }
        var oldScale:String = valueToCSS(_appScale);
        var newScale:String = valueToCSS(value);
        toggle(this,newScale, true);
        toggle(this,oldScale, false);


      	_appScale = value;

        //TODO load the correct icons?
      }
    }
  }
}