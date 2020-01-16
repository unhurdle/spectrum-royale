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

    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/decoratedtextfield/dist.css">
     * </inject_html>
     * 
     */
    public function DecoratedTextField()
    {
      super();
      typeNames = getSelector() + " is-decorated";
    }
    override protected function getSelector():String{
      return "spectrum-DecoratedTextfield";
    }

    private var _placeholder: String
    public function get placeholder():String
    {
    	return _placeholder;
    }

    public function set placeholder(value:String):void
    {
      if(textField){
        textField.placeholder = value;
      }
      if(textArea){
        textArea.placeholder = value;
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
      if(textField){
        textField.name = value;
      }
      if(textArea){
        textArea.name = value;
      }
        _name = name;
    }

    private var _label:String;
    public function get label():String
    {
      return fieldLabel.text;
    }

    public function set label(value:String):void
    {
      if(!fieldLabel){
        fieldLabel = new FieldLabel()
        addElementAt(fieldLabel,0);
      }
      if(value){
      	fieldLabel.text = value;
      } else {
        fieldLabel.text = "";
      }
      _label = value;
    }
    private var textField:TextField;
    private var textArea:TextArea;
    private var _multiline:Boolean;

    public function get multiline():Boolean
    {
    	return _multiline;
    }

    override public function addedToParent():void{
      super.addedToParent();
      // add the text field if multiline was not specified
      if(!textField && !textArea){
        addtextField();
      }
    }
    private function addtextField():void{
      if(textArea){
        removeElement(textArea);
        textArea = null;
      }
      textField = new TextField();
      textField.className = appendSelector("-field");
      textField.placeholder = placeholder;
      // textField.name = name;
      var position:int = 0;
      if(fieldLabel){
        position = 1;
        fieldLabel.position = "";
      }
      addElementAt(textField,position);
    }
    private function addTextArea():void{
      if(textField){
        removeElement(textField);
        textField = null;
      }
      textArea = new TextArea();
      textArea.className = appendSelector("-field");
      textArea.placeholder = placeholder;

      var position:int = 0;
      if(fieldLabel){
        position = 1;
        fieldLabel.position = "left";
      }
      addElementAt(textArea,position);
    }
    public function set multiline(value:Boolean):void
    {
      if(value != _multiline){
        if(value){
          addTextArea();
        } else {
          addtextField();
        }
      }
    	_multiline = value;
    }

    protected var fieldLabel:FieldLabel;

    COMPILE::JS
		override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
      // fieldLabel = new FieldLabel();
      // addElement(fieldLabel);
      // fieldLabel.for = textField.id;
      var type:String = IconType.INFO_MEDIUM;
      var icon:Icon = new Icon(Icon.getCSSTypeSelector(type));
      icon.type = type;
      icon.className = appendSelector("-icon");
      addElement(icon);
      return elem;
    }
  }
}