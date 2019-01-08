package com.unhurdle.spectrum
{
  import org.apache.royale.events.Event;
  import org.apache.royale.html.beads.plugin.ModalDisplay;

  [Event(name="modalShown", type="org.apache.royale.events.Event")]
  [Event(name="modalHidden", type="org.apache.royale.events.Event")]

  public class Dialog extends Group
  {
    public static const ALERT:int = 1;
    public static const REGULAR:int = 2;
    public static const FULLSCREEN:int = 3;
    public static const FULLSCREEN_TAKEOVER:int = 4;

    public function Dialog()
    {
      super();
      modal = new ModalDisplay()
      addBead(modal);
      var overlay:SpectrumOverlay = new SpectrumOverlay();
      // overlay.hideOnClick = false;
      addBead(overlay);
      addEventListener("modalShown",handleModalShow);
      addEventListener("modalHidden",handleModalHidden);
    }
    private var modal:ModalDisplay;
    override protected function getSelector():String{
      return "spectrum-Dialog";
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
      "fullscreenTakeover"
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
    private var attachedToApp:Boolean;
    public function show():void{
      modal.show(Application.current);
    }
    private function handleModalShow(ev:Event):void{
        toggle("is-open",true);
    }
    public function hide():void
    {
      toggle("is-open",false);
      modal.hide();
      dispatchEvent(new Event("hide"));
    }
    private function handleModalHidden(ev:Event):void{
      toggle("is-open",false);
    }
  }
}