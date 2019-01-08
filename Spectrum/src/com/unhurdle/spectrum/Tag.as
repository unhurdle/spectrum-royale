package com.unhurdle.spectrum
{
  COMPILE::JS{
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.html.elements.P;
    import com.unhurdle.spectrum.const.IconType;
    import com.unhurdle.spectrum.const.IconPrefix;
    import com.unhurdle.spectrum.const.IconSize;
  }
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

    COMPILE::JS
    private var imageElement:HTMLImageElement;
    private var icon:Icon;
    public function set src(value:String):void
    {
      if(value == _src){
        return;
      }
      COMPILE::JS{
        if(value){
          if(icon){
            element.removeChild(icon.element);
            icon = null;
          }
          if(!imageElement){
            imageElement = newElement("img") as HTMLImageElement;
            imageElement.className = "spectrum-Avatar";
            element.insertBefore(imageElement, element.childNodes[0] || null);
          }
          imageElement.src = value;
        }
        else if(!icon){
          icon = new Icon(IconPrefix._24 + "SentimentPositive");
          icon.size = IconSize.XS;
          element.insertBefore(icon.element, element.childNodes[0] || null);
          icon.addedToParent();
        }
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
    private var _isInvalid:Boolean;

    public function get isInvalid():Boolean
    {
    	return _isInvalid;
    }

    public function set isInvalid(value:Boolean):void
    {
      if(value != !!_isInvalid){
        toggle("is-invalid",value);
      }
    	_isInvalid = value;
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
          if(!clearButton){
            clearButton = new ClearButton();
            clearButton.small = true;
            addElement(clearButton);
          }
          clearButton.visible = true;
        } else {
          clearButton.visible = false;
        }
      }
    	_deletable = value;
    }
  }
}