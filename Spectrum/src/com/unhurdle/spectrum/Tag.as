package com.unhurdle.spectrum
{
  COMPILE::JS{
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }
  import org.apache.royale.html.elements.P;
  import com.unhurdle.spectrum.const.IconType;
  import com.unhurdle.spectrum.const.IconPrefix;
  import com.unhurdle.spectrum.const.IconSize;

  [Event(name="change", type="org.apache.royale.events.Event")]
  public class Tag extends SpectrumBase
  {
    public function Tag()
    {
      super();
      typeNames = "spectrum-Tags-item";
      
    }
    private var span:TextNode;
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
      span = new TextNode("");
      span.element = newElement("span") as HTMLSpanElement;
      elem.appendChild(span.element);
      clearButton = new ClearButton();
      clearButton.small = true;
      clearButton.visible = false;
      addElement(clearButton);
      clearButton.addEventListener("click",removeTag);
      return elem;
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

    private var imageElement:HTMLImageElement;
    private var icon:Icon;
    public function set src(value:String):void
    {
      if(value == _src){
        return;
      }
      var elem:HTMLElement = element as HTMLElement;
      if(value){
        if(icon){
          removeElement(icon);
          icon = null;
        }
        if(!imageElement){
          imageElement = newElement("img") as HTMLImageElement;
          imageElement.className = "spectrum-Avatar";
          elem.insertBefore(imageElement, elem.childNodes[0] || null);
        }
        imageElement.src = value;
      }
      else{
        if(!icon){
          icon = new Icon(IconPrefix._24 + "SentimentPositive");
          icon.size = IconSize.XS;
        }
        addElementAt(icon,0);
      }
    	_src = value;
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

    private function removeTag():void{
      parent.removeElement(this);
    }
  }
}