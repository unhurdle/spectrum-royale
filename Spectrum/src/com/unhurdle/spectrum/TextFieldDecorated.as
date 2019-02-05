package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
    import com.unhurdle.spectrum.const.IconType;
    import com.unhurdle.spectrum.const.IconPrefix;
    import com.unhurdle.spectrum.const.IconSize;
  }

  public class TextFieldDecorated extends SpectrumBase
  {
    public function TextFieldDecorated()
    {
      super();
    }    
    override protected function getSelector():String{
      return "spectrum-DecoratedTextfield";
    }
    private var fieldLabel:FieldLabel;
    private var input:TextField;
    COMPILE::JS
		override protected function createElement():WrappedHTMLElement{
      addElementToWrapper(this,'div');
      fieldLabel = new FieldLabel();
      addElement(fieldLabel);
      input = new TextField();
      addElement(input);
      var type:String = IconType.INFO_MEDIUM;
      var icon:Icon = new Icon(IconPrefix.SPECTRUM_CSS_ICON + type);
      icon.type = type;
      icon.size = IconSize.S;
      icon.className = appendSelector("-icon");
      addElement(icon);
      return element;
    }
    private var _field:Boolean;
    public function get field():Boolean
    {
    	return _field;
    }
    public function set field(value:Boolean):void
    {
      if(!!value != !!_field){
        COMPILE::JS
        {
          if(value){
            input.element.classList.add(appendSelector("field"))
          }
          else if(input.element.classList.contains(appendSelector("field"))){
            input.element.classList.remove(appendSelector("field"));
          }
        }
      }
      _field = value;
    }
    private var _decorated:Boolean;
    public function get decorated():Boolean
    {
    	return _decorated;
    }
    public function set decorated(value:Boolean):void
    {
      if(value != !!_decorated){
        toggle("is-decorated",value);
      }
    	_decorated = value;
    }

    public function get fieldText():String
    {
    	return fieldLabel.text;
    }

    public function set fieldText(value:String):void
    {
    	fieldLabel.text = value;
    }
    public function get placeHolder():String
    {
    	return input.placeholder;
    }

    public function set placeHolder(value:String):void
    {
    	input.placeholder = value;
    }

  }
}