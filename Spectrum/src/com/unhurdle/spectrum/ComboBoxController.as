package com.unhurdle.spectrum
{
	import org.apache.royale.core.IBeadController;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.events.Event;
	import org.apache.royale.events.IEventDispatcher;
	import org.apache.royale.events.MouseEvent;
	import org.apache.royale.html.beads.IComboBoxView;

  public class ComboBoxController implements IBeadController
  {
    public function ComboBoxController()
    {
      
    }
		
		private var _strand:IStrand;
		
		protected var viewBead:IComboBoxView;
		
		public function set strand(value:IStrand):void
		{
			_strand = value;
			
			viewBead = _strand.getBeadByType(IComboBoxView) as IComboBoxView;
			if (viewBead) {
				finishSetup(null);
			} else {
				(_strand as IEventDispatcher).addEventListener("viewChanged", finishSetup);
			}
		}
		
		protected function finishSetup(event:Event):void
		{
			if (viewBead == null) {
				viewBead = _strand.getBeadByType(IComboBoxView) as IComboBoxView;
			}
			viewBead.popupButton.addEventListener("click", handleButtonClick);
			viewBead.textInputField.addEventListener("click", handleButtonClick);
			viewBead.popUp.addEventListener("change", handleListChange);
		}
		
		protected function handleButtonClick(event:MouseEvent):void
		{			
			viewBead.popUpVisible = !viewBead.popUpVisible;
		}
		
		private function handleListChange(event:Event):void
		{
			viewBead.popUpVisible = false;
			
			(_strand as IEventDispatcher).dispatchEvent(new Event("change"));
		}
	}
}
