package view.components
{
	import com.unhurdle.spectrum.TextField;
	import org.apache.royale.core.IBeadController;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.core.IColorModel;
	import org.apache.royale.events.IEventDispatcher;
	import org.apache.royale.events.Event;
	import org.apache.royale.utils.CSSUtils;
	import org.apache.royale.html.beads.DispatchInputFinishedBead;

	public class ColorTextFieldController implements IBeadController
	{

        private var _strand:IStrand;
        private var _model:IColorModel;

		public function ColorTextFieldController()
		{
		}

        public function set strand(value:IStrand):void
        {
            _strand = value;
            (value.getBeadByType(IColorModel) as IEventDispatcher).addEventListener("change", changeHandler);
            (value as IEventDispatcher).addEventListener(DispatchInputFinishedBead.INPUT_FINISHED, inputFinishedChanged);
            _model = value.getBeadByType(IColorModel) as IColorModel;
            syncViewWithModel();
        }

        private function changeHandler(event:Event):void
        {
            syncViewWithModel();
        }

        private function syncViewWithModel():void
        {
            (_strand as TextField).text = CSSUtils.attributeFromColor(_model.color);
        }

        private function inputFinishedChanged(event:Event):void
        {
            _model.color = CSSUtils.toColor((_strand as TextField).text);
            (_strand as IEventDispatcher).dispatchEvent(new Event("colorChange"));
        }
    }
}