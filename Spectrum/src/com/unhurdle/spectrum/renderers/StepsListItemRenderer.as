package com.unhurdle.spectrum.renderers
{
  import org.apache.royale.html.supportClasses.DataItemRenderer;
  // import com.unhurdle.spectrum.data.SideNavItem;
  // import com.unhurdle.spectrum.TextNode;
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import org.apache.royale.html.util.getLabelFromData;
  import com.unhurdle.spectrum.StepsListItem;
  import com.unhurdle.spectrum.TextNode;
  import com.unhurdle.spectrum.newElement;
  public class StepsListItemRenderer extends DataItemRenderer
  {
    public function StepsListItemRenderer()
    {
      super();
      typeNames = '';
    }
  //   <div class="spectrum-Steplist-item u-tooltip-showOnHover is-complete">
  //   <div class="spectrum-Steplist-markerContainer">
  //     <div class="spectrum-Tooltip spectrum-Tooltip--top">
  //       <span class="spectrum-Tooltip-label">Step 1</span>
  //       <span class="spectrum-Tooltip-tip"></span>
  //     </div>
  //     <div class="spectrum-Steplist-marker">
  //     </div>
  //   </div>

  //   <span class="spectrum-Steplist-segment">
  //   </span>
  // </div>
    protected function appendSelector(value:String):String{
      return "spectrum-Steplist" + value;
    }
    override public function updateRenderer():void{
      // do nothing
    }

    override public function set data(value:Object):void{
      super.data = value;
      var elem:HTMLElement = element as HTMLElement;
      var stepsListItem:StepsListItem = value as StepsListItem;
      elem.className = appendSelector("-item");
      // elem.style.pointerEvents = null
      if(stepsListItem.selected){
        elem.classList.add("is-selected");
      } else {
        elem.classList.remove("is-selected");
      }
      if(stepsListItem.completed){
        elem.classList.add("is-complete");
      } else {
        elem.classList.remove("is-complete");
      }
      if(!!stepsListItem.text){
        var label:TextNode = new TextNode("");
        // label.element = newElement("span","spectrum-Steplist-label");
        // label.text = stepsListItem.text;
        // label.text = getLabelFromData(this,value);
        // elem.appendChild(label.element);
        if(!!stepsListItem.toolTip){
          elem.classList.add("u-tooltip-showOnHover");
          var toolTipDiv:HTMLDivElement = newElement("div","spectrum-Tooltip spectrum-Tooltip--top") as HTMLDivElement;
          label.element = newElement("span","spectrum-Tooltip-label");
          label.text = stepsListItem.text;
          toolTipDiv.appendChild(label.element);
          var toolTipSpan:HTMLSpanElement = newElement("span","spectrum-Tooltip-tip") as HTMLSpanElement;
          toolTipDiv.appendChild(toolTipSpan);
          markerContainer.insertBefore(toolTipDiv,marker);
        }
        else{
          label.element = newElement("span","spectrum-Steplist-label");
          label.text = stepsListItem.text;
          elem.insertBefore(label.element,markerContainer);      
        }
        // label.text = stepsListItem.text;
      //   elem.classList.remove("is-complete");
      }
      // if(!!stepsListItem.toolTip){
      //   label = new TextNode("");
      //   label.element = newElement("span","spectrum-Steplist-label");
      //   label.text = stepsListItem.text;
      //   // label.text = getLabelFromData(this,value);
      //   // elem.appendChild(label.element);
      //   elem.insertBefore(label.element,markerContainer || null);
      // }
      // else {
      //   if(!!stepsListItem.text){
      //     label = new TextNode("");
      //     label.element = newElement("span","spectrum-Steplist-label");
      //     label.text = stepsListItem.text;
      //     // label.text = getLabelFromData(this,value);
      //     // elem.appendChild(label.element);
      //     elem.insertBefore(label.element,markerContainer || null);
      //   }
      // //   elem.classList.remove("is-complete");
      // }
      // textNode.text = getLabelFromData(this,value);
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
    }
    private var markerContainer:HTMLSpanElement;
    private var marker:HTMLSpanElement;
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
      // elem.className = appendSelector("-item");
      markerContainer = document.createElement("span") as HTMLSpanElement;
      markerContainer.className = appendSelector("-markerContainer");
      marker = document.createElement("span") as HTMLSpanElement;
      marker.className = appendSelector("-marker");
      markerContainer.appendChild(marker);
      elem.appendChild(markerContainer);
      var segment:HTMLSpanElement = document.createElement("span") as HTMLSpanElement;
      segment.className = appendSelector("-segment");
      elem.appendChild(segment);
      return elem;
    }
  }
}