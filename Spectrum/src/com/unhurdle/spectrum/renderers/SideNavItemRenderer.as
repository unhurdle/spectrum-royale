package com.unhurdle.spectrum.renderers
{
  import org.apache.royale.html.supportClasses.DataItemRenderer;
  import com.unhurdle.spectrum.data.SideNavItem;
  import com.unhurdle.spectrum.TextNode;
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import org.apache.royale.html.util.getLabelFromData;
  import com.unhurdle.spectrum.Toast;
  import com.unhurdle.spectrum.SideNav;
  import goog.events.Event;
  import com.unhurdle.spectrum.CheckBox;

  public class SideNavItemRenderer extends DataItemRenderer
  {
    public function SideNavItemRenderer()
    {
      super();
      // typeNames = '';
    }
    protected function appendSelector(value:String):String{
      return "spectrum-SideNav" + value;
    }
    override public function updateRenderer():void{
      // do nothing
    }

    override public function set data(value:Object):void{
      super.data = value;
      var elem:HTMLElement = element as HTMLElement;
      var sideNavItem:SideNavItem = value as SideNavItem;
      elem.className = null;
      elem.style.pointerEvents = null
      if(sideNavItem.isHeading){
        textNode.className = appendSelector("-heading");
        elem.style.pointerEvents = "none";
      } else {
        elem.className = appendSelector("-item");
        textNode.element.setAttribute("href",sideNavItem.href || "#");
      }
      isList = !!sideNavItem.isList;
      if(isList){
        textNode.text = sideNavItem.text;
        var ul:SideNav = new SideNav();
        ul.withCheckBox = (sideNavItem as SideNav).withCheckBox;
        ul.dataProvider = sideNavItem.dataProvider;
        ul.multiLevel = (sideNavItem as SideNav).multiLevel;
        addElement(ul);
      }else{
        textNode.text = getLabelFromData(this,value);
      }
      elem.addEventListener("click",sideNavClick);
      if(sideNavItem.disabled){
        elem.classList.add("is-disabled");
        elem.style.pointerEvents = "none";
      }
      if(sideNavItem.withCheckBox){
        ch = new CheckBox();
        // ch.className = "spectrum-AssetList-itemSelector";
        // ch.className = "spectrum-Checkbox spectrum-AssetList-itemSelector";
        ch.checked = sideNavItem.checked;
        ch.style = {"width": "15px","float": "left"};
        addElementAt(ch,0);
        // addElement(ch);
        // elem.appendChild(ch.element as HTMLElement);
      }
      if(sideNavItem.selected){
        elem.classList.add("is-selected");
      }
      if(!!sideNavItem.height){
        elem.style.height = sideNavItem.height;
      }
      if(!!sideNavItem.color){
        textNode.element.style.color = sideNavItem.color;
      }
      else{
        textNode.element.style.color = "black";
      }

    }
    override public function set selected(value:Boolean):void{
      super.selected = value;
      COMPILE::JS
      {
        if(value){
          element.classList.add("is-selected");
        } else {
          element.classList.remove("is-selected");
        }
      }
      // if(ch){
      //   ch.checked = value;
      // }
    }
    
    private function sideNavClick(event:Event):void{
        var styleStr:String;
         var el:HTMLElement = event.target.closest('.spectrum-SideNav');
        if(el != null && !el.classList.contains("is-selected")){
          event.stopPropagation();
          var array:Array;
          var ch:Boolean;
          if(event.currentTarget.childElementCount == 3){
            event.currentTarget.children[0].classList.toggle("is-indeterminate",false);
            ch = event.currentTarget.children[0].children[0].checked;
            // if(event.currentTarget.children[0].children[0].checked){
            //   var array:Array = event.currentTarget.children[2].children;
            //   for(var index:int = 0; index < array.length; index++){
            //     array[index].children[0].children[0].checked = true;                
            //   }
            // }
            // else{
            // }
              array = event.currentTarget.children[2].children;
              for(var index:int = 0; index < array.length; index++){
                array[index].children[0].children[0].checked = ch;                
              }
          }
          else{
            var count:Number = 0;
            array = event.currentTarget.parentNode.parentElement.children[2].children;
            for(var ind:int = 0; ind < array.length; ind++){
              count += array[ind].children[0].children[0].checked;                
            }
            ch = event.currentTarget.children[0].children[0].checked;
            if(0 < count && count < array.length){
              event.currentTarget.parentNode.parentElement.children[0].classList.toggle("is-indeterminate",true);
              if(event.currentTarget.parentNode.parentElement.children[0].children[0].checked && !ch){
                event.currentTarget.parentNode.parentElement.children[0].children[0].checked = false;
              }
            }else{
              event.currentTarget.parentNode.parentElement.children[0].classList.toggle("is-indeterminate",false);
              event.currentTarget.parentNode.parentElement.children[0].children[0].checked = ch;
            }
            // switch(count)
            // {
            //   case 0:event.currentTarget.parentNode.parentElement.children[0].classList.toggle("is-indeterminate",false);
            //     break;
            
            //   default:
            //     break;
            // }
            //       if(event.currentTarget.parentNode.parentElement.children[0].children[0].checked){
            //         event.currentTarget.parentNode.parentElement.children[0].children[0].checked == false;
            //       }
            // if(!count){
            //   event.currentTarget.parentNode.parentElement.children[0].classList.toggle("is-indeterminate",false);
            //   if(event.currentTarget.parentNode.parentElement.children[0].children[0].checked){
            //     event.currentTarget.parentNode.parentElement.children[0].children[0].checked == false;
            //   }
            // }
            // else{
            //   if(count == array.length){
            //     event.currentTarget.parentNode.parentElement.children[0].classList.toggle("is-indeterminate",false);

            //   }
            //   else{
            //     event.currentTarget.parentNode.parentElement.children[0].classList.toggle("is-indeterminate",true);
            //   }
            // }
            // if(count>0){
            //   if(count == array.length){
				    //     event.currentTarget.parentNode.parentElement.children[0].classList.toggle("is-indeterminate",false);
            //     event.currentTarget.parentNode.parentElement.children[0].children[0].checked == true;
            //   }
            //   else{
            //     event.currentTarget.parentNode.parentElement.children[0].children[0].checked == false;
            //   }
            // }
          	// if(count > 0 && !ch){
				    //   event.currentTarget.parentNode.parentElement.children[0].classList.toggle("is-indeterminate",true);
					  // }
            // else{
            //   event.currentTarget.parentNode.parentElement.children[0].classList.toggle("is-indeterminate",false);
            //   if(event.currentTarget.parentNode.parentElement.children[0].children[0].checked){
            //     event.currentTarget.parentNode.parentElement.children[0].children[0].checked == false;
            //     event.currentTarget.parentNode.parentElement.children[0].classList.toggle("is-indeterminate",true);
            //   }
            // }
          }
        // // if(el != null && !el.classList.contains("is-selected")){
        //   event.stopPropagation();
        //   new Toast("The selected item is: "+event.target.text).show();
        }
      }

    private var textNode:TextNode;
    public var ch:CheckBox;
    private var isList:Boolean;
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
      textNode = new TextNode("a");
      textNode.className = appendSelector("-itemLink");
      textNode.element.style.userSelect = "none";
      textNode.element.style.width = "auto";
      elem.appendChild(textNode.element);
      return elem;
    }
  }
}