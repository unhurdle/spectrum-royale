package com.unhurdle.spectrum
{
	COMPILE::JS{
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
	[Event(name="change", type="org.apache.royale.events.Event")]

  public class SliderBase extends SpectrumBase
  {
    public function SliderBase()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-Slider";
    }
    override public function addedToParent():void{
			super.addedToParent();
			positionElements();
    }

		protected function positionElements():void{
      // override in sub-class
		}

    private var _disabled:Boolean;

    public function get disabled():Boolean
    {
			return _disabled;
    }

    public function set disabled(value:Boolean):void
    {
			if(value != !!_disabled){
				toggle("is-disabled",value);
				enableDisableInput(value);
				COMPILE::JS
				{
					if(value){
						element.addEventListener('mousedown', onMouseDown);
					} else {
						element.removeEventListener('mousedown', onMouseDown);
					}
				}
			}
			_disabled = value;
    }
		protected function enableDisableInput(value:Boolean):void{
			// override in sub-class
		}

    public function get step():Number
    {
    	return Number(input.step);
    }

    public function set step(value:Number):void
    {
			//TODO why is this a string?
			input.step = "" + value;
    }
    
    public function get min():Number
    {
    	return Number(input.min);
    }

    public function set min(value:Number):void
    {
        //TODO why is this a string?
        input.min = "" + value;
    }
    
    public function get max():Number
    {
    	return Number(input.max);
    }

    public function set max(value:Number):void
    {
        //TODO why is this a string?
        input.max = "" + value;
    }

    private var _displayValue:Boolean;

    public function get displayValue():Boolean
    {
    	return _displayValue;
    }

    public function set displayValue(value:Boolean):void
    {
        if(value != !!_displayValue){
        	_displayValue = value;
            setLabel();
        }
    }
    private var _label:String;

    public function get label():String
    {
    	return _label;
    }

    public function set label(value:String):void
    {
    	_label = value;
        setLabel();
    }

    private function setLabel():void{
			COMPILE::JS
			{
        if(!labelContainer){
            labelContainer = newElement("div","spectrum-Slider-labelContainer");
			element.insertBefore(labelContainer,controlsContainer);
        }
        if(_label && !labelNode){
            labelNode = new TextNode("label");
            labelNode.className = "spectrum-Slider-label";
            labelContainer.insertBefore(labelNode.element,labelContainer.childNodes[0] || null);
        }
        if(_displayValue && !valueNode){
            valueNode = new TextNode("div");
            valueNode.className = "spectrum-Slider-value";
            labelContainer.appendChild(valueNode.element);
        }
			}
        if(labelNode){
            labelNode.text = _label;
        }
        if(valueNode){
            valueNode.text = getValue();
        }
    }

		protected function getValue():String{
			// override in subclass
			return "";
		}    



    COMPILE::JS
    protected var input:HTMLInputElement;
    COMPILE::SWF
    protected var input:Object;

    COMPILE::JS
    protected var labelContainer:HTMLElement;
    COMPILE::JS
    protected var controlsContainer:HTMLElement;

    protected var labelNode:TextNode;
    
    protected var valueNode:TextNode;
		

		// Element interaction
		COMPILE::JS
		protected function onMouseDown(e:MouseEvent):void {
			onMouseMove(e);
			window.addEventListener('mouseup', onMouseUp);
			window.addEventListener('mousemove', onMouseMove);
		}
		COMPILE::JS
		protected function onMouseUp():void {
			window.removeEventListener('mouseup', onMouseUp);
			window.removeEventListener('mousemove', onMouseMove);
		}
		COMPILE::JS
		protected function onMouseMove(e:MouseEvent):void {
			// override in sub-class

    }

  }
}