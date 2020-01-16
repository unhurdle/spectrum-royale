package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
    import com.unhurdle.spectrum.const.IconType;
  }

  public class DecoratedTextField extends SpectrumBase
  {
    public function DecoratedTextField()
    {
      super();
      typeNames = appendSelector("  is-decorated");
    }
    override protected function getSelector():String{
      return "spectrum-DecoratedTextField";
    }

    private var _placeholder: String
    public function get placeholder():String
    {
    	return _placeholder;
    }

    public function set placeholder(value:String):void
    {
      if(value){
      	multiline?textArea.placeholder = value:textField.placeholder = value;
      } else {
        multiline?textArea.removeAttribute("placeholder"):textField.removeAttribute("placeholder");
      }
      _placeholder = value;
    }

    private var _name:String;
    COMPILE::JS
    public function get name():String
    {
    	return _name;
    }

    COMPILE::JS
    public function set name(value:String):void
    {
        multiline?textArea.name = value:textField.name = value;
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
          var base:String = "-field spectrum-Textfield";
          if(textField){
            textArea = newElement("textArea",appendSelector(base + "spectrum-Textfield--multiline")) as HTMLTextAreaElement;
            textArea.name = name;
            textArea.placeholder = placeholder;
            label.position = "left";
            label.for = textArea.id;
            COMPILE::JS{
                element.replaceChild(textArea,textField);
            }
            textField = null;
          }else{
            textField = newElement("input",appendSelector(base)) as HTMLInputElement;
            textField.name = name;
            textField.placeholder = placeholder;
            label.position = "";
            label.for = textField.id;
            COMPILE::JS{
              element.replaceChild(textField,textArea);
            }
            textArea = null;
          }
        }
      }
    	_multiline = value;
    }

    protected var textField:HTMLInputElement;
    protected var textArea:HTMLTextAreaElement;
    protected var label:FieldLabel;

    COMPILE::JS
		override protected function createElement():WrappedHTMLElement{
      var elem:HTMLDivElement = addElementToWrapper(this,'div') as HTMLDivElement;
      label = new FieldLabel();
      addElement(label);
      textField = newElement("input",appendSelector("-field spectrum-Textfield")) as HTMLInputElement;
      elem.appendChild(textField);
      label.for = textField.id;
      var type:String = IconType.INFO_MEDIUM;
      var icon:Icon = new Icon(Icon.getCSSTypeSelector(type));
      icon.element.classList.add(appendSelector("-icon"));
      elem.appendChild(icon.element);
      return element;
    }
  }
}