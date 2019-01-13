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
  }
}