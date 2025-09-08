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
	import org.apache.royale.core.ISelectableItemRenderer;
	import org.apache.royale.utils.sendStrandEvent;

  public class TreeController extends ListSingleSelectionMouseController
  {
    public function TreeController()
    {
      super();
    }
		
		override protected function selectedHandler(event:ItemClickedEvent):void
    {
			var host:Tree = _strand as Tree;
			if(host.deselectOnClick && listModel.selectedIndex == event.index && listModel.selectedItem == event.data){
				listModel.selectedItem = null;
			} else {
				listModel.selectedItem = event.data;
			}
			sendStrandEvent(host,"change");
    }
		
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
				if(node){
					if(!listModel.selectedItem){
							for each(var value:Object in node.children){
								if(value.selected){
									//items were looking selected but the selectedItem wasn't actually set in single select tree.
									listModel.selectedItem = value;
									break;
								}
							}
						
					} else {
						if(node.children){
							for each(value in node.children){
								//if there's a different item selected remove selection from the node's children
								//using both dot and bracket syntax to deal with minified properties
								if(value.selected){
									value.selected = false
								} else if(value["selected"]){
									value["selected"] = false;
								}
								if(value.checked){
									value.checked = false
								} else if(value["checked"]){
									value["checked"] = false;
								}
							}
						}
					}
				}
				// remove the selection of the current selected item renderer
				if(dataGroup){
					var ir:ISelectableItemRenderer = dataGroup.getItemRendererForIndex(listModel.selectedIndex) as ISelectableItemRenderer;
					ir.selected = false;
				}
				if (treeData.isOpen(node)) {
					treeData.closeNode(node);
				} else {
					treeData.openNode(node);
				}
			}
			(listModel as ListModel).refreshIndex();
      event.currentTarget.dispatchEvent(new Event('expanded'));
    }
	}
}