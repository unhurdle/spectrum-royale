package com.unhurdle.spectrum
{
  COMPILE::JS {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
    }

  
  public class Calender extends SpectrumBase
  {
    public function Calender()
    {
      super();
    }

    override protected function getSelector():String{
      return "spectrum-Calendar";
    }


    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
    addElementToWrapper(this,'div');
    //header 
    var header:HTMLElement = newElement('div');
    var title:HTMLElement = newElement('div');
    title.className = "";
    title.setAttribute("role","heading");
    // title.text //month and year -- needs //default start in on today -- set min and max date 
    //use :Date send it month and year 
    header.appendChild(title);
    var prev:HTMLElement = newElement('button');
    prev.className = "spectrum-ActionButton spectrum-ActionButton--quiet spectrum-Calendar-prevMonth";
    var prevIcon:Icon = new Icon("#spectrum-css-icon-CornerTriangle");
    prevIcon.className = "spectrum-Icon spectrum-UIIcon-ChevronLeftLarge";
    prev.appendChild(prevIcon.element);
    header.appendChild(prev);
    var next:HTMLElement = newElement('button');
    next.className = "spectrum-ActionButton spectrum-ActionButton--quiet spectrum-Calendar-nextMonth";
    var nextIcon:Icon = new Icon("#spectrum-css-icon-ChevronRightLarge");
    nextIcon.className = "spectrum-Icon spectrum-UIIcon-ChevronRightLarge";
    next.appendChild(nextIcon.element);
    header.appendChild(next);
    element.appendChild(header);
    //header

    //body

    //  <div class="spectrum-Calendar-body" role="grid" tabindex="0" aria-readonly="true" aria-disabled="false">
  //    <table role="presentation" class="spectrum-Calendar-table">
  //       <thead role="presentation">
  //          <tr role="row">
  //             <th role="columnheader" scope="col" class="spectrum-Calendar-tableCell"><abbr class="spectrum-Calendar-dayOfWeek" title="Sunday">Su</abbr></th>
  //             <th role="columnheader" scope="col" class="spectrum-Calendar-tableCell"><abbr class="spectrum-Calendar-dayOfWeek" title="Monday">Mo</abbr></th>
  //             <th role="columnheader" scope="col" class="spectrum-Calendar-tableCell"><abbr class="spectrum-Calendar-dayOfWeek" title="Tuesday">Tu</abbr></th>
  //             <th role="columnheader" scope="col" class="spectrum-Calendar-tableCell"><abbr class="spectrum-Calendar-dayOfWeek" title="Wednesday">We</abbr></th>
  //             <th role="columnheader" scope="col" class="spectrum-Calendar-tableCell"><abbr class="spectrum-Calendar-dayOfWeek" title="Thursday">Th</abbr></th>
  //             <th role="columnheader" scope="col" class="spectrum-Calendar-tableCell"><abbr class="spectrum-Calendar-dayOfWeek" title="Friday">Fr</abbr></th>
  //             <th role="columnheader" scope="col" class="spectrum-Calendar-tableCell"><abbr class="spectrum-Calendar-dayOfWeek" title="Saturday">Sa</abbr></th>
  //          </tr>
  //only half
    var body:HTMLElement = newElement('div');
    body.className = "spectrum-Calendar-body";
    body.setAttribute("role","grid");
    body.tabIndex = 0;

    var table:HTMLElement = newElement('table');
    table.className = "spectrum-Calendar-table";
    table.setAttribute("role","presentation");
    
    var tHead:HTMLElement = newElement('thead');
    tHead.setAttribute("role","presentation");

    var tr:HTMLElement = newElement('tr');
    tr.setAttribute("role","row");

    var th:HTMLElement = newElement('th'); //loop for 7 
    th.className = "spectrum-Calendar-tableCell";
    th.setAttribute("role","columnheader");
    th.setAttribute("scope","col");
    
    

    



    return element
    }







  }
}