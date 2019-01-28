package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import org.apache.royale.html.List;
  import org.apache.royale.collections.IArrayList;

  public class TreeViewNested extends org.apache.royale.html.List{
    public function TreeViewNested()
    {
      super();
      width = 250;
      typeNames = getSelector();
    }
    private function getSelector():String{
      return "spectrum-TreeView";
    }
    COMPILE::JS
		override protected function createElement():WrappedHTMLElement{
			var elem:WrappedHTMLElement = addElementToWrapper(this,'ul');
      return elem;
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
        if(value[i] is TreeViewNestedItem){
           (value[i] as TreeViewNestedItem).isList = false;
           (value[i] as TreeViewNestedItem).text = "Layer " + (i+1);
           (value[i] as TreeViewNestedItem).href = value[i].href;
          (value[i] as TreeViewNestedItem).dataProvider = value[i].dataProvider;
          continue;
        } else if(value[i] is TreeViewNested){
          value[i].text = "Group ??";
          (value[i] as TreeViewNestedItem).isList = true;
          value[i].href? (value[i] as TreeViewNestedItem).href = value[i].href: (value[i] as TreeViewNestedItem).href = "";
          continue;
        } else {
          var item:TreeViewNestedItem;
          if(value[i].length == 1){
           item = new TreeViewNestedItem("Layer " + (i+1));
          }
          else{
            item = new TreeViewNestedItem("Group ??");
            for (var c:int = 1; c < value[i].length; c++){
              convertArray(value[i][c]);
            }
          }
          if(value[i].hasOwnProperty("opened")){
            item.opened = value[i]["opened"];
          }
          
          if(value[i].hasOwnProperty("isList")){
            item.isList = value[i]["isList"];
          }
          item.href = value[i].href;
          value[i] = item;
        }
      }
    }
    private var _text:String;
    public function get text():String
    {
    	return _text;
    }
    public function set text(value:String):void
    {
    	_text = value;
    }
  }
}