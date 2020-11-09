package com.unhurdle.spectrum
{
  import org.apache.royale.html.beads.DataContainerView;
  import org.apache.royale.core.ISelectionModel;
  import org.apache.royale.events.Event;
  import org.apache.royale.core.ISelectableItemRenderer;
  import org.apache.royale.core.IRollOverModel;
  import com.unhurdle.spectrum.renderers.DataItemRenderer;

	public class MenuView extends DataContainerView
	{
		public function MenuView()
		{
			super();
		}

		protected var listModel:MenuModel;

		protected var lastSelectedIndex:int = -1;
		protected var lastFocusedIndex:int = -1;
		protected var lastKeyboardFocusedIndex:int = -1;

		/**
		 * @private
		 * @royaleignorecoercion org.apache.royale.core.ISelectionModel
		 */
		override protected function handleInitComplete(event:Event):void
		{
			listModel = _strand.getBeadByType(ISelectionModel) as MenuModel;
			listModel.addEventListener("keyboardFocusedIndexChanged", keyboardFocusChangeHandler);
			listModel.addEventListener("focusedIndexChanged", focusChangeHandler);
			listModel.addEventListener("selectedIndexChanged", selectionChangeHandler);
			listModel.addEventListener("rollOverIndexChanged", rollOverIndexChangeHandler);

			super.handleInitComplete(event);
		}

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

		protected function focusChangeHandler(event:Event):void
		{
			var ir:DataItemRenderer = dataGroup.getItemRendererForIndex(lastFocusedIndex) as DataItemRenderer;
			if(ir)
				ir.focused = false;
			ir = dataGroup.getItemRendererForIndex(listModel.focusedIndex) as DataItemRenderer;
			if(ir){
				ir.focused = true;
				ir.keyboardFocused = false;
				ir.focus();
			}
			lastFocusedIndex = listModel.focusedIndex;
		}

		protected function keyboardFocusChangeHandler(event:Event):void
		{
			var ir:DataItemRenderer = dataGroup.getItemRendererForIndex(lastKeyboardFocusedIndex) as DataItemRenderer;
			if(ir)
				ir.keyboardFocused = false;
			ir = dataGroup.getItemRendererForIndex(listModel.keyboardFocusedIndex) as DataItemRenderer;
			if(ir){
				ir.keyboardFocused = true;
				ir.focused = false;
				ir.focus();
			}
			lastKeyboardFocusedIndex = listModel.keyboardFocusedIndex;
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