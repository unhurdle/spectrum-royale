package com.unhurdle.spectrum
{
  
  import com.unhurdle.spectrum.interfaces.IKeyboardFocusable;

  public class Thumbnail extends SpectrumBase implements IKeyboardFocusable
  {
    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/Thumbnail/dist.css">
     * </inject_html>
     * 
     */
    public function Thumbnail()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-Thumbnail";
    }
    
    public function get focusElement():HTMLElement{
      COMPILE::JS{
        return element;
      }
      return null;
    }
    override public function addedToParent():void{
      super.addedToParent();
      addEventListener('click',function():void
      {
        selected = !selected;
      });
    }

    private var img:HTMLImageElement;

    COMPILE::JS
    private function createImage():void{
      if(!img){
        img = newElement("img") as HTMLImageElement;
        img.className = appendSelector("-image");
        element.appendChild(img);
      }
    }
    private var _src:String;

    public function get src():String
    {
    	return _src;
    }

    public function set src(value:String):void
    {
      if(value != _src){
        _src = value;
        setBackground();
      }
    }

    private var _fill:String;

    public function get fill():String
    {
    	return _fill;
    }

    public function set fill(value:String):void
    {
      if(value != _fill){
        _fill = value;
        setBackground();
      }
    }

    private var _title:String;

    public function get title():String
    {
    	return _title;
    }

    public function set title(value:String):void
    {
    	_title = value;
    }
    private var background:HTMLDivElement;

    COMPILE::JS
    private function createBackground():void{
      if(!background){
        background = newElement("div") as HTMLDivElement;
        background.className = appendSelector("-background");
        element.appendChild(background);
      }
    }

    private var _backgroundColor:String;

    public function get backgroundColor():String
    {
    	return _backgroundColor;
    }

    public function set backgroundColor(value:String):void
    {
    	if(value != _backgroundColor){
        _backgroundColor = value;
        setBackground();
      }
    }

    private var _selected:Boolean;

    public function get selected():Boolean
    {
    	return _selected;
    }

    public function set selected(value:Boolean):void
    {
      if(value != !!_selected){
        toggle("is-selected",value);
      }
    	_selected = value;
    }

    private var _focused:Boolean;

    public function get focused():Boolean
    {
    	return _focused;
    }

    public function set focused(value:Boolean):void
    {
      if(value != _focused){
        toggle("is-focused",value);
        // if(value){
        //   toggle("is-keyboardFocused",false);
        // }
      }
    	_focused = value;
    }

    private var _keyboardFocused:Boolean;

    public function get keyboardFocused():Boolean
    {
    	return _keyboardFocused;
    }

    public function set keyboardFocused(value:Boolean):void
    {
      // if(value != _keyboardFocused){
      //   toggle("is-keyboardFocused",value);
      //   if(value){
      //     toggle("is-focused",false);
      //   }
      // }
    	_keyboardFocused = value;
    }
    
    private var _size:String;

    public function get size():String
    {
    	return _size;
    }
    public static function validateSize(value:String):Boolean{
      switch(value){
        case "S":
        case "M":
        case "L":
        case "XL":
        case "XXL":
          return true;
        default:
          return false;
      }

    }
    [Inspectable(category="General", enumeration="S,M,L,XL,XXL" defaultValue="M")]
    public function set size(value:String):void
    {
      if(!value || value == _size){
        return;
      }
      if(!validateSize(value)){
          throw new Error("invalid size: " + value);
      }
      if(_size){
        toggle(valueToSelector(_size),false);
      }
    	_size = value;
      toggle(valueToSelector(value),true);
    }

    private function setBackground():void{
      if(fill){
        COMPILE::JS{
          createBackground();
        }
        if(backgroundColor){
          background.style.background = "url(" + src + ")," + backgroundColor;
          setBackgroundStyle();
        }else{
          background.style.backgroundImage = "url(" + src + ")";
          background.style.backgroundColor = "";
        }
        if(title){
          background.title = title;
        }
      }else{
        if(backgroundColor){
            COMPILE::JS{
            createBackground();
          }
          background.style.backgroundColor = backgroundColor;
          background.style.backgroundImage = "";
        }
        if(src){
          COMPILE::JS{
            createImage();
          }
          img.src = src;
          if(title){
            img.alt = title;
          }
        }
      }
    }
    private function setBackgroundStyle():void{
      background.style.position = "absolute";
      background.style.zIndex = "0";
      background.style.left = "0";
      background.style.top = "0";
      background.style.right = "0";
      background.style.bottom = "0";
      background.style.height = "100%";
      background.style.width = "100%";
      background.style.backgroundSize = "cover";
      background.style.backgroundPosition = "center center";
    }
  }
}
