package com.unhurdle.spectrum
{
  COMPILE::JS{
        import org.apache.royale.html.util.addElementToWrapper;
        import org.apache.royale.core.WrappedHTMLElement;
    }
  
  public class LogicButton extends SpectrumBase
  {
    public function LogicButton()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-LogicButton";
    }
    
    COMPILE::JS
    private var button:HTMLButtonElement;

    COMPILE::SWF
    private var button:Object;
		
		COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
			var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
			button = newElement("button") as HTMLButtonElement;
			elem.appendChild(button);
			return elem;
    }
			private var _type:String;

			public function get type():String
			{
				return _type || "";
			}

			public function set type(value:String):void
			{
				if(value != _type){
					switch (value){
						// check that values are valid
						case "and":
						case "or":
							break;
						default:
							throw new Error("Invalid type: " + value);
						}
						if(_type){
							toggle(valueToSelector(_type), false);
						}
						if(value){
							toggle(valueToSelector(value), true);
						}
						_type = value;
						button.value = value;
				}
			}
        private var _disabled:Boolean;

        public function get disabled():Boolean
        {
        	return _disabled;
        }

        public function set disabled(value:Boolean):void
        {
            if(!!value != !!_disabled){
                button.disabled = value;
            }
        	_disabled = value;
        }
  }
}