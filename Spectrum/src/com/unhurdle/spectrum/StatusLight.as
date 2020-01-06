package com.unhurdle.spectrum
{
  
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  public class StatusLight extends TextBase
  {
    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/statuslight/dist.css">
     * </inject_html>
     * 
     */

    public function StatusLight()
    {
      super();
    }
    override protected function getSelector():String{
        return "spectrum-StatusLight";
    }
    
    /**
     * The status can be either a <code>StatusColor</code> or <code>Status</code> specifier.
     * Default is <code>Status.NEUTRAL</code>.
     */
    private var _status:String;

    public function get status():String
    {
    	return _status;
    }

    public function set status(value:String):void
    {
      if(value != _status){
        if(_status){
          toggle(valueToSelector(_status), false);
        }
        if(!value){
          value = "neutral";
        }
        toggle(valueToSelector(value), true);

      	_status = value;
        
      }
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