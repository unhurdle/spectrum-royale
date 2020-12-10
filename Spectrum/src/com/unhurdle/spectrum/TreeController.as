package com.unhurdle.spectrum
{
	import com.unhurdle.spectrum.interfaces.IKeyboardHandler;

	import org.apache.royale.core.IStrand;
	import org.apache.royale.events.Event;
	import org.apache.royale.events.ItemClickedEvent;
	import org.apache.royale.html.beads.controllers.TreeSingleSelectionMouseController;
	import org.apache.royale.utils.loadBeadFromValuesManager;

  public class TreeController extends TreeSingleSelectionMouseController
  {
    public function TreeController()
    {
      super();
    }
		
		// override protected function selectedHandler(event:ItemClickedEvent):void
    // {
		// 	super.selectedHandler(event);
		// 	if(event.index == listModel.keyboardFocusedIndex){
		// 		listModel.keyboardFocusedIndex = -1;
		// 	}
    // }
		
    override public function set strand(value:IStrand):void
		{
			super.strand = value;
			loadBeadFromValuesManager(IKeyboardHandler, "iKeyboardHandler", _strand);
		}
    override protected function expandedHandler(event:org.apache.royale.events.ItemClickedEvent):void
    {
      super.expandedHandler(event);
      event.currentTarget.dispatchEvent(new Event('expanded'));
    }
	}
}