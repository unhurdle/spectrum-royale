package com.unhurdle.spectrum.beads
{
	import com.unhurdle.spectrum.ListView;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.core.IBeadLayout;
	import org.apache.royale.core.ValuesManager;
	import org.apache.royale.events.Event;
	import com.unhurdle.spectrum.SwatchList;

	public class SwatchListView extends ListView
	{
		public function SwatchListView()
		{
			super();
		}
		
		override public function set strand(value:IStrand):void
		{
			super.strand = value;
			_strand = value;
			
			var layout:IBeadLayout = _strand.getBeadByType(IBeadLayout) as IBeadLayout;
			if (layout == null) {
				var layoutClass:Class = ValuesManager.valuesImpl.getValue(_strand, "iBeadLayout") as Class;
				if (layoutClass != null) {
					layout = new layoutClass() as IBeadLayout;
				} else {
					layout = new TileLayout(); // default
				}
				_strand.addBead(layout);
			}
			if(layout is FlexLayout){
				var swatchList:SwatchList = value as SwatchList;
				(layout as FlexLayout).rowGap = swatchList.rowGap;
				(layout as FlexLayout).columnGap = swatchList.columnGap;
			}

			listenOnStrand("beadsAdded", finishSetup);
		}
		private function finishSetup(ev:Event):void{
			
		}

	}
}