package com.unhurdle.spectrum
{
  import org.apache.royale.core.Application;
  import org.apache.royale.binding.ApplicationDataBinding;
  import org.apache.royale.core.AllCSSValuesImpl;

  public class Application extends org.apache.royale.core.Application
  {
    private static var _current:com.unhurdle.spectrum.Application;
    /**
     * Global getter to get a reference to the top-level application
     */
    public static function get current():com.unhurdle.spectrum.Application{
      return _current;
    }
    public function Application()
    {
      super();
      
			this.valuesImpl = new AllCSSValuesImpl();
			addBead(new ApplicationDataBinding());
      // default values
      _colorstop = "light";
      _appScale = "medium";
      
      COMPILE::JS
      {
        element.className = 'Application spectrum spectrum--medium spectrum--light';

      }
      _current = this;
      
    }

    private function toggle(selector:String,value:Boolean):void{
      COMPILE::JS
      {
        element.classList.toggle(selector, value);
      }
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
        toggle(newStop, true);
        toggle(oldStop, false);
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
        toggle(newScale, true);
        toggle(oldScale, false);

      	_appScale = value;

        //TODO load the correct icons?
      }
    }
  }
}