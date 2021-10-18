package com.unhurdle.spectrum
{
  COMPILE::JS{
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import org.apache.royale.events.Event;

  [Event(name="change", type="org.apache.royale.events.Event")]
  public class Tag extends SpectrumBase
  {
    public function Tag()
    {
      super();
      
    }
    override protected function getSelector():String{
      return "spectrum-Tags-item";
    }
    private var span:TextNode;
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = super.createElement();
      span = new TextNode("");
      span.element = newElement("span") as HTMLSpanElement;
      span.className = getSelector()+"Label";
      elem.appendChild(span.element);
      clearButton = new ClearButton();
      clearButton.toggle(getSelector()+"ClearButton",true);
      clearButton.small = true;
      clearButton.visible = false;
      addElement(clearButton);
      clearButton.addEventListener("click",removeTag);
      return elem;
    }
     public function get small():Boolean
    {
      return _small;
    }
    private var _small:Boolean;
    public function set small(value:Boolean):void
    {
      _small = value;
      if(value){
        height = 17;
        span.element.style.lineHeight = 1.2;
      } else{
        span.element.style.lineHeight = '';
        style.height = '';
      }
    }
    public function get text():String
    {
      return _text;
    }
    private var _text:String;
    public function set text(value:String):void
    {
      _text = value;
      span.text = value;
    }
    private var _src:String;

    public function get src():String
    {
    	return _src;
    }

    private var imageElement:Avatar;
    public function set src(value:String):void
    {
      if(value == _src){
        return;
      }
      var elem:HTMLElement = element as HTMLElement;
      if(value){
        if(!imageElement){
          imageElement = new Avatar();
          addElementAt(imageElement,0);
        }
        imageElement.src = value;
      }
    	_src = value;
    }
    private var _icon:String;
    private var iconElement:Icon;

    /**
     * Icon selector name
     */
    public function get icon():String
    {
    	return _icon;
    }

    public function set icon(value:String):void
    {
    	_icon = value;
      if(iconElement){
        iconElement.selector = value;
        iconElement.size = 'XS';
      } else {
        iconElement = new Icon(value);
        iconElement.size = 'XS';
        addElementAt(iconElement,0);
      }
    }
    private var _isDisabled:Boolean;

    public function get isDisabled():Boolean
    {
    	return _isDisabled;
    }

    public function set isDisabled(value:Boolean):void
    {
      if(value != !!_isDisabled){
        toggle("is-disabled",value);
      }
    	_isDisabled = value;
    }
    private var _invalid:Boolean;

    public function get invalid():Boolean
    {
    	return _invalid;
    }

    public function set invalid(value:Boolean):void
    {
      if(value != !!_invalid){
        toggle("is-invalid",value);
      }
    	_invalid = value;
    }
    private var _deletable:Boolean;

    public function get deletable():Boolean
    {
    	return _deletable;
    }
    private var clearButton:ClearButton;
    public function set deletable(value:Boolean):void
    {
      if(value != !!_deletable){
        toggle(valueToSelector("deletable"),value);
        if(value){
          clearButton.visible = true;
        } else {
          clearButton.visible = false;
        }
      }
    	_deletable = value;
    }
    private var _interactive:Boolean = true;

    public function get interactive():Boolean
    {
    	return _interactive;
    }

    public function set interactive(value:Boolean):void
    {
    	_interactive = value;
      COMPILE::JS{
        element.style.pointerEvents = value ? null : "none";
      }
    }

    private function removeTag():void{
      parent.removeElement(this);
      dispatchEvent(new Event('change'));
    }
  }
}