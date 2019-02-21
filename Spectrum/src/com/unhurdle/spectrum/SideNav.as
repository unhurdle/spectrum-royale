package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import org.apache.royale.html.List;
  import org.apache.royale.collections.IArrayList;
  import com.unhurdle.spectrum.data.SideNavItem;
  import org.apache.royale.html.util.getLabelFromData;

  public class SideNav extends org.apache.royale.html.List implements ISideNav
  {
    public function SideNav()
    {
      super();
      typeNames = "";
      (element as HTMLElement).className = "spectrum-SideNav";
    }
    
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      return addElementToWrapper(this,'ul');
    }

		private var _labelField:String = "label";
		
		/**
		 * The name of the field within the data to use as a label. Some itemRenderers use this field to
		 * identify the value they should show while other itemRenderers ignore this if they are showing
		 * complex information.
		 */
		override public function get labelField():String
		{
			return _labelField;
		}
		override public function set labelField(value:String):void
		{
			_labelField = value;
		}

    override public function set dataProvider(value:Object):void{
      if(value is Array){
        convertArray(value);
      } else if(value is IArrayList){
        convertArray(value.source);
      }
      super.dataProvider = value;
    }
    private function convertArray(value:Object):void{
      var newVal:Array
      newVal = new Array(value.length);
      var len:int = value.length;
      for(var i:int = 0;i<len;i++){
        if(value[i] is SideNavItem){
          (value[i] as SideNavItem).isList = false;
          (value[i] as SideNavItem).text = value[i].text;
          (value[i] as SideNavItem).color = value[i].color;
          (value[i] as SideNavItem).isHeading = value[i].isHeading;
          (value[i] as SideNavItem).href = value[i].href;
          (value[i] as SideNavItem).selected = value[i].selected;
          (value[i] as SideNavItem).dataProvider = value[i].dataProvider;
          (value[i] as SideNavItem).disabled = value[i].disabled;
          (value[i] as SideNavItem).height = itemsHeight;
          continue;
        } else if(value[i] is SideNav){
          (value[i] as SideNav).multiLevel = (value[i] as SideNav).multiLevel;
          (value[i] as SideNavItem).isList = true;
          // (value[i] as SideNavItem).text = "new sideNav";
          // (value[i] as SideNavItem).href = value[i].href;
          (value[i] as SideNavItem).color = value[i].color;
          (value[i] as SideNavItem).text =  value[i].text;
          (value[i] as SideNavItem).isHeading = value[i].isHeading;
          // (value[i] as SideNavItem).href = value[i].href;
          (value[i] as SideNavItem).height = itemsHeight;

          (value[i] as SideNavItem).disabled = value[i].disabled;
          continue;
        } else {
          var item:SideNavItem = new SideNavItem(getLabelFromData(this,value[i]));
          if(value[i].hasOwnProperty("selected")){
            item.selected = value[i]["selected"];
          }
          if(value[i].hasOwnProperty("disabled")){
            item.disabled = value[i]["disabled"];
          }
          if(value[i].hasOwnProperty("isHeading")){
            item.isHeading = value[i]["isHeading"];
          }
          if(value[i].hasOwnProperty("isList")){
            item.isList = value[i]["isList"];
          }
          if(value[i].hasOwnProperty("color")){
            item.color = value[i]["color"];
          }
          value[i] = item;
        }
      }
    }
  
    private var _itemsHeight:String;
    public function get itemsHeight():String{
        return _itemsHeight;
    }
     public function set itemsHeight(value:String):void{
        _itemsHeight = value;
    }
    private var _color:String;
    public function get color():String{
        return _color;
    }
     public function set color(value:String):void{
        _color = value;
    }
    private var _text:String;
    public function get text():String{
   
        return _text;
    }
    public function set text(value:String):void{
        _text = value;
    }
    public function get label():String{
      return _text;
    } 
    private var _disabled:Boolean;

    public function get disabled():Boolean{
    	return _disabled;
    }

    public function set disabled(value:Boolean):void{
    	_disabled = value;
    }
    private var _multiLevel:Boolean;

		public function get multiLevel():Boolean{
			return _multiLevel;
		}

		public function set multiLevel(value:Boolean):void{
			if(value != !!_multiLevel){
        COMPILE::JS
        {
          !!value? element.classList.add("spectrum-SideNav--multiLevel"):element.classList.remove("spectrum-SideNav--multiLevel");
          var elementClassList:String = "";
          for(var i:int = 0; i < element.classList.length; i++){
            elementClassList += element.classList[i] + " ";
            
          }
          className = elementClassList;
        }
      }
			_multiLevel = value;
		}
    private var _isHeading:Boolean;
    public function get isHeading():Boolean{
        return _isHeading;
    }
    public function set isHeading(value:Boolean):void{
        _isHeading = value;
    }

  }
}