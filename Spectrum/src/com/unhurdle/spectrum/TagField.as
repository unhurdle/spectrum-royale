package com.unhurdle.spectrum
{
  COMPILE::JS {
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }
  import org.apache.royale.events.FocusEvent;

  public class TagField extends Group
  {
    public function TagField()
    {
      super();
      style = "background-color:rgb(255,255,255);border-style:solid;border-width:1px";
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
      input.input.style.borderStyle = "none";
      elem.appendChild(input.element);
      return elem;
    }
    /**
     * @royaleignorecoercion com.unhurdle.spectrum.Tag
     */
    private function addTag():void{
      if(input.text){
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

    private function removeTag():void{
      if(!input.text && tagGroup.numElements){
        tagGroup.removeElement(tagGroup.getElementAt(tagGroup.numElements-1));
      }
    }
  }
}