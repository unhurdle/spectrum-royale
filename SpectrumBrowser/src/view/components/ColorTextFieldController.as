package view.components
{
	import com.unhurdle.spectrum.TextField;
	import org.apache.royale.core.IBeadController;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.core.IColorModel;
	import org.apache.royale.events.IEventDispatcher;
	import org.apache.royale.events.Event;
	import org.apache.royale.utils.ColorUtil;
	import org.apache.royale.utils.CSSUtils;

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
    }
}