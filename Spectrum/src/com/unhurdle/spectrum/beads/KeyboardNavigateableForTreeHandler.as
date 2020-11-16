package com.unhurdle.spectrum.beads
{


  import com.unhurdle.spectrum.interfaces.IKeyboardHandler;

  import org.apache.royale.events.utils.NavigationKeys;
  import org.apache.royale.html.util.getLabelFromData;
  import org.apache.royale.core.IStrand;

  public class KeyboardNavigateableForTreeHandler extends KeyboardNavigateableHandler implements IKeyboardHandler
  {
    public function KeyboardNavigateableForTreeHandler()
    {
      super();
    }
    
    override public function set strand(value:IStrand):void{
      super.strand = value;
      host.focusParent.removeEventListener("click",clickHandler);
    }


  }
}