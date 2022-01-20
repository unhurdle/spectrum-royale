package com.unhurdle.spectrum
{
  import org.apache.royale.utils.MXMLDataInterpreter;
  import org.apache.royale.core.UIBase;
  import org.apache.royale.events.Event;

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

    private var _needsLayout:Boolean = false;

    public function get needsLayout():Boolean{
    	return _needsLayout;
    }

    public function set needsLayout(value:Boolean):void{
    	_needsLayout = value;
    }

    COMPILE::JS
		override protected function initialize():void
		{
      dir = dir;
			MXMLDataInterpreter.generateMXMLInstances(this, instanceParent, MXMLDescriptor);
			
			dispatchEvent('initialize');
			
			if (initialView)
			{
        initialView.applicationModel = model;
        addElement(initialView);
                
				var baseView:UIBase = initialView as UIBase;
        var setSize:Boolean = false;
        if (!isNaN(baseView.percentWidth)){
          setSize = true;
					this.element.style.width = baseView.percentWidth + 'vw';
        }
				if (!isNaN(baseView.percentHeight)) {
          setSize = true;
					this.element.style.height = baseView.percentHeight + 'vh';
				}
        if(setSize && needsLayout){
					this.initialView.dispatchEvent(new Event("sizeChanged")); // kick off layout if % sizes
        }
				
				dispatchEvent(new Event("viewChanged"));
			}
			dispatchEvent(new Event("applicationComplete"));
		}

    public function get themeManager():ThemeManager
    {
    	return _themeManager;
    }
    // override public function set colorstop(value:String):void
    // {
      
    //   if(value != _colorstop){
    //     switch (value){
    //       // check that values are valid
    //       case "light":
    //       case "lightest":
    //       case "dark":
    //       case "darkest":
    //         break;
    //       default:
    //         throw new Error("Invalid colorstop: " + value);
    //     }
    //     var oldStop:String = valueToSelector("panel"+_colorstop);
    //     var newStop:String = valueToSelector("panel"+value);
    //     toggle(newStop, true);
    //     toggle(oldStop, false);
    //   	_colorstop = value;
    //   }
    // }

  }
}