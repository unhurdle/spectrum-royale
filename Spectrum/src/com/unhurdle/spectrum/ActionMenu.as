package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  // import org.apache.royale.html.List;
  import com.unhurdle.spectrum.const.IconPrefix;
  import com.unhurdle.spectrum.const.IconSize;
  import org.apache.royale.events.MouseEvent;
  import com.unhurdle.spectrum.data.MenuItem;
  import org.apache.royale.html.util.getLabelFromData;
  import org.apache.royale.collections.IArrayList;
  import org.apache.royale.core.IPopUpHost;
  import org.apache.royale.utils.UIUtils;
  import org.apache.royale.geom.Point;
  import org.apache.royale.utils.PointUtils;
  import org.apache.royale.core.IStrand;
  import org.apache.royale.core.UIBase;
  import org.apache.royale.core.ValuesManager;
  import org.apache.royale.events.Event;

  [Event(name="change", type="org.apache.royale.events.Event")]
  public class ActionMenu extends SpectrumBase
  {
    public function ActionMenu()
    {
      super();
    }
    private var button:ActionButton;
    public var popover:Popover;
    public var menu:Menu;
 
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      
      var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
      button = new ActionButton();
      // button.className = //??
      button.icon = IconPrefix._18 + "More";
      button.iconSize = IconSize.S;
      button.addEventListener(MouseEvent.MOUSE_DOWN,toggleMenu);
      addElement(button);
      
      popover = new Popover();
      popover.position = "bottom";
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
     public function get dataProvider():Object{
      return menu.dataProvider;
    }
    public function set dataProvider(value:Object):void{
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

    public function get text():String
    {
    	return button.text;
    }

    public function set text(value:String):void
    {
      button.text = value;
    }
    private function toggleMenu():void{
      var shown:Boolean = popover.open;
			var popupHost:IPopUpHost = UIUtils.findPopUpHost(this);
      if(shown){// close it
				popupHost.popUpParent.removeElement(popover);

      } else {//open it
        var offset:Point = PointUtils.localToGlobal(new Point(),popupHost);
				var origin:Point = new Point(0, height - 6);
				var relocated:Point = PointUtils.localToGlobal(origin,this);
        relocated.x -= offset.x;
        relocated.y -= offset.y;
				popover.y = relocated.y+5;
        popover.x = relocated.x;
        if(_alignRight && popover.width>button.width){
          popover.x -= popover.width-button.width;
        }
				// popover.width = button.width;

				popupHost.popUpParent.addElement(popover);

      }
      popover.open = !popover.open;
      button.selected = popover.open;
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
  }
}