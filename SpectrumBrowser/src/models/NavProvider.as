package models
{
  import com.unhurdle.spectrum.data.MenuItem;

  public class NavProvider extends MenuItem
  {
    public function NavProvider(name:String,reference:Class,hashLink:String)
    {
      this.text = name;
      this.reference = reference;
      this.hashLink = hashLink;
    }
    public var reference:Class;
    public var hashLink:String
  }
}