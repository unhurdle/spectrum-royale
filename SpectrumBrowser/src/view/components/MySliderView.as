package view.components
{
	COMPILE::SWF {
		import flash.display.DisplayObject;
		import flash.display.Sprite;
	}
	
    import org.apache.royale.core.BeadViewBase;
    import org.apache.royale.core.IBead;
    import org.apache.royale.core.IBeadLayout;
    import org.apache.royale.core.IBeadModel;
    import org.apache.royale.core.IBeadView;
    import org.apache.royale.core.IRangeModel;
    import org.apache.royale.core.IParent;
    import org.apache.royale.core.IStrand;
    import org.apache.royale.core.IUIBase;
    import org.apache.royale.core.UIBase;
    import org.apache.royale.core.ValuesManager;
    import org.apache.royale.events.Event;
    import org.apache.royale.events.IEventDispatcher;
    import org.apache.royale.html.Button;
    import org.apache.royale.html.TextButton;
    import org.apache.royale.html.beads.ISliderView;
	
	public class MySliderView extends BeadViewBase implements ISliderView, IBeadView
	{
		public function MySliderView()
		{
		}
		
		private var rangeModel:IRangeModel;
		
		override public function set strand(value:IStrand):void
		{
			super.strand = value;
			
			var layout:IBeadLayout = _strand.getBeadByType(IBeadLayout) as IBeadLayout;
			if (layout == null) {
				var klass:Class = ValuesManager.valuesImpl.getValue(_strand, "iBeadLayout");
				_strand.addBead(new klass() as IBead);
			}
			
            _track = new Button();
            _track.className = "SliderTrack";
            _track.style = {"position": "absolute", "padding" : 0, "opacity" : 0};
            (host as IParent).addElement(_track);
            
            _thumb = new Button();
            _thumb.className = "SliderThumb";
            _thumb.style = {"position" : "absolute", "padding" : 0};
            (host as IParent).addElement(_thumb);
			
			rangeModel = _strand.getBeadByType(IBeadModel) as IRangeModel;

			var rm:IEventDispatcher = rangeModel as IEventDispatcher;
			
			// listen for changes to the model and adjust the UI accordingly.
			rm.addEventListener("valueChange",modelChangeHandler);
			rm.addEventListener("minimumChange",modelChangeHandler);
			rm.addEventListener("maximumChange",modelChangeHandler);
			rm.addEventListener("stepSizeChange",modelChangeHandler);
			rm.addEventListener("snapIntervalChange",modelChangeHandler);
			
			(_strand as IEventDispatcher).dispatchEvent(new Event("layoutNeeded"));
		}
		
		private var _track:Button;
		private var _thumb:Button;
		
		public function get track():IUIBase
		{
			return _track;
		}
		
		public function get thumb():IUIBase
		{
			return _thumb;
		}
		
		private function modelChangeHandler( event:Event ) : void
		{
			(_strand as IEventDispatcher).dispatchEvent(new Event("layoutNeeded"));
		}
	}
}
