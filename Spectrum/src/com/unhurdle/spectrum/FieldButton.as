package com.unhurdle.spectrum
{
  public class FieldButton extends Button
  {
    public function FieldButton()
    {
      super();
      COMPILE::JS
      {
        element.setAttribute("type","button");
      }
    }
    override public function set flavor(value:String):void{
      // no flavors. do nothing...
    }

    override protected function getSelector():String{
      return "spectrum-FieldButton";
    }
    private var _labelClass:String;

    public function get labelClass():String
    {
    	return textNode.className;
    }

    public function set labelClass(value:String):void
    {
    	textNode.className = value;
    }

    private var _placeholderText:String;

    public function get placeholderText():String
    {
    	return _placeholderText;
    }
    override public function set text(value:String):void{
      super.text = value;
      placeholderText = "";
    }
    public function set placeholderText(value:String):void
    {
      if(value){
        text = value;
        textNode.element.classList.add("is-placeholder");
      } else {
        textNode.element.classList.remove("is-placeholder");
        if(_placeholderText && _placeholderText == text){
          text = "";
        }
      }
    	_placeholderText = value;
    }
    public override function get invalid():Boolean{
      return super.invalid;
    }
    public override function set invalid(value:Boolean):void{
      super.invalid = value;
      //TODO what was this here for?
      // if(value){//check if !=_invalid ??
      //   var playIcon:Icon = new Icon(IconPrefix._18 + "Alert");
      //   addElement(playIcon);
      // }
    }
    override protected function createIcon(selector:String):void{
      if(iconElement){
        iconElement.selector = selector;
        setIconProps();
      } else {
        iconElement = new Icon(selector);
        setIconProps();
        addElement(iconElement);
      }
    }

  }
}