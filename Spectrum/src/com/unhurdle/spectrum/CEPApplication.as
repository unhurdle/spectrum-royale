package com.unhurdle.spectrum
{
  public class CEPApplication extends Application
  {
    /**
     * CEPApplication is meant to be used as a CEP panel in the Adobe Creative apps.
     * The color stop is set automatically by the host application settings.
     */
    public function CEPApplication()
    {
      
      super();
      _themeManager = ThemeManager.instance;
      _themeManager.init(this);
    }
    private var _themeManager:ThemeManager;

    public function get themeManager():ThemeManager
    {
    	return _themeManager;
    }
    override public function set colorstop(value:String):void
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
        var oldStop:String = valueToSelector("panel"+_colorstop);
        var newStop:String = valueToSelector("panel"+value);
        toggle(newStop, true);
        toggle(oldStop, false);
      	_colorstop = value;
      }
    }

  }
}