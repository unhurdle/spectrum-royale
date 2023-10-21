package com.unhurdle.spectrum
{

	import org.apache.royale.core.IChild;
	import org.apache.royale.events.IEventDispatcher;

	public class Accordion extends Group
	{
		/**
		 * <inject_html>
		 * <link rel="stylesheet" href="assets/css/components/accordion/dist.css">
		 * </inject_html>
		 * 
		 */

		public function Accordion()
		{
			super();
		}

		override protected function getSelector():String{
			return "spectrum-Accordion";
		}
		private var _allowMultiple:Boolean;
		/**
		 * Whether or not multiple items can be open at once.
		 */
		public function get allowMultiple():Boolean
		{
			return _allowMultiple;
		}
		public function set allowMultiple(value:Boolean):void
		{
			_allowMultiple = value;
		}

		/**
		 * @royaleemitcoercion com.unhurdle.spectrum.AccordionSection
		 */
		override public function addElement(c:IChild, dispatchEvent:Boolean = true):void
		{
			super.addElement(c,dispatchEvent);
			attachListeners(c);
		}
		/**
		 * @royaleemitcoercion com.unhurdle.spectrum.AccordionSection
		 */
		override public function addElementAt(c:IChild, index:int, dispatchEvent:Boolean = true):void
		{
			super.addElementAt(c,index,dispatchEvent);
			attachListeners(c);
		}
		/**
		 * @royaleemitcoercion com.unhurdle.spectrum.AccordionSection
		 */
		private function attachListeners(c:IChild):void
		{
			if(c is AccordionSection){
				(c as IEventDispatcher).addEventListener("openChanged",sectionChangeHandler);
			}
		}
		override public function removeElement(c:IChild, dispatchEvent:Boolean = true):void
		{
			super.removeElement(c,dispatchEvent);
			if(c is AccordionSection){
				(c as IEventDispatcher).removeEventListener("openChanged",sectionChangeHandler);
			}
		}

		private function sectionChangeHandler(ev:Event):void{
			var section:AccordionSection = ev.target as AccordionSection;
			if(allowMultiple || !section.open)
				return;

			for(var i:int=0;i<numElements;i++){
				var child:AccordionSection = getElementAt(i) as AccordionSection;
				if(child != section){
					child.open = false;
				}
			}
		}

	}
}