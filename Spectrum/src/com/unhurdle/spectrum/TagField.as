package com.unhurdle.spectrum
{
  COMPILE::JS {
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }
  import org.apache.royale.events.FocusEvent;
  import org.apache.royale.utils.PointUtils;
  import org.apache.royale.geom.Point;
  import org.apache.royale.events.Event;

  public class TagField extends Group
  {
    public function TagField()
    {
      super();
      style = "border-style:solid;border-width:1px";
      tagList = ["123","456","789","120","465","7890123456","89"];
    }
    
    private var input:TextField;
    private var tagGroup:TagGroup;
    
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
      tagGroup = new TagGroup();
      tagGroup.setStyle("display","inline");
      elem.appendChild(tagGroup.element);
      input = new TextField();
      input.setStyle("display","inline-block");
      input.addEventListener("onBackspace",removeTag);
      input.addEventListener("onEnter",addTag);
      input.element.addEventListener(FocusEvent.FOCUS_OUT,addTag);
      input.element.addEventListener("input",updateValue);
      input.input.style.borderStyle = "none";
      input.input.style.background = "none";
      elem.appendChild(input.element);
      return elem;
    }
    /**
     * @royaleignorecoercion com.unhurdle.spectrum.Tag
     */
    private var picker:Picker;
    private function updateValue(ev:Event):void{
      var arr:Array = [];
      if(input.text){
        var len:int = tagList.length;
        for(var index:int = 0; index < len; index++)
        {
          var t:String = tagList[index];
          if(t.indexOf(input.text) == 0){
            arr.push(t);
          }
        }
      }
      if(picker){
        picker.dataProvider = arr;
        if(!!arr.length){
          picker.popover.open = true;
          positionPopup();
        }else{
          picker.popover.open = false;
        }
      }
    }
    protected function positionPopup():void{
      var origin:Point = new Point(input.x, height);
      var relocated:Point = PointUtils.localToGlobal(origin,this);
      picker.popover.x = relocated.x
      picker.popover.y = relocated.y;
    }
    private function addTag():void{
      if(input.text){
        if(picker){
          picker.popover.open = false;
        }
        var len:int = tagGroup.numElements;
        for(var index:int = 0; index < len; index++)
        {
          var element:Tag = tagGroup.getElementAt(index) as Tag;
          if(element.text == input.text){
            element.setStyle("visibility","hidden");
            input.text = "";
            setTimeout(function():void{
              element.setStyle("visibility","visible");
            },100);
            return;
          }
        }
        var tag:Tag = new Tag();
        tag.deletable = true;
        tag.text = input.text;
        input.text = "";
        tagGroup.addElement(tag);
      }
    }

    private var _tagList:Array;

    public function get tagList():Array{
    	return _tagList;
    }

    public function set tagList(value:Array):void{
    	_tagList = value;
      if(value){
        picker = new Picker();
        picker.button.visible = false;
        picker.width = 0;
        COMPILE::JS{
          addElement(picker);
        }
      }else{
        picker = null;
        COMPILE::JS{
          removeElement(picker);
        }
      }
    }

    private function removeTag():void{
      if(!input.text && tagGroup.numElements){
        tagGroup.removeElement(tagGroup.getElementAt(tagGroup.numElements-1));
      }
    }
  }
}