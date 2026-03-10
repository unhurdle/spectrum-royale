package com.unhurdle.spectrum {
	import com.unhurdle.spectrum.AdaptiveTooltipBead;
	import com.unhurdle.spectrum.ISpectrumElement;
	import com.unhurdle.spectrum.ITextContent;
	import com.unhurdle.spectrum.TextField;

	import org.apache.royale.core.Bead;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.events.MouseEvent;

	public class OversetTooltip extends Bead {
		public function OversetTooltip() {
			super();
		}
		/**
		 * This bead can be applied to any ITextContent component.
		 * ITextContent is anything which has a text property.
		 * 
		 * TextFields need to have their input property set as the element.
		 * FieldButtons need to have their textNode.element property set as the element.
		 * Other components need to have their element property set as the element.
		 */

		private var element:HTMLElement;
		private var toolTipBead:AdaptiveTooltipBead;
		private var _tooltipText:String;

		override public function set strand(value:IStrand):void {
			super.strand = value;
			if (value is TextField) {
				element = (value as TextField).input;
			} else if (value is FieldButton) {
				element = (value as FieldButton).textNode.element;
			} else {
				COMPILE::JS {
					element = (value as ISpectrumElement).element;
				}
			}
			element.addEventListener(MouseEvent.MOUSE_OVER, titleHover);
		}

		private function titleHover():void {
			if (element.scrollWidth > element.clientWidth) {
				if (!toolTipBead) {
					toolTipBead = new AdaptiveTooltipBead();
					toolTipBead.autoClose = 0;
					_strand.addBead(toolTipBead);
				}
				setTooltip(_tooltipText || (_strand as ITextContent).text);
			}
			else {
				setTooltip("");
			}
		}

		private function setTooltip(value:String):void {
			if (toolTipBead) {
				toolTipBead.toolTip = value;
			}
		}

		public function set tooltipText(val:String):void {
			_tooltipText = val;
		}
	}
}