package com.unhurdle.spectrum
{
  import org.apache.royale.html.beads.DataContainerView;
  import org.apache.royale.events.Event;
  import org.apache.royale.core.ISelectableItemRenderer;
  import org.apache.royale.core.IRollOverModel;
  import com.unhurdle.spectrum.renderers.DataItemRenderer;
  import org.apache.royale.core.IParent;
  import org.apache.royale.functional.decorator.debounceLong;
  import com.unhurdle.spectrum.utils.canItemGetFocus;

	public class ListView extends DataContainerView
	{
		public function ListView()
		{
			super();
			runChangeHandler = debounceLong(function():void{
				selectionChangeHandler(null);
			},0);
		}

		protected var listModel:ListModel;

		protected var lastSelectedIndex:int = -1;
		protected var lastFocusedIndex:int = -1;
		// protected var lastKeyboardFocusedIndex:int = -1;

		/**
		 * @private
		 * @royaleignorecoercion org.apache.royale.core.ISelectionModel
		 */
		override protected function handleInitComplete(event:Event):void
		{
			listModel = dataModel as ListModel;
			listModel.addEventListener("selectedIndexChanged", selectionChangeHandler);
			listModel.addEventListener("rollOverIndexChanged", rollOverIndexChangeHandler);
			// Don't call super because we don't need the overhead of layout
			// super.handleInitComplete(event);
		}
		private var focusableItemRenderer:DataItemRenderer;
		override protected function itemsCreatedHandler(event:Event):void{
			// set focus on item renderers
			
			if(focusableItemRenderer){

				if((contentView as IParent).getElementIndex(focusableItemRenderer) == -1){
					focusableItemRenderer.focused = focusableItemRenderer.keyboardFocused = false;
					focusableItemRenderer = null;
				}
			}
			var currentInxex:int = 0;
			while(!focusableItemRenderer && dataGroup.numItemRenderers > currentInxex){
				focusableItemRenderer = dataGroup.getItemRendererAt(currentInxex) as DataItemRenderer;
				if (canItemGetFocus(focusableItemRenderer))
				{
					focusableItemRenderer.tabFocusable = true;
				} else
				{
					focusableItemRenderer = null;
					currentInxex++;
				}
			}
			super.itemsCreatedHandler(event);
			runChangeHandler();
		}
		private var runChangeHandler:Function;
		/**
		 * @private
		 * @royaleignorecoercion org.apache.royale.core.ISelectableItemRenderer
		 */
		protected function selectionChangeHandler(event:Event):void
		{
			var ir:ISelectableItemRenderer = dataGroup.getItemRendererForIndex(lastSelectedIndex) as ISelectableItemRenderer;
			if(ir)
				ir.selected = false;
			ir = dataGroup.getItemRendererForIndex(listModel.selectedIndex) as ISelectableItemRenderer;
			if(ir)
				ir.selected = true;

			lastSelectedIndex = listModel.selectedIndex;
		}

		protected var lastRollOverIndex:int = -1;

		/**
		 * @private
		 * @royaleignorecoercion org.apache.royale.core.ISelectableItemRenderer
		 * * @royaleignorecoercion org.apache.royale.core.IRollOverModel
		 */
		protected function rollOverIndexChangeHandler(event:Event):void
		{
			var ir:ISelectableItemRenderer = dataGroup.getItemRendererForIndex(lastRollOverIndex) as ISelectableItemRenderer;
			if(ir)
				ir.hovered = false;
			ir = dataGroup.getItemRendererForIndex((listModel as IRollOverModel).rollOverIndex) as ISelectableItemRenderer;
			if(ir)
				ir.hovered = true;
			lastRollOverIndex = (listModel as IRollOverModel).rollOverIndex;
		}
	}

}