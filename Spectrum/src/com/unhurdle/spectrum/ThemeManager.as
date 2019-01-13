package com.unhurdle.spectrum
{
  import com.adobe.cep.CSInterface;
  import com.adobe.cep.AppSkinInfo;
  import org.apache.royale.events.EventDispatcher;
  import com.adobe.cep.CepColor;
  import org.apache.royale.events.Event;

  public class ThemeManager extends EventDispatcher
  {
		public static const THEME_CHANGED:String = "THEME_CHANGED";

		private static var _instance:ThemeManager;
		public static function get instance():ThemeManager{return getInstance()}
		public static function getInstance():ThemeManager {
			if (_instance == null){
				_instance = new ThemeManager(new SingletonEnforcer);
			}
			return _instance;
		}

    /**
     * ThemeManager is a singleton intialized by the application
     */
    public function ThemeManager(en:SingletonEnforcer)
    {
    }
		private var app:CEPApplication;
		public function init(application:CEPApplication):void {
			app = application;
			
			// Update the theme
			updateTheme();
			
			// Set the Event Listener for future theme changes
			CSInterface.addEventListener(CSInterface.THEME_COLOR_CHANGED_EVENT, onAppThemeColorChanged);
		}

		public function getBackgroundColor(delta:Number):String{
			return "#" + toHex(appSkinInfo.panelBackgroundColor.color as CepColor,delta);
		}
		private var _backgroundColor:String;

		public function get backgroundColor():String
		{
			return _backgroundColor;
		}
		
		// Convert the Color object to string in hexadecimal format; 
		private function toHex(color:CepColor, delta:Number=NaN):String {
			
			function computeValue(value:Number, delta:Number):String {
				var computedValue:Number = !isNaN(delta) ? value + delta : value;
				if (computedValue < 0) {
					computedValue = 0;
				} else if (computedValue > 255) {
					computedValue = 255;
				}
				
				computedValue = Math.floor(computedValue);
				
				var computedStr:String = computedValue.toString(16);
				return computedStr.length === 1 ? "0" + computedValue : computedStr;
			}
			
			var hex:String = "";
			if (color) {
				hex = computeValue(color.red, delta) + computeValue(color.green, delta) + computeValue(color.blue, delta);
			}
			return hex;
		}


		// Callback for the CSInterface.THEME_COLOR_CHANGED_EVENT
		private function onAppThemeColorChanged(event:*):void {
			updateTheme();
		}
		private var appSkinInfo:AppSkinInfo;

		private function updateTheme():void
		{
			appSkinInfo = new AppSkinInfo(CSInterface.hostEnvironment.appSkinInfo);
			_backgroundColor = "#" + toHex(appSkinInfo.panelBackgroundColor.color as CepColor)
			
			// Using the red value to infer the darkness
			var redShade:Number = appSkinInfo.panelBackgroundColor.color.red;
			if (redShade > 200) { // exact: 214 (#D6D6D6)
				app.colorstop = "lightest";
			} else if (redShade > 180) { // exact: 184 (#B8B8B8)
				app.colorstop = "light";
			} else if (redShade > 80) { // exact: 83 (#535353)
			app.colorstop = "dark";
			} else if (redShade > 50) { // exact: 52 (#343434)
				app.colorstop = "darkest";
			}
			dispatchEvent(new Event(THEME_CHANGED));

		}

  }
}
class SingletonEnforcer{
}