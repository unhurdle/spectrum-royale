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
  // import com.unhurdle.spectrum.data.IMenuItem;

  public class Menu extends com.unhurdle.spectrum.List
  {
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
        // if(value[i] is IMenuItem){
        if(value[i] is MenuItem){
          /////
          (value[i] as MenuItem).disabled = value[i].disabled;
          (value[i] as MenuItem).isDivider = value[i].isDivider;
          (value[i] as MenuItem).isHeading = value[i].isHeading;
          (value[i] as MenuItem).isOpen = false;
          // (value[i] as MenuItem).label = value[i].label;
          (value[i] as MenuItem).subMenu = false;
          (value[i] as MenuItem).dataProvider = value[i].dataProvider;
          (value[i] as MenuItem).text = value[i].text;
          (value[i] as MenuItem).selected = value[i].selected;
          (value[i] as MenuItem).icon = value[i].icon;
          (value[i] as MenuItem).imageIcon = value[i].imageIcon;
          continue;
        }else if(value[i] is Menu){
          ////
          (value[i] as MenuItem).subMenu = true;
          (value[i] as MenuItem).text = "new sub menu";
          (value[i] as MenuItem).disabled = value[i].disabled;
          // (value[i] as MenuItem).isDivider = value[i].isDivider;
          // (value[i] as MenuItem).isHeading = value[i].isHeading;
          (value[i] as MenuItem).isOpen = value[i].isOpen;
          // (value[i] as MenuItem).label = value[i].label;
          (value[i] as MenuItem).selected = value[i].selected;
          (value[i] as MenuItem).icon = value[i].icon;
          (value[i] as MenuItem).imageIcon = value[i].imageIcon;
          continue;
        }else{
          var item:MenuItem = new MenuItem(getLabelFromData(this,value[i]));
          if(value[i].hasOwnProperty("selected")){
            item.selected = value[i]["selected"];
          }
          if(value[i].hasOwnProperty("isDivider")){
            item.isDivider = value[i]["isDivider"];
          }
          if(value[i].hasOwnProperty("isOpen")){
            item.isOpen = value[i]["isOpen"];
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
}