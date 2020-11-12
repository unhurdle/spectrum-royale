package com.unhurdle.spectrum
{
	import org.apache.royale.events.ItemClickedEvent;

  public class TreeController extends MenuController
  {
    public function TreeController()
    {
      super();
    }
		
		override protected function selectedHandler(event:ItemClickedEvent):void
    {
			super.selectedHandler(event);
			if(event.index == listModel.keyboardFocusedIndex){
				listModel.keyboardFocusedIndex = -1;
			}
    }
	}
}