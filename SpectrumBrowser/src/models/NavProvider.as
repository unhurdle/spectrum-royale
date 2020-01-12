package models
{
  import com.unhurdle.spectrum.data.SideNavItem;

  public class NavProvider extends SideNavItem
  {
    public function NavProvider(name:String,reference:Class)
    {
      this.text = name;
      this.reference = reference;
    }
    public var reference:Class;
  }
}