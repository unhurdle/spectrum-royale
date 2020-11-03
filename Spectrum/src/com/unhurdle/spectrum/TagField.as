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
      typeNames = "spectrum-Textfield-input";
    }
    
    private var input:TextField;
    private var tagGroup:TagGroup;

    public function get tags():Array
    {
    	return tagGroup.tags;
    }
    
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
      input.input.style.borderStyle = "none";
      input.input.style.background = "none";
      elem.appendChild(input.element);
      return elem;
    }

    override public function addedToParent():void{
      super.addedToParent();
      calculatePosition();
    }

    /**
     * @royaleignorecoercion com.unhurdle.spectrum.Tag
     */
    private var picker:Picker;
    private var valuesArr:Array = [];
    private var ind:Number = 0;
    private function selectValue(ev:Event):void{
      var type:String = ev.type;
      if(valuesArr.length && valuesArr.length > 1){
        var len:int = valuesArr.length;
        for(var index:int = 0; index < len; index++)
        {
          var t:String = valuesArr[index];
          if(t.indexOf(input.text) == 0){
            switch(type)
            {
              case "onArrowDown":
                ind = index + 1;
                break;
              case "onArrowUp":
                ind = index - 1;
                break;
            }
            break;
          }
        }
        if(ind == -1){
          ind = valuesArr.length - 1;
        }else if(ind == valuesArr.length){
          ind = 0;
        }
        input.text = valuesArr[ind];
      }
    }
    private function updateValue():void{
      var arr:Array = [];
      valuesArr = [];
      if(input.text){
        valuesArr.push(input.text);
        var len:int = tagList.length;
        for(var index:int = 0; index < len; index++)
        {
          var t:String = tagList[index];
          if(t.indexOf(input.text) == 0){
            arr.push(t);
            valuesArr.push(t);
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
      calculatePosition();
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
      calculatePosition();
    }

    private function calculatePosition():void {
      if(tagGroup.height > input.height){
        if(width - tagGroup.width < input.width){
          height = tagGroup.height + 50;
        } else{
          height = tagGroup.height + 30;
        }
      }else{
        height = input.height + 30;
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
          input.addEventListener("onArrowDown",selectValue);
          input.addEventListener("onArrowUp",selectValue);
          input.element.addEventListener("input",updateValue);
        }
      }else{
        picker = null;
        COMPILE::JS{
          removeElement(picker);
          input.removeEventListener("onArrowDown",selectValue);
          input.removeEventListener("onArrowUp",selectValue);
          input.element.removeEventListener("input",updateValue);
        }
      }
    }

    private function removeTag():void{
      if(!input.text && tagGroup.numElements){
        var tag:Tag = tagGroup.getElementAt(tagGroup.numElements-1) as Tag;
        tagGroup.removeElement(tag);
      }
      calculatePosition();
    }
  }
}