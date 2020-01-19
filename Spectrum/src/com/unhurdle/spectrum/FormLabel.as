package com.unhurdle.spectrum
{
  import org.apache.royale.core.IParent;
  import org.apache.royale.core.IChild;

  public class FormLabel extends FieldLabel
  {
    public function FormLabel()
    {
      super();
      typeNames = "spectrum-Form-itemLabel";
    }
    override public function addedToParent():void{
      super.addedToParent();
      var curParent:IParent = parent;
      while(curParent){
        if(curParent is Form){
          var position:String = (curParent as Form).labelPosition;
          if(position){
            this.position = position;
          }
          break;
        }
        curParent = (curParent as IChild).parent;
      }
    }
  }
}