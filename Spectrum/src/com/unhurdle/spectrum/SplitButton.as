package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import com.unhurdle.spectrum.const.IconPrefix;
  import com.unhurdle.spectrum.const.IconType;

  public class SplitButton extends SpectrumBase
  {
    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/splitbutton/dist.css">
     * </inject_html>
     * 
     */
    public function SplitButton()
    {
      super();
      type = "primary";
    }
    override protected function getSelector():String{
      return "spectrum-SplitButton";
    }


    private var actionButton:Button;
    private var triggerButton:Button;

    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = super.createElement();
      actionButton = new Button();
      actionButton.className = appendSelector("-action");
      triggerButton = new Button();
      triggerButton.className = appendSelector("-trigger");
      triggerButton.icon = IconPrefix.SPECTRUM_CSS_ICON + IconType.CHEVRON_DOWN_MEDIUM;
      triggerButton.iconType = IconType.CHEVRON_DOWN_MEDIUM;
      triggerButton.iconClass = appendSelector("-icon");
      addElement(actionButton);
      addElement(triggerButton);
      return elem;
    }
    private var _type:String;

    public function get type():String
    {
      return _type;
    }
    
    [Inspectable(category="General", enumeration="cta,primary,secondary", defaultValue="primary")]
    public function set type(value:String):void
    {
      if(value != _type){
        switch (value){
        // check that values are valid
          case "cta":
          case "primary":
          case "secondary":
            break;
          default:
              throw new Error("Invalid type: " + value);
        }
        actionButton.flavor = value;
        triggerButton.flavor = value;
        _type = value;
      }
    }
   
    private var _left:Boolean;

    public function get left():Boolean
    {
    	return _left;
    }

    public function set left(value:Boolean):void
    {
      if(value != !!_left){
        toggle(valueToSelector("left"),value);
        COMPILE::JS{
        if(value){
          removeElement(actionButton);
          addElement(actionButton);
        }
        }
      }
    	_left = value;
    }
    private var _text:String;

    public function get text():String
    {
    	return _text;
    }

    public function set text(value:String):void
    {
    	_text = value || "";
      actionButton.text = _text;
    }
    //TODO add dataProvider and menu
    private function getModel():IComboBoxModel{
      return model as IComboBoxModel;
    }
    public function get dataProvider():Object
		{
			return getModel().dataProvider;
		}
		public function set dataProvider(value:Object):void
		{
			getModel().dataProvider = value;
		}
    // private var _dataProvider:Object;

    // public function get dataProvider():Object
    // {
    // 	return _dataProvider;
    // }

    // public function set dataProvider(value:Object):void
    // {
    // 	_dataProvider = value;
    //   createFlyoutIcon();
    //   if(menu){
    //     menu.dataProvider = value;
    //   }
    // }
  }
}