package com.unhurdle.spectrum
{
  import org.apache.royale.events.Event;
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.elements.Div;
    import org.apache.royale.core.WrappedHTMLElement;
    import com.unhurdle.spectrum.const.IconType;
  }

  [Event(name="modalShown", type="org.apache.royale.events.Event")]
  [Event(name="modalHidden", type="org.apache.royale.events.Event")]

  public class Dialog extends Group
  {
    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/dialog/dist.css">
     * </inject_html>
     * 
     */

    public function Dialog()
    {
      super();
      overlay = new SpectrumOverlay();
      overlay.hideOnClick = false;
      addBead(overlay);
      addEventListener("modalShown",handleModalShow);
      addEventListener("modalHidden",handleModalHidden);
    }

    public static const ALERT:int = 1;
    public static const REGULAR:int = 2;
    public static const FULLSCREEN:int = 3;
    public static const FULLSCREEN_TAKEOVER:int = 4;
    public static const SMALL:int = 5;
    public static const MEDIUM:int = 6;
    public static const LARGE:int = 7;
    private var overlay:SpectrumOverlay;
    override protected function getSelector():String{
      return "spectrum-Dialog";
    }

    COMPILE::JS
    private var outerElement:HTMLElement;
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = addElementToWrapper(this,"div");
      outerElement = newElement("div",appendSelector("-wrapper"));
      outerElement.appendChild(elem);
      return elem
    }
    /**
     * The HTMLElement used to position the component.
     * @royaleignorecoercion org.apache.royale.core.WrappedHTMLElement
     */
    COMPILE::JS
    override public function get positioner():WrappedHTMLElement
    {
        return outerElement as WrappedHTMLElement;
    }

    private var _size:int;

    public function get size():int
    {
    	return _size;
    }
    private var styleLookup:Array = [
      "",
      "alert",
      "",
      "fullscreen",
      "fullscreenTakeover",
      "small",
      "medium",
      "large"
    ];
    public function set size(value:int):void
    {
      if(value != _size){
        var oldSize:String = styleLookup[_size];
        if(oldSize){
            toggle(valueToSelector(oldSize),false);
        }
        var newSize:String = styleLookup[value];
        if(newSize){
          toggle(valueToSelector(newSize),true);
        }
      }
    	_size = value;
    }
    COMPILE::JS
    private var heroDiv:Div;
    private var _hero:String;

    public function get hero():String
    {
    	return _hero;
    }
    public function set hero(value:String):void
    {
      if(value != !!_hero){
        // toggle(valueToSelector("hero"),value);
        COMPILE::JS{
          if(value){this.parent
            if(!heroDiv){
              heroDiv = new Div();
              heroDiv.className = appendSelector("-hero");
              addElementAt(heroDiv,0);
            }
            heroDiv.element.style.backgroundImage="url("+ value + ")";
          }else{
            removeElement(heroDiv);
            heroDiv = null;
          }
        }
      }
    	_hero = value;
    }
    private var _dismissible:Boolean;

    public function get dismissible():Boolean
    {
    	return _dismissible;
    }
    private var closeButton:ActionButton;
    public function set dismissible(value:Boolean):void
    {
      if(value != !!_dismissible){
        toggle(valueToSelector("dismissible"),value);
        COMPILE::JS{
          if(value){
            if(!closeButton){
              closeButton = new ActionButton();
              closeButton.quiet = true;
              closeButton.className = appendSelector("-closeButton");
              var type:String = IconType.CROSS_LARGE;
              closeButton.icon = Icon.getCSSTypeSelector(type);
              closeButton.iconType = type;
              closeButton.addEventListener("click",hide);
            }
            addElement(closeButton);
          }else{
            removeElement(closeButton);
          }
        }          
      }
    	_dismissible = value;
    }
    private var _noDivider:Boolean;

    public function get noDivider():Boolean
    {
    	return _noDivider;
    }

    public function set noDivider(value:Boolean):void
    {
      if(value != !!_noDivider){
        toggle(valueToSelector("noDivider"),value);
      }
    	_noDivider = value;
    }

    public function get easyDismiss():Boolean
    {
    	return overlay.hideOnClick;
    }

    public function set easyDismiss(value:Boolean):void
    {
    	overlay.hideOnClick = value;
    }
    private var _error:Boolean;

    public function get error():Boolean
    {
    	return _error;
    }

    public function set error(value:Boolean):void
    {
      if(value != !!_error){
        toggle(valueToSelector("error"),value);
      }
    	_error = value;
    }
    private var _success:Boolean;

    public function get success():Boolean
    {
    	return _success;
    }

    public function set success(value:Boolean):void
    {
      if(value != !!_success){
        toggle(valueToSelector("success"),value);
      }
    	_success = value;
    }
    private var attachedToApp:Boolean;
    public function show():void{
      Application.current.popUpParent.addElement(this);
      visible = true;
      dispatchEvent(new Event("modalShown"));
    }
    private function handleModalShow(ev:Event):void{
        toggle("is-open",true);
    }
    public function hide():void
    {
      visible = false;
      toggle("is-open",false);
      parent.removeElement(this);
      dispatchEvent(new Event("modalHidden"));
      dispatchEvent(new Event("hide"));
    }
    private function handleModalHidden(ev:Event):void{
      toggle("is-open",false);
    }
  }
}