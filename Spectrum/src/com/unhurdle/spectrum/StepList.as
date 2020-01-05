package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import org.apache.royale.html.List;
  import org.apache.royale.collections.IArrayList;

  public class StepList extends org.apache.royale.html.List{
    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/steplist/dist.css">
     * </inject_html>
     * 
     */
    public function StepList()
    {
      super();
      height = 50;
      typeNames = getSelector();
    }
    private function getSelector():String{
        return "spectrum-Steplist";
    }
    COMPILE::JS
		override protected function createElement():WrappedHTMLElement{
			return addElementToWrapper(this,'div');
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
        if(value[i] is StepsListItem){
          if(!!isLabel || !!isToolTip){
            (value[i] as StepsListItem).text = "Step " + (i+1);
          }
          (value[i] as StepsListItem).toolTip = isToolTip;
          continue;
        } else {
          var item:StepsListItem;
          if(!!isLabel || !!isToolTip){
           item = new StepsListItem("Step " + (i+1));
          }
          else{
            item = new StepsListItem("");
          }
          // var item:StepsListItem = new StepsListItem();
          if(value[i].hasOwnProperty("selected")){
            item.selected = value[i]["selected"];
          }
          if(value[i].hasOwnProperty("completed")){
            item.completed = value[i]["completed"];
          }
          item.toolTip = isToolTip;
          // if(isLabel()){
          //   item.text = "Step" + i;
          // }
          value[i] = item;
        }
      }
    }
    private var _isSmall:Boolean;
    public function get isSmall():Boolean
    {
    	return _isSmall;
    }
    public function set isSmall(value:Boolean):void
    {
      if(value != !!_isSmall){
        if(value){
          className = getSelector() + "--small";
        }
        else{
          className = "";
        }
      }
    	_isSmall = value;
    }
    private var _isLabel:Boolean;
    public function get isLabel():Boolean
    {
    	return _isLabel;
    }
    public function set isLabel(value:Boolean):void
    {
      // if(value != !!_isLabel){
      //   if(value){
      //     className = getSelector() + "--small";
      //   }
      //   else{
      //     className = "";
      //   }
      // }
    	_isLabel = value;
    }
    private var _isToolTip:Boolean;
    public function get isToolTip():Boolean
    {
    	return _isToolTip;
    }
    public function set isToolTip(value:Boolean):void
    {
    	_isToolTip = value;
    }
  }
}