package com.unhurdle.spectrum
{
  COMPILE::JS{
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }
  import com.unhurdle.spectrum.const.IconType;
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
      img = newElement("img") as HTMLImageElement;
      img.className = appendSelector("-image");
      element.appendChild(img);      
    }
    COMPILE::JS
    private function removeImage():void{
      element.removeChild(img);
      img = null;
    }

    private var _imgSrc:String;

    public function get imgSrc():String
    {
    	return _imgSrc;
    }

    public function set imgSrc(value:String):void
    {
      if(value != _imgSrc){
        if(value){          
          if(!img){
            COMPILE::JS{
              createImage();
            }
          }
          img.src = value;
        }else{
          if(img){
            COMPILE::JS{
              removeImage();
            }
          }
        }
      }
    	_imgSrc = value;
    }

    private var _imgAlt:String;

    public function get imgAlt():String
    {
    	return _imgAlt;
    }

    public function set imgAlt(value:String):void
    {
      if(value != _imgAlt){
        if(value){          
          if(!img){
            COMPILE::JS{
              createImage();
            }
          }
          img.alt = value;
        }else{
          if(img){
            COMPILE::JS{
              removeImage();
            }
          }
        }
      }
    	_imgAlt = value;
    }
    
    private var background:HTMLDivElement;

    COMPILE::JS
    private function createBackground():void{
      background = newElement("div") as HTMLDivElement;
      background.className = appendSelector("-background");
      element.appendChild(background);      
    }
    COMPILE::JS
    private function removeBackground():void{
      element.removeChild(background);
      background = null;
    }

    private var _backgroundstyleColor:String;

    public function get backgroundstyleColor():String
    {
    	return _backgroundstyleColor;
    }

    public function set backgroundstyleColor(value:String):void
    {
      if(value != _backgroundstyleColor){
        if(value){          
          if(!background){
            COMPILE::JS{
              createBackground();
            }
          }
          background.style.backgroundColor = value;
          background.style.backgroundImage = "";
        }else{
          if(background){
            COMPILE::JS{
              removeBackground();
            }
          }
        }
      }
    	_backgroundstyleColor = value;
    }

    private var _backgroundstyleImage:String;

    public function get backgroundstyleImage():String
    {
    	return _backgroundstyleImage;
    }

    public function set backgroundstyleImage(value:String):void
    {
      if(value != _backgroundstyleImage){
        if(value){          
          if(!background){
            COMPILE::JS{
              createBackground();
            }
          }
          background.style.backgroundImage = "url(" + value + ")";
          background.style.backgroundColor = "";
        }else{
          if(background){
            COMPILE::JS{
              removeBackground();
            }
          }
        }
      }
    	_backgroundstyleImage = value;
    }

    private var _backgroundTitle:String;

    public function get backgroundTitle():String
    {
    	return _backgroundTitle;
    }

    public function set backgroundTitle(value:String):void
    {
      if(value != _backgroundTitle){
        if(value){          
          if(!background){
            COMPILE::JS{
              createImage();
            }
          }
          background.title = value;
        }else{
          if(background){
            COMPILE::JS{
              removeImage();
            }
          }
        }
      }
    	_backgroundTitle = value;
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
  }
}
