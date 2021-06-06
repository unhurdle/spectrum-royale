package com.unhurdle.spectrum
{
	import com.unhurdle.spectrum.interfaces.IKeyboardHandler;

	import org.apache.royale.core.IStrand;
	import org.apache.royale.events.Event;
	import org.apache.royale.events.ItemClickedEvent;
	import org.apache.royale.utils.loadBeadFromValuesManager;
	import org.apache.royale.html.beads.controllers.ListSingleSelectionMouseController;
	import org.apache.royale.collections.ITreeData;
	import org.apache.royale.events.ItemAddedEvent;
	import org.apache.royale.events.IEventDispatcher;
	import org.apache.royale.events.ItemRemovedEvent;

  public class TreeController extends ListSingleSelectionMouseController
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

		/**
		 * @royaleignorecoercion org.apache.royale.events.IEventDispatcher
		 */
		override protected function handleItemAdded(event:ItemAddedEvent):void
		{
			super.handleItemAdded(event);
			(event.item as IEventDispatcher).addEventListener("itemExpanded", expandedHandler);
		}
		
		/**
		 * @royaleignorecoercion org.apache.royale.events.IEventDispatcher
		 */
		override protected function handleItemRemoved(event:ItemRemovedEvent):void
		{
			super.handleItemRemoved(event);
			(event.item as IEventDispatcher).removeEventListener("itemExpanded", expandedHandler);
		}
    protected function expandedHandler(event:org.apache.royale.events.ItemClickedEvent):void
    {
			var treeData:ITreeData = listModel.dataProvider as ITreeData;
			if (treeData == null) return;
			
			var node:Object = event.data;
			
			if (treeData.hasChildren(node))
			{
				if (treeData.isOpen(node)) {
					treeData.closeNode(node);
				} else {
					treeData.openNode(node);
				}
			}
      event.currentTarget.dispatchEvent(new Event('expanded'));
    }
	}
}