package com.unhurdle.spectrum
{

  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }

  import com.unhurdle.spectrum.data.MenuItem;
  import org.apache.royale.html.util.getLabelFromData;
  import org.apache.royale.collections.IArrayList;
  import com.unhurdle.spectrum.data.IMenuItem;

  public class Menu extends List
  {
    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/menu/dist.css">
     * </inject_html>
     * 
     */
    public function Menu()
    {
      super();
    }

    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      return addElementToWrapper(this,'ul');
    }

    override public function set dataProvider(value:Object):void{
      if(value is Array){
        convertArray(value);
      } else if(value is IArrayList){
        convertArray(value.source);
      }
      super.dataProvider = value;
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

    private function convertArray(value:Object):void{
      var newVal:Array
      newVal = new Array(value.length);
      var len:int = value.length;
      for(var i:int = 0;i<len;i++){
        if(value[i] is IMenuItem){
          continue;
        }
        var item:MenuItem = new MenuItem(getLabelFromData(this,value[i]));
        if(value[i].hasOwnProperty("selected")){
          item.selected = value[i]["selected"];
        }
        if(value[i].hasOwnProperty("isDivider")){
          item.isDivider = value[i]["isDivider"];
        }
        if(value[i].hasOwnProperty("disabled")){
          item.disabled = value[i]["disabled"];
        }
        if(value[i].hasOwnProperty("isHeading")){
          item.isHeading = value[i]["isHeading"];
        }
        if(value[i].hasOwnProperty("icon")){
          item.icon = value[i]["icon"];
        }
        if(value[i].hasOwnProperty("subMenu")){
          item.subMenu = value[i]["subMenu"];
        }
        value[i] = item;
      }
    }
  }
}