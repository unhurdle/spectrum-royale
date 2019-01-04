package com.unhurdle.spectrum
{
  import org.apache.royale.html.beads.DataContainerView;
  import org.apache.royale.core.ISelectionModel;
  import org.apache.royale.events.Event;
  import org.apache.royale.core.ISelectableItemRenderer;
  import org.apache.royale.core.IRollOverModel;

	public class MenuView extends DataContainerView
	{
		public function MenuView()
		{
			super();
		}

		protected var listModel:ISelectionModel;

		protected var lastSelectedIndex:int = -1;

		/**
		 * @private
		 * @royaleignorecoercion org.apache.royale.core.ISelectionModel
		 */
		override protected function handleInitComplete(event:Event):void
		{
			listModel = _strand.getBeadByType(ISelectionModel) as ISelectionModel;
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