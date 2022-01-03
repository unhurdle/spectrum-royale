package com.unhurdle.spectrum
{
	import org.apache.royale.core.IBeadController;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.events.Event;
	import org.apache.royale.events.IEventDispatcher;
	import org.apache.royale.events.MouseEvent;
	import org.apache.royale.html.beads.IComboBoxView;
	import org.apache.royale.core.UIBase;

  public class ComboBoxController implements IBeadController
  {
    public function ComboBoxController()
    {
      
    }
		
		private var _strand:IStrand;
		private var host:UIBase;
		protected var viewBead:IComboBoxView;
		
		public function set strand(value:IStrand):void
		{
			_strand = value;
			host = value as UIBase;
			viewBead = host.view as IComboBoxView;
			if (viewBead) {
				finishSetup(null);
			} else {
				host.addEventListener("viewChanged", finishSetup);
			}
		}
		
		protected function finishSetup(event:Event):void
		{
			if (viewBead == null) {
				viewBead = host.view as IComboBoxView;
			}
			viewBead.popupButton.addEventListener("click", handleButtonClick);
			viewBead.textInputField.addEventListener("click", handleInputClick);
			viewBead.popUp.addEventListener("change", handleListChange);
		}
		
		protected function handleButtonClick(event:MouseEvent):void
		{			
			viewBead.popUpVisible = !viewBead.popUpVisible;
		}
		
		private function handleInputClick(event:MouseEvent):void{
			if(!viewBead.popUpVisible){
				viewBead.popUpVisible = true;
			}
		}
		private function handleListChange(event:Event):void
		{
			viewBead.popUpVisible = false;
			
			host.dispatchEvent(new Event("change"));
		}

	}
}
