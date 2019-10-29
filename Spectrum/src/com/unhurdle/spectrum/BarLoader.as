package com.unhurdle.spectrum
{
    
    COMPILE::JS{
        import org.apache.royale.html.util.addElementToWrapper;
        import org.apache.royale.core.WrappedHTMLElement;
    }

    public class BarLoader extends SpectrumBase
    {
        public function BarLoader()
        {
            super();
        }
        override protected function getSelector():String{
          return "spectrum-BarLoader";
        }

        private var _label:String;

        public function get label():String
        {
        	return _label;
        }

        public function set label(value:String):void
        {
        	_label = value;
            labelNode.text = value;
        }

        private var _max:Number = 100;

        public function get max():Number
        {
        	return _max;
        }

        public function set max(value:Number):void
        {
        	_max = value;
            if(_value){
                calculatePosition();
            }
        }

        private var _min:Number = 0;

        public function get min():Number
        {
        	return _min;
        }

        public function set min(value:Number):void
        {
        	_min = value;
            if(_value){
                calculatePosition();
            }
        }

        private var _value:Number = 0;

        public function get value():Number
        {
        	return _value;
        }

        public function set value(value:Number):void
        {
        	_value = value;
            calculatePosition();
        }
        private var _valueSuffix:String = "%";

        public function get valueSuffix():String
        {
        	return _valueSuffix;
        }

        public function set valueSuffix(value:String):void
        {
        	_valueSuffix = value;
        }
        override public function addedToParent():void{
            super.addedToParent();
            calculatePosition();
        }
        private function calculatePosition():void{
            if(!parent){
                return;
            }
            if(value){
                var total:Number = _max - _min;
                var percent:Number = value / total * 100;
            } else {
                percent = 0;
            }
            if(_meter){
                if(percent < _warningThreshold){
                    setColor("is-positive");
                } else if(percent < _criticalThreshold){
                    setColor("is-warning");
                } else {
                    setColor("is-critical");
                }
            } else {
                // set it to the default
                setColor("");
            }
            var percentStr:String = percent + "%";
            valueNode.text = value + _valueSuffix;
            COMPILE::JS
            {
                fill.style.width = percentStr;
                element.setAttribute("value",percent);
                element.setAttribute("aria-valuenow",percent);
                element.setAttribute("aria-valuemin",min);
                element.setAttribute("aria-valuemax",max);
            }
        }

        private var fill:HTMLElement;

        private var valueNode:TextNode;

        private var labelNode:TextNode;

        COMPILE::JS
        override protected function createElement():WrappedHTMLElement{
            var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
            elem.setAttribute("role","progressbar");
            
            var baseSelector:String = getSelector();
            labelNode = new TextNode("div");
            labelNode.className = baseSelector + "-label";
            elem.appendChild(labelNode.element);
            valueNode = new TextNode("div");
            valueNode.className = baseSelector + "-percentage";
            elem.appendChild(valueNode.element);

            var track:HTMLElement = newElement("div");
            track.className = baseSelector + "-track";
            fill = newElement("div");
            fill.className = baseSelector + "-fill";
            fill.style.width = value;
            track.appendChild(fill);
            elem.appendChild(track);

            return elem;
        }

        private var _meter:Boolean;

        public function get meter():Boolean
        {
        	return _meter;
        }

        public function set meter(value:Boolean):void
        {
        	_meter = value;
        }

        private var _warningThreshold:Number = 80;

        public function get warningThreshold():Number
        {
        	return _warningThreshold;
        }

        public function set warningThreshold(value:Number):void
        {
        	_warningThreshold = value;
        }

        private var _criticalThreshold:Number = 90;

        public function get criticalThreshold():Number
        {
        	return _criticalThreshold;
        }

        public function set criticalThreshold(value:Number):void
        {
        	_criticalThreshold = value;
        }

        private var _color:String;


        private function setColor(value:String):void
        {
            if(value != _color){
                if(_color){
                    toggle(_color, false);
                }
                if(value){
                    toggle(value, true);
                }
                _color = value;
            }
        }
        private var _sideLabel:Boolean;

        public function get sideLabel():Boolean
        {
            return _sideLabel;
        }

        public function set sideLabel(value:Boolean):void
        {
            if(value != !!_sideLabel){
                toggle(valueToSelector("sideLabel"),value);
            }
            _sideLabel = value;
        }
        private var _small:Boolean;

        public function get small():Boolean
        {
            return _small;
        }

        public function set small(value:Boolean):void
        {
            if(value != !!_small){
                toggle(valueToSelector("small"),value);
            }
            _small = value;
        }
        private var _overBackground:Boolean;

        public function get overBackground():Boolean
        {
            return overBackground;
        }

        public function set overBackground(value:Boolean):void
        {
            if(value != !!_overBackground){
                toggle(valueToSelector("overBackground"),value);
            }
            _overBackground = value;
        }
        public function showPercentage(value:Boolean):void
        {
            if(value){
                valueNode.element.style.display = "inherit";
            }
            else{
                valueNode.element.style.display = "none";
            }
        }
        // private var _indeterminate:Boolean;

        // public function get indeterminate():Boolean
        // {
        //     return _indeterminate;
        // }

        // public function set indeterminate(value:Boolean):void
        // {
        //     if(value){
        //         // set the bar to defaults
        //         setColor("");
        //         percentNode.text = "";
        //         fill.style.width = "";
        //     } else {
        //         calculatePosition();
        //     }
        //     if(value != !!_indeterminate){
        //         toggle(valueToSelector("indeterminate"),value);
        //     }
        //     _indeterminate = value;
        // }

/**
 * spectrum-BarLoader--overBackground
 * is-positive
 * is-warning
 * is-critical
 * 
<div style="width: 200px; height: 25px; padding-top: 10px;">
  <div class="spectrum-BarLoader spectrum-BarLoader--small" value="50" role="progressbar" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100">
    <div class="spectrum-BarLoader-track">
      <div class="spectrum-BarLoader-fill" style="width: 50%;"></div>
    </div>
    <div class="spectrum-BarLoader-label" hidden=""></div>
  </div>
</div>
<div style="margin: 20px 0;">
  <div class="spectrum-BarLoader spectrum-BarLoader--small" value="50" role="progressbar" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100">
    <div class="spectrum-BarLoader-label">Loading</div>
    <div class="spectrum-BarLoader-percentage">50%</div>
    <div class="spectrum-BarLoader-track">
      <div class="spectrum-BarLoader-fill" style="width: 50%;"></div>
    </div>
  </div>
</div>
<div style="margin: 50px 0;">
  <div class="spectrum-BarLoader spectrum-BarLoader--small spectrum-BarLoader--sideLabel" value="50" role="progressbar" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100">
    <div class="spectrum-BarLoader-label">Loading</div>
    <div class="spectrum-BarLoader-percentage">50%</div>
    <div class="spectrum-BarLoader-track">
      <div class="spectrum-BarLoader-fill" style="width: 50%;"></div>
    </div>
  </div>
</div>
 */

    }
}