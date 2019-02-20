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
    public static function getSelectionColor():String{
      
      // This is the "blue-500" value
      switch(current.colorstop){
          case "light":
            return "#1473e6";
          case "lightest":
            return "#2680eb";
          case "dark":
            return "#378ef0";
            case "darkest":
            return "#2680eb";
          case "paneldarkest":
            return "#2680eb";  //for testing purposes.
      }
      return "#0";
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

    protected function toggle(selector:String,value:Boolean):void{
      COMPILE::JS
      {
        element.classList.toggle(selector, value);
      }
    }

    protected var _colorstop:String;

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
          case "paneldarkest": //for testing purposes
            break;
          default:
            throw new Error("Invalid colorstop: " + value);
        }
        var oldStop:String = valueToSelector(_colorstop);
        var newStop:String = valueToSelector(value);
        toggle(newStop, true);
        toggle(oldStop, false);
      	_colorstop = value;
      }
    }
    protected function valueToSelector(value:String):String{
      return "spectrum--" + value;
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
        var oldScale:String = valueToSelector(_appScale);
        var newScale:String = valueToSelector(value);
        toggle(newScale, true);
        toggle(oldScale, false);

      	_appScale = value;

        //TODO load the correct icons?
      }
    }
  }
}