package view.components
{
  import com.unhurdle.spectrum.TypographyGroup;
  import com.unhurdle.spectrum.typography.Heading;

  public class Markup extends TypographyGroup
  {
    public function Markup()
    {
      super();
      typeNames = "markup-section";
      var headerElem:Heading = new Heading();
      headerElem.size = "L";
      headerElem.className = "markup-header";
      headerElem.text = "Markup"; 
      addElement(headerElem);
    }
  }
}