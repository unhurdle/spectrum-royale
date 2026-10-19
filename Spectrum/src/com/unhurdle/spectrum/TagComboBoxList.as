package com.unhurdle.spectrum
{

	import org.apache.royale.geom.Rectangle;
	import com.unhurdle.spectrum.utils.getPopUpHostLocalBounds;

	public class TagComboBoxList extends ComboBoxList
	{
		public static const MIN_MENU_DEFAULT_HEIGHT:Number = 60;
		private var _minMenuHeight:Number = MIN_MENU_DEFAULT_HEIGHT;
		public override function positionPopup(componentBounds:Rectangle,preferredWidth:Number = NaN):void
		{
			var minHeight:Number = _minMenuHeight + 6;
			// Figure out direction and max size
			var appBounds:Rectangle = getPopUpHostLocalBounds(Application.current.initialView);
			var spaceToBottom:Number = appBounds.bottom - componentBounds.bottom;
			var spaceToTop:Number = componentBounds.top - appBounds.top;
			var spaceOnBottom:Boolean = spaceToBottom >= spaceToTop;
			var pxStr:String = "px";
			switch(position)
			{
				case "top":
					if(spaceToTop >= minHeight || !spaceOnBottom){
						positionPopoverTop(componentBounds.top,spaceToTop);
					} else {
						positionPopoverBottom(componentBounds,spaceToBottom);
					}
					break;
				default:
					if(spaceToBottom >= minHeight || spaceOnBottom){
						positionPopoverBottom(componentBounds,spaceToBottom);
					} else {
						positionPopoverTop(componentBounds.top,spaceToTop);
					}
					break;
			}
			var availableWidth:Number = appBounds.width - componentBounds.x;
			setStyle("maxWidth",availableWidth + "px");
			var leftSpace:Number = componentBounds.x;
			setStyle("left",leftSpace + "px");
		}
		
		private function positionPopoverBottom(componentBounds:Rectangle,maxHeight:Number):void{
			maxHeight -= 6;
			var pxStr:String;
			setStyle("bottom","");
			pxStr = componentBounds.bottom + "px";
			setStyle("top",pxStr);
			pxStr = maxHeight + "px";
			setStyle("max-height",pxStr);
			if(position == "top"){
				position = "bottom";
			}
		}
		
		private function positionPopoverTop(anchorTop:Number,maxHeight:Number):void{
			maxHeight -= 6;
			var pxStr:String;
			setStyle("bottom","");
			pxStr = maxHeight + "px";
			setStyle("max-height",pxStr);
			setStyle("top",(anchorTop - height) + "px");
			if(position == "bottom"){
				position = "top";
			}
		}
	}
}