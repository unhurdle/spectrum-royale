package com.unhurdle.spectrum
{
    
    COMPILE::JS{
        import org.apache.royale.html.util.addElementToWrapper;
        import org.apache.royale.core.WrappedHTMLElement;
    }

    public class CoachMark extends SpectrumBase
    {
        public static const DARK:String = "dark";
        public static const LIGHT:String = "light";
        public function CoachMark()
        {
            super();
            typeNames = "spectrum-CoachMarkIndicator";
        }
        COMPILE::JS
        override protected function createElement():WrappedHTMLElement{
            var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
            // add three ring elements
            for(var i:int=0;i<3;i++){
                elem.appendChild(newElement("div","spectrum-CoachMarkIndicator-ring"));
            }
            //without dialog
            return elem;
        }
//111111111111111111111111111111111111111111111111111
// <div class="spectrum-CoachMarkIndicator spectrum-CoachMarkIndicator--quiet" style="position: absolute;">
//     <div class="spectrum-CoachMarkIndicator-ring"></div>
//     <div class="spectrum-CoachMarkIndicator-ring"></div>
//     <div class="spectrum-CoachMarkIndicator-ring"></div>
//   </div>
//<div class="spectrum-CoachMarkPopover" style="position: absolute; margin-left: 34px;">
//     <div class="spectrum-CoachMarkPopover-header">
//       <div class="spectrum-CoachMarkPopover-title">Zoom in</div>
//     </div>
//     <div class="spectrum-CoachMarkPopover-content">
//       Switch to the zoom tool then click and drag in the canvas to move your camera forward and backward.
//     </div>
//     <div class="spectrum-CoachMarkPopover-footer">
//       <button class="spectrum-Button spectrum-Button--primary">
//         <span>Okay</span>
//       </button>
//     </div>
//   </div>
//222222222222222222222222222222222222222222222222
// <div class="spectrum-CoachMarkIndicator spectrum-CoachMarkIndicator--quiet">
//     <div class="spectrum-CoachMarkIndicator-ring"></div>
//     <div class="spectrum-CoachMarkIndicator-ring"></div>
//     <div class="spectrum-CoachMarkIndicator-ring"></div>
//   </div>
// <div class="spectrum-CoachMarkPopover">
//     <div class="spectrum-CoachMarkPopover-header">
//       <div class="spectrum-CoachMarkPopover-title">Zoom in</div>
//     </div>
//     <div class="spectrum-CoachMarkPopover-content">
//       Switch to the zoom tool then click and drag in the canvas to move your camera forward and backward.
//     </div>
//     <div class="spectrum-CoachMarkPopover-footer">
//       <button class="spectrum-Button spectrum-Button--secondary spectrum-Button--quiet">
//         <span>Skip Tour</span>
//       </button>
//       <button class="spectrum-Button spectrum-Button--primary">
//         <span>Next</span>
//       </button>
//     </div>
//   </div>
//33333333333333333333333333333333333333333333333333
//   <div class="spectrum-CoachMarkIndicator">
//     <div class="spectrum-CoachMarkIndicator-ring"></div>
//     <div class="spectrum-CoachMarkIndicator-ring"></div>
//     <div class="spectrum-CoachMarkIndicator-ring"></div>
//   </div>

//   <div class="spectrum-CoachMarkPopover">
//     <div class="spectrum-CoachMarkPopover-header">
//       <div class="spectrum-CoachMarkPopover-title">Zoom in</div>
//       <div class="spectrum-CoachMarkPopover-step">2 of 8</div>
//     </div>
//     <div class="spectrum-CoachMarkPopover-content">
//       Switch to the zoom tool then click and drag in the canvas to move your camera forward and backward.
//     </div>
//     <div class="spectrum-CoachMarkPopover-footer">
//       <button class="spectrum-Button spectrum-Button--secondary spectrum-Button--quiet">
//         <span>Skip Tour</span>
//       </button>
//       <button class="spectrum-Button spectrum-Button--primary">
//         <span>Next</span>
//       </button>
//     </div>
//   </div>
//444444444444444444444444444444444444444444444
//   <div class="spectrum-CoachMarkPopover">
//     <img src="img/example-ava.jpg" class="spectrum-CoachMarkPopover-image">

//     <div class="spectrum-CoachMarkPopover-header">
//       <div class="spectrum-CoachMarkPopover-title">Zoom in</div>
//       <div class="spectrum-CoachMarkPopover-step">2 of 8</div>
//     </div>
//     <div class="spectrum-CoachMarkPopover-content">
//       Switch to the zoom tool then click and drag in the canvas to move your camera forward and backward.
//     </div>
//     <div class="spectrum-CoachMarkPopover-footer">
//       <button class="spectrum-Button spectrum-Button--secondary spectrum-Button--quiet">
//         <span>Skip Tour</span>
//       </button>
//       <button class="spectrum-Button spectrum-Button--primary">
//         <span>Next</span>
//       </button>
//     </div>
//   </div>

//   <div class="spectrum-CoachMarkIndicator">
//     <div class="spectrum-CoachMarkIndicator-ring"></div>
//     <div class="spectrum-CoachMarkIndicator-ring"></div>
//     <div class="spectrum-CoachMarkIndicator-ring"></div>
//   </div>

        private var _isAbsolute:Boolean;

        public function get isAbsolute():Boolean
        {
        	return _isAbsolute;
        }

        public function set isAbsolute(value:Boolean):void
        {
        	_isAbsolute = value;
        }
         
        private var _quiet:Boolean;

        public function get quiet():Boolean
        {
            return _quiet;
        }

        public function set quiet(value:Boolean):void
        {
            if(value != !!_quiet){
                toggle(valueToCSS("quiet"),value);
            }
            _quiet = value;
        }

        private var _flavor:String;

        public function get flavor():String
        {
            return _flavor;
        }

        public function set flavor(value:String):void
        {
            if(value != _flavor){
                switch (value){
                case "dark":
                case "light":
                case "":
                    break;
                default:
                    throw new Error("Invalid flavor: " + value);
                }
                if(_flavor){
                    var oldFlavor:String = valueToCSS(_flavor);
                    toggle(oldFlavor, false);
                }
                if(value){
                    var newFlavor:String = valueToCSS(value);
                    toggle(newFlavor, true);
                }
                _flavor = value;
            }
        }
        private function valueToCSS(value:String):String{
            return "spectrum-CoachMarkIndicator--" + value;
        }
    }
}