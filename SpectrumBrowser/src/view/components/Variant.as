package view.components
{
  import com.unhurdle.spectrum.FlexContainer;
  import com.unhurdle.spectrum.typography.Heading;
  import com.unhurdle.spectrum.typography.Body;
  import org.apache.royale.html.elements.Div;

  public class Variant extends FlexContainer
  {
    public function Variant()
    {
      super();
      typeNames = "variant-container";
      vertical = true;
      alignItems = "flex-start";
      headerElem = new Heading();
      headerElem.size = "L";
      headerElem.className = "variant-header";
      headerElem.text = "Standard"; 
      addElement(headerElem);
      var div:Div = new Div();
      div.className = "variant-header-padding";
      addElement(div);

    }
    private var headerElem:Heading;

    private var _header:String;

    public function get header():String
    {
    	return headerElem.text;
    }

    public function set header(value:String):void
    {
    	headerElem.text = value;
    }
    private var notesElem:Body;

    public function get notes():String
    {
    	return notesElem ? notesElem.text : "";
    }

    public function set notes(value:String):void
    {
      if(!notesElem && !value){
        return;
      }
      if(!notesElem){
        notesElem = new Body();
        headerElem.size = "XL";
        // notesElem.size = 4;
        addElementAt(notesElem,1);
      }
      notesElem.text = value || "";
     
    }
  }
}