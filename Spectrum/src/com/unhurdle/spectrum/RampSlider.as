package com.unhurdle.spectrum
{
  COMPILE::JS{
        import org.apache.royale.html.util.addElementToWrapper;
        import org.apache.royale.core.WrappedHTMLElement;
    }
    COMPILE::SWF
  public class RampSlider extends Slider{}
  
  COMPILE::JS
  public class RampSlider extends Slider
  {
    public function RampSlider()
    {
      super();
      typeNames = "spectrum-Slider spectrum-Slider--ramp";
    }
    override protected function createElement():WrappedHTMLElement{
            var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
            var labelContainer:HTMLDivElement = newElement("div") as HTMLDivElement;
            labelContainer.className = "spectrum-Slider-labelContainer";
            var label:HTMLLabelElement = newElement("label") as HTMLLabelElement;
            label.className = "spectrum-Slider-label";
            label.id = "my-spectrum-Slider-label3";
            label.setAttribute("for","my-spectrum-Slider-input3");
            labelContainer.appendChild(label);
            var inputValue:HTMLDivElement = newElement("div") as HTMLDivElement;
            inputValue.className = "spectrum-Slider-value";
            inputValue.setAttribute("role","textbox");
            inputValue.setAttribute("aria-readonly",true);
            inputValue.setAttribute("aria-labelledby","my-spectrum-Slider-label3");
            labelContainer.appendChild(inputValue);
            elem.appendChild(labelContainer);
            var controls:HTMLDivElement = newElement("div") as HTMLDivElement;
            controls.className = "spectrum-Slider-controls";
            var ramp:HTMLDivElement = newElement("div") as HTMLDivElement;
            ramp.className = "spectrum-Slider-ramp";
            var svgElement:SVGElement = document.createElementNS('http://www.w3.org/2000/svg', 'svg') as SVGElement;
            var pathElement:SVGPathElement = document.createElementNS('http://www.w3.org/2000/svg', 'path') as SVGPathElement;
            pathElement.setAttribute("d","M240,4v8c0,2.3-1.9,4.1-4.2,4L1,9C0.4,9,0,8.5,0,8c0-0.5,0.4-1,1-1l234.8-7C238.1-0.1,240,1.7,240,4z");
            svgElement.setAttribute("focusable",false);
            svgElement.setAttribute("viewBox","0 0 240 16");
            svgElement.setAttribute("preserveAspectRatio","none");
            svgElement.setAttribute("aria-hidden",true);
            svgElement.appendChild(pathElement);
            ramp.appendChild(svgElement);
            controls.appendChild(ramp);
            var handle:HTMLDivElement = newElement("div") as HTMLDivElement;
            handle.className = "spectrum-Slider-handle";
            handle.style.left = "40%"
            var input:HTMLInputElement = newElement("input") as HTMLInputElement;
            input.className = "spectrum-Slider-input";
            input.id = "my-spectrum-Slider-input3";
            input.type = "range";
            input.value = "14";
            input.min = "10";
            input.max = "20";
            input.step = "2";
            handle.appendChild(input);
            controls.appendChild(handle);
            elem.appendChild(controls);
            return elem;
    }
  }
}