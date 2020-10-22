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
    }
    
    private var input:TextField;
    private var tagGroup:TagGroup;
    
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
      tagGroup = new TagGroup();
      elem.appendChild(tagGroup.element);
      input = new TextField();
      input.addEventListener("onBackspace",removeTag);
      input.addEventListener("onEnter",addTag);
      input.element.addEventListener(FocusEvent.FOCUS_OUT,addTag);
      input.style = {"display":"none"};
      elem.appendChild(input.element);
      return elem;
    }
    
    private function addTag():void{
      if(input.text){
        var tag:Tag = new Tag();
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