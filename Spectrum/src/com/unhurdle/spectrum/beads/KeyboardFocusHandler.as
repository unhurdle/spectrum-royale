package com.unhurdle.spectrum.beads
{
  import org.apache.royale.core.Bead;
  import org.apache.royale.core.IStrand;
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
      host.focusElement.addEventListener("mousedown",handleMousedown);
    }

    private function handleFocus(ev:Event):void{
      // trace("focus");
      if(duringClick){
        host.focused = true;
      } else {
        host.keyboardFocused = true;
      }
    }
    private function handleBlur(ev:Event):void{
      // trace("blur");
      host.focused = host.keyboardFocused = false;
    }
    private var duringClick:Boolean;
    private function handleMousedown(ev:Event):void{
      // trace("mousedown");
      duringClick = true;
      setTimeout(function():void{
        duringClick = false;
      },100);
      // focused = keyboardFocused = false;
    }

  }
}