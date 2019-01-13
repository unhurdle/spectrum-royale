package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import com.unhurdle.spectrum.const.IconPrefix;
  import com.unhurdle.spectrum.const.IconType;

  public class SplitButton extends SpectrumBase
  {
    public function SplitButton()
    {
      super();
      type = "primary";
    }
    override protected function getSelector():String{
      return "spectrum-SplitButton";
    }

    COMPILE::JS
    private var elem:WrappedHTMLElement
    COMPILE::SWF
    private var elem:Object
    COMPILE::JS
    private var actionButton:Button
    COMPILE::SWF
    private var actionButton:Object
    COMPILE::JS
    private var triggerButton:Button
    COMPILE::SWF
    private var triggerButton:Object

    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      elem = addElementToWrapper(this,"div");
      actionButton = new Button();
      actionButton.className = appendSelector("-action");
      // actionButton.flavor = _type;
      triggerButton = new Button();
      triggerButton.className = appendSelector("-trigger");
      // triggerButton.flavor = _type;
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
        // if(value && elem.actionButton){
          removeElement(actionButton);
          // actionButton = new Button();
          // actionButton.className = appendSelector("-action");
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