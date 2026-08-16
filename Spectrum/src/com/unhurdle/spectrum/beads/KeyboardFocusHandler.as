package com.unhurdle.spectrum.beads
{
  import org.apache.royale.core.Bead;
  import org.apache.royale.core.IStrand;
  import com.unhurdle.spectrum.Application;
  import com.unhurdle.spectrum.interfaces.IKeyboardFocusable;
  import org.apache.royale.debugging.assert;

  public class KeyboardFocusHandler extends Bead
  {
    public function KeyboardFocusHandler()
    {
      super();
    }
    private function get host():IKeyboardFocusable{
      assert(_strand is IKeyboardFocusable,"The strand must be an IKeyboardFocusable!");
      return _strand as IKeyboardFocusable;
    }
    override public function set strand(value:IStrand):void{
      super.strand = value;
      host.focusElement.addEventListener("focus",handleFocus);
      host.focusElement.addEventListener("blur",handleBlur);
      COMPILE::JS
      {
        initializeModalityTracking();
      }
      COMPILE::SWF
      {
        host.focusElement.addEventListener("mousedown",handleMousedown);
      }
    }

    private function handleFocus(ev:Event):void{
      COMPILE::JS
      {
        if(keyboardModality){
          host.keyboardFocused = true;
        } else {
          host.focused = true;
        }
      }
      COMPILE::SWF
      {
        if(duringClick){
          host.focused = true;
        } else {
          host.keyboardFocused = true;
        }
      }
    }
    private function handleBlur(ev:Event):void{
      host.focused = host.keyboardFocused = false;
    }

    COMPILE::JS
    private static var modalityTrackingInitialized:Boolean;

    COMPILE::JS
    private static var keyboardModality:Boolean = true;

    COMPILE::JS
    private static function initializeModalityTracking():void{
      if(modalityTrackingInitialized){
        return;
      }
      modalityTrackingInitialized = true;
      if(Application.current.usePointerEvents){
        document.addEventListener("pointerdown",handleInputDown,true);
      } else {
        document.addEventListener("mousedown",handleInputDown,true);
      }
      document.addEventListener("keydown",handleKeyDown,true);
    }

    COMPILE::JS
    private static function handleInputDown(event:Event):void{
      keyboardModality = false;
    }

    COMPILE::JS
    private static function handleKeyDown(event:KeyboardEvent):void{
      if(!event.altKey && !event.ctrlKey && !event.metaKey){
        keyboardModality = true;
      }
    }

    COMPILE::SWF
    private var duringClick:Boolean;

    COMPILE::SWF
    private function handleMousedown(event:Event):void{
      duringClick = true;
      setTimeout(function():void{
        duringClick = false;
      },100);
    }

  }
}