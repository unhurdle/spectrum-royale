package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }
  // import org.apache.royale.html.List;
  import com.unhurdle.spectrum.const.IconPrefix;
  import com.unhurdle.spectrum.const.IconSize;
  import com.unhurdle.spectrum.data.MenuItem;

  import org.apache.royale.collections.IArrayList;
  import org.apache.royale.core.IParentIUIBase;
  import org.apache.royale.core.IPopUpHost;
  import org.apache.royale.events.Event;
  import org.apache.royale.events.MouseEvent;
  import org.apache.royale.geom.Point;
  import org.apache.royale.html.util.getLabelFromData;
  import org.apache.royale.utils.PointUtils;
  import org.apache.royale.utils.UIUtils;

  [Event(name="change", type="org.apache.royale.events.Event")]
  [Event(name="beforeShow", type="org.apache.royale.events.Event")]
  public class ActionMenu extends ActionButton
  {
    public static const BEFORE_SHOW:String = "beforeShow";
    public static var _openMenu:ActionMenu;
    public function ActionMenu()
    {
      super();
    }
    public var popover:Popover;
 
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      
      var elem:WrappedHTMLElement = super.createElement();
      // button.className = //??
      icon = IconPrefix._18 + "More";
      addEventListener(MouseEvent.MOUSE_DOWN,toggleMenu);
      
      popover = new Popover();
      popover.element.style.position = "absolute";
      popover.position = "bottom";
      popover.addEventListener("openChanged",handlePopoverChange);
	    // var origin:Point = new Point(0, host.height - 6);
			// var relocated:Point = PointUtils.localToGlobal(origin,host);
			// popover.x = relocated.x
			// popover.y = relocated.y;
      // var popupHost:IPopUpHost = UIUtils.findPopUpHost(host);
     // popupHost.popUpParent.addElement(popover);

      menu = new Menu();
      menu.addEventListener("change",handleMenuChange);
      popover.addElement(menu);
      // addElement(popover);
      return elem;
    }

     override public function get dataProvider():Object{
      return menu.dataProvider;
    }

    override public function set dataProvider(value:Object):void{
      if(value is Array){
        convertArray(value);
      } else if(value is IArrayList){
        convertArray(value.source);
      }
      menu.dataProvider = value;
    }
    private function convertArray(value:Object):void{
      var len:int = value.length;
      for(var i:int = 0;i<len;i++){
        if(value[i] is MenuItem){
          continue;
        }

        var item:MenuItem = new MenuItem(getLabelFromData(this,value[i]));
        value[i] = item;
      }
    }

    private function toggleMenu():void{
      if(_openMenu && _openMenu != this){
        _openMenu.close();
      }
      var shown:Boolean = popover.open;
      if(shown){// close it
        close();

      } else {//open it
        dispatchEvent(new Event("beforeShow"));
  			var popupHost:IPopUpHost = UIUtils.findPopUpHost(this);
				popupHost.popUpParent.addElement(popover);
        var offset:Point = PointUtils.localToGlobal(new Point(),popupHost);
				var origin:Point = new Point(0, height - 6);
				var relocated:Point = PointUtils.localToGlobal(origin,this);
        relocated.x -= offset.x;
        relocated.y -= offset.y;
				popover.y = determinePosition(relocated.y);
        popover.x = relocated.x;
        if(_alignRight && popover.width>width){
          popover.x -= popover.width-width;
        }
				// popover.width = button.width;
        
        popover.open = selected = true;
        _openMenu = this;
      }
    }
    private function close():void{
      popover.open = selected = false;
      _openMenu = null;
    }
    private function handlePopoverChange(ev:Event):void{
      if(!popover.open)
      {
  			var popupHost:IPopUpHost = UIUtils.findPopUpHost(this);
        popupHost.popUpParent.removeElement(popover);
        selected = false;
      }
    }
    private var _alignRight:Boolean;

		public function get alignRight():Boolean
		{
			return _alignRight;
		}

		public function set alignRight(value:Boolean):void
		{
			_alignRight = value;
     
      // menu.alignRight = value;
		}

    private function handleMenuChange():void
    {
      dispatchEvent(new Event("change"));
    }
    public function determinePosition(ptY:Number):Number
		{
			var screenHeight:Number = (UIUtils.findPopUpHost(this).popUpParent as IParentIUIBase).height;
      var h:Number = popover.height;
			if(ptY + h > screenHeight){
			  ptY -= (h + 25);
        popover.position = "top";
			}
      else{
        ptY += 5;
        popover.position = "bottom";
      }
      return ptY;
		}
  }
}