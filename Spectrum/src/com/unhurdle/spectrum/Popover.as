package com.unhurdle.spectrum
{
  import org.apache.royale.core.IPopUp;
  import org.apache.royale.events.Event;
  import org.apache.royale.core.IParent;
  import org.apache.royale.core.IPopUpHostParent;

  public class Popover extends Group implements IPopUp
  {
    /**
     * <inject_script>
     * var link = document.createElement("link"); 
     * link.setAttribute("rel", "stylesheet");
     * link.setAttribute("type", "text/css");
     * link.setAttribute("href", "assets/css/components/popover/dist.css");
     * document.head.appendSelector(link);
     * </inject_script>
     */
    public function Popover()
    {
      super();
      COMPILE::JS
      {
        element.style.zIndex = 500;// very high number to make sure it's above everything else
        element.style.position = "absolute";
      }

    }
    override protected function getSelector():String{
      return "spectrum-Popover";
    }
    private var _floating:Boolean;

    public function get floating():Boolean
    {
    	return _floating;
    }

    public function set floating(value:Boolean):void
    {
    	_floating = value;
    }
    private var _open:Boolean;

    public function get open():Boolean
    {
    	return _open;
    }

    public function set open(value:Boolean):void
    {
      if(!!_open != value){
        _open = value;
        toggle("is-open",value);
        if(floating){
          var host:IPopUpHostParent = Application.current.popUpParent;
          if(value){
            host.addElement(this);
          } else {
            host.removeElement(this);
          }
        }
        dispatchEvent(new Event("openChanged"));
      }
    }
    private var _quiet:Boolean;

    public function get quiet():Boolean
    {
    	return _quiet;
    }

    public function set quiet(value:Boolean):void
    {
    	_quiet = value;
      toggle(valueToSelector("quiet"),value);
    }

    private var _relativePosition:Boolean;

    public function get relativePosition():Boolean
    {
    	return _relativePosition;
    }

    public function set relativePosition(value:Boolean):void
    {
      if(value != !!_relativePosition){
      	_relativePosition = value;
        COMPILE::JS
        {
          if(value){
            element.style.position = "relative";
          } else {
            element.style.position = null;
          }
        }
      }
    }

    private var _dialog:Boolean;

    public function get dialog():Boolean
    {
    	return _dialog;
    }

    public function set dialog(value:Boolean):void
    {
      if(value != !!_dialog){
      	_dialog = value;
        toggle(valueToSelector("dialog"),value);
        COMPILE::JS
        {
          if(value){          
            var tip:HTMLDivElement = newElement("div",appendSelector("-tip")) as HTMLDivElement;
            element.appendChild(tip);
          }else{
            if(element.contains(tip)){
              element.removeChild(tip);
            }
          }
        }
      }
    }

    // private var _tip:Boolean;

    // public function get tip():Boolean
    // {
    // 	return _tip;
    // }

    // public function set tip(value:Boolean):void
    // {
    //   if(value != !!_tip){
    //   	_tip = value;
    //     // toggle(valueToSelector("tip"),value);
    //     COMPILE::JS
    //     {
    //       if(value){          
    //         var tip:HTMLDivElement = newElement("div",valueToSelector("tip")) as HTMLDivElement;
    //         element.appendChild(tip);
    //       }else{
    //         if(element.contains(tip)){
    //           element.removeChild(tip);
    //         }
    //       }
    //     }
    //   }
    // }
    private var _error:Boolean;

    public function get dialogError():Boolean
    {
    	return _error;
    }

    public function set dialogError(value:Boolean):void
    {
      if(value != !!_error){
      	_error = value;
        toggle("spectrum-Dialog--error",value);
      }
    }

    private var _success:Boolean;

    public function get dialogSuccess():Boolean
    {
    	return _success;
    }

    public function set dialogSuccess(value:Boolean):void
    {
      if(value != !!_success){
      	_success = value;
        toggle("spectrum-Dialog--success",value);
      }
    }

    private var _top:Boolean;

    public function get top():Boolean
    {
    	return _top;
    }

    public function set top(value:Boolean):void
    {
      if(value != !!_top){
      	_top = value;
        toggle(valueToSelector("top"),value);
      }
    }

    private var _position:String;

    public function get position():String
    {
    	return _position;
    }

    public function set position(value:String):void
    {
      if(value != _position){
        if(!value){
          value = "bottom";
        }
        switch(value)
        {
          case "bottom":
          case "top":
          case "right":
          case "left":
            break;
        
          default:
            throw new Error("invalid position: " + value);
            
        }
        if(_position){
          toggle(valueToSelector(_position),false);
        }
        toggle(valueToSelector(value),true);
      	_position = value;
      }
    }

  }
}
