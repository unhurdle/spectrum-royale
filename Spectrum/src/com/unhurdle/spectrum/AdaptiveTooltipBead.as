package com.unhurdle.spectrum
{
	import org.apache.royale.core.IUIBase;
	import com.unhurdle.spectrum.Tooltip;
	import org.apache.royale.core.IParentIUIBase;
	import org.apache.royale.geom.Point;

	public class AdaptiveTooltipBead extends TooltipBead
	{
		override protected function determinePosition(comp:IUIBase, tooltip:Tooltip):Point
		{
			var margin:int = 0;
			var pt:Point = super.determinePosition(comp, tooltip);
			var screenWidth:Number = (host.popUpParent as IParentIUIBase).width;
			var screenHeight:Number = (host.popUpParent as IParentIUIBase).height;
			if (direction == TooltipBead.LEFT && (pt.x - tooltip.width) < margin)
			{
				direction = TooltipBead.RIGHT;
			} else if (direction == TooltipBead.TOP && (pt.y - tooltip.height) < margin)
			{
				direction = TooltipBead.BOTTOM;
			} else if (direction == TooltipBead.RIGHT && (pt.x + tooltip.width + margin) > screenWidth)
			{
				direction = TooltipBead.LEFT;
			} else if (direction == TooltipBead.BOTTOM && (pt.y + tooltip.height + margin) > screenHeight)
			{
				direction = TooltipBead.TOP;	
			} else
			{
				return pt;
			}
			return super.determinePosition(comp, tooltip);
		}

	}
}

