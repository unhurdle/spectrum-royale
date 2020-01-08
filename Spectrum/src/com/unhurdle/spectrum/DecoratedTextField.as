package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
    import com.unhurdle.spectrum.const.IconSize;
    import com.unhurdle.spectrum.const.IconType;
  }

  public class DecoratedTextField extends SpectrumBase
  {
    public function DecoratedTextField()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-DecoratedTextField is-decorated";
    }

    private var _placeholder: String
    public function get placeholder():String
    {
    	return textField.placeholder;
    }

    public function set placeholder(value:String):void
    {
      if(value){
      	textField.placeholder = value;
      } else {
        textField.removeAttribute("placeholder");
      }
      _placeholder = value;
    }

    private var _name:String;
    COMPILE::JS
    public function get name():String
    {
    	return textField.name;
    }

    COMPILE::JS
    public function set name(value:String):void
    {
        textField.name = name;
        _name = name;
    }

    private var _text:String;
    public function get text():String
    {
      return label.text;
    }

    public function set text(value:String):void
    {
      if(value){
      	label.text = value;
      } else {
        label.text = "";
      }
      _text = value;
    }
    private var _multiline:Boolean;

    public function get multiline():Boolean
    {
    	return _multiline;
    }

    public function set multiline(value:Boolean):void
    {
      if(value != !!_multiline){
        if(value){
          if(textField is HTMLInputElement){
            textField = null;
          }
        }
      }
    	_multiline = value;
    }

    protected var textField:HTMLInputElement;
    protected var label:FieldLabel;

    COMPILE::JS
		override protected function createElement():WrappedHTMLElement{
      var elem:HTMLDivElement = addElementToWrapper(this,'div') as HTMLDivElement;
      label = new FieldLabel();
      textField = newElement("input") as HTMLInputElement;
      label.for = textField.id; 
      var type:String = IconType.ASTERISK;
      var icon:Icon = new Icon(IconType.INFO_MEDIUM);
      icon.size = IconSize.S;
      elem.appendChild(icon.element);
      return element;
    }
  }
}