package view.components
{
  import com.unhurdle.spectrum.typography.Code;

  public class StyledCode extends Code
  {
    public function StyledCode()
    {
      super();
      size = "XS";
      setStyle("whiteSpace","break-spaces");
    }
  }
}