package com.unhurdle.spectrum
{
  
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  public class StatusLight extends SpectrumBase
  {

    public function StatusLight()
    {
      super();
    }
    override protected function getSelector():String{
        return "spectrum-StatusLight";
    }
    
    /**
     * status and color are mutually exclusive.
     * The last setting wins.
     */
    public var status:String;
    public var color:String;

    private var _changeStatus:String;

    public function get changeStatus():String
    {
    	return _changeStatus;
    }

    public function set changeStatus(value:String):void
    {
    	if(value != _changeStatus){
                var newColor:String = valueToCSS(value);
                toggle(newColor, true);
                if(_changeStatus){
                    var oldColor:String = valueToCSS(_changeStatus);
                    toggle(oldColor, false);
                }
                _changeStatus = value;
            }
    }
        private function valueToCSS(value:String):String{
            return "spectrum-StatusLight--" + value;
        }
  }
}

/**
Colors:
<div class="spectrum-StatusLight spectrum-StatusLight--celery">Celery Status</div>
<div class="spectrum-StatusLight spectrum-StatusLight--yellow">Yellow Status</div>
<div class="spectrum-StatusLight spectrum-StatusLight--fuchsia">Fuchsia Status</div>
<div class="spectrum-StatusLight spectrum-StatusLight--indigo">Indigo Status</div>
<div class="spectrum-StatusLight spectrum-StatusLight--seafoam">Seafoam Status</div>
<div class="spectrum-StatusLight spectrum-StatusLight--chartreuse">Chartreuse Status</div>
<div class="spectrum-StatusLight spectrum-StatusLight--magenta">Magenta Status</div>
<div class="spectrum-StatusLight spectrum-StatusLight--purple">Purple Status</div>

Status:
<div class="spectrum-StatusLight spectrum-StatusLight--neutral">Paused</div>
<div class="spectrum-StatusLight spectrum-StatusLight--info">Active</div>
<div class="spectrum-StatusLight spectrum-StatusLight--positive">Approved</div>
<div class="spectrum-StatusLight spectrum-StatusLight--notice">Needs Approval</div>
<div class="spectrum-StatusLight spectrum-StatusLight--negative">Rejected</div>

<div class="spectrum-StatusLight is-disabled">Disabled</div>

 */