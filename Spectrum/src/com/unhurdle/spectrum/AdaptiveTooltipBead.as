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
			if ((direction == TooltipBead.LEFT || direction == TooltipBead.BOTTOM || direction == TooltipBead.TOP) && pt.x < margin) //off screen left
			{
				direction = TooltipBead.RIGHT;
			} else if ((direction == TooltipBead.TOP || direction == TooltipBead.LEFT || direction == TooltipBead.RIGHT) && pt.y < margin) //off screen top
			{
				direction = TooltipBead.BOTTOM;
			} else if ((direction == TooltipBead.RIGHT || direction == TooltipBead.TOP || direction == TooltipBead.BOTTOM) && (pt.x + tooltip.width + margin) > screenWidth) //off screen right
			{
				direction = TooltipBead.LEFT;
			} else if ((direction == TooltipBead.BOTTOM || direction == TooltipBead.LEFT || direction == TooltipBead.RIGHT) && (pt.y + tooltip.height + margin) > screenHeight) //off screen bottom
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

