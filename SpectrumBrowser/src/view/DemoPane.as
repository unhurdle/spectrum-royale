package view
{
  import com.unhurdle.spectrum.typography.Display;
  import com.unhurdle.spectrum.typography.Heading;
  import org.apache.royale.html.Spacer;
  import com.unhurdle.spectrum.typography.Body;
  import com.unhurdle.spectrum.Container;
  import com.unhurdle.spectrum.Group;
  import com.unhurdle.spectrum.typography.Article;
  import com.unhurdle.spectrum.Divider;

  public class DemoPane extends Container
  {
    public function DemoPane()
    {
      super();
      typeNames = 'pane-container';
      addElement(new ThemePicker());
      addVariants();
    }
    private function addVariants():void{
      var group:Group = new Group();
      var heading:Heading = new Heading();
      heading.size = 3;
      heading.text = "Variants";
      group.addElement(heading);
      var divider:Divider = new Divider();
      divider.size = "large";
      group.addElement(divider);
      addElement(group);
    }
    private var titleElem:Display;
    private var _title:String;
    public function get title():String{
    	return _title;
    }
    public function set title(value:String):void{
      if(!titleElem){
        var article:Article = new Article();
        article.setStyle("paddingBottom","33px");
        titleElem = new Display();
        article.addElement(titleElem);
        addElementAt(article,1);
      }
    	_title = value;
      titleElem.text = value;
    }
    private var notesGroup:Group;
    private var _notes:String;
    public function get notes():String{
    	return _notes;
    }

    public function set notes(value:String):void{
      if(value){
        if(!notesGroup){
          _notesBody = new Body();
          _notesBody.size = 3;
          wrapNotesBody();
        }
          _notesBody.text = value;
      }else if(notesGroup){
        removeNotesGroup();
      }
    	_notes = value;
    }
    private function removeNotesGroup():void{
        removeElement(notesGroup);
        notesGroup = null;
    }
    private function wrapNotesBody():void{
      title = title;
      notesGroup = new Group();
      var notesHeading:Heading = new Heading();
      notesHeading.size = 3;
      notesHeading.text = "Usage notes";
      notesGroup.addElement(notesHeading);
      var divider:Divider = new Divider();
      divider.size = "large";
      notesGroup.addElement(divider);
      var spacer:Spacer = new Spacer();
      spacer.height = 33;
      notesGroup.addElement(spacer);
      notesGroup.addElement(_notesBody);
      spacer = new Spacer();
      spacer.height = 33;
      notesGroup.addElement(spacer);
      addElementAt(notesGroup,2);
      
    }
    private var _notesBody:Body;

    public function get notesBody():Body
    {
    	return _notesBody;
    }

    public function set notesBody(value:Body):void
    {
    	_notesBody = value;
      if(value){
        wrapNotesBody();
      } else {
        removeNotesGroup();
      }
    }

  }
}