package com.unhurdle.spectrum.colorpicker
{
	import com.unhurdle.spectrum.TextField;
	import org.apache.royale.core.IBeadController;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.events.IEventDispatcher;
	import org.apache.royale.events.Event;
	import org.apache.royale.html.beads.DispatchInputFinishedBead;
	import org.apache.royale.core.IRangeModel;
	import org.apache.royale.events.ValueChangeEvent;
	import org.apache.royale.utils.number.pinValue;

	public class AlphaTextFieldController implements IBeadController
	{

        private var _strand:IStrand;
        private var _model:IRangeModel;

		public function AlphaTextFieldController()
		{
		}

        public function set strand(value:IStrand):void
        {
            _strand = value;
            (value.getBeadByType(IRangeModel) as IEventDispatcher).addEventListener(ValueChangeEvent.VALUE_CHANGE, changeHandler);
            (value as IEventDispatcher).addEventListener(DispatchInputFinishedBead.INPUT_FINISHED, inputFinishedChanged);
            _model = value.getBeadByType(IRangeModel) as IRangeModel;
            syncViewWithModel();
        }

        private function changeHandler(event:Event):void
        {
            syncViewWithModel();
        }

        private function syncViewWithModel():void
        {
            (_strand as TextField).text = (100 - _model.value) + "%";
        }

        private function inputFinishedChanged(event:Event):void
        {
            var str:String = (event.target as TextField).text;
            str.replace("%", "");
            var num:Number = parseInt(str);
            num = pinValue(num,_model.minimum,_model.maximum);
            _model.value = 100 - num;
            (_strand as IEventDispatcher).dispatchEvent(new Event("alphaChange"));
        }
    }
}
