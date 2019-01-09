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

  public class SideNav extends org.apache.royale.html.List
  {
    public function SideNav()
    {
      super();
      typeNames = "spectrum-SideNav";
    }
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      return addElementToWrapper(this,'div');
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
          value[i] = item;
        }
      }
    }
  }
}