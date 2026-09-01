package com.unhurdle.spectrum.utils
{
  import com.unhurdle.spectrum.Application;

  public class OutsidePointerTracker
  {
    public function OutsidePointerTracker(elements:Array, outsideHandler:Function)
    {
      this.elements = elements;
      this.outsideHandler = outsideHandler;
    }

    private var elements:Array;
    private var outsideHandler:Function;
    private var tracking:Boolean;

    public function start():void
    {
      COMPILE::JS
      {
        if(tracking){
          return;
        }
        tracking = true;
        if(Application.current.usePointerEvents){
          document.addEventListener("pointerdown", handlePointerDown, true);
        } else {
          Application.current.initialView.topMostEventDispatcher.addEventListener("mousedown", handleMouseDown, true);
        }
      }
    }

    public function stop():void
    {
      COMPILE::JS
      {
        if(!tracking){
          return;
        }
        tracking = false;
        if(Application.current.usePointerEvents){
          document.removeEventListener("pointerdown", handlePointerDown, true);
        } else {
          Application.current.initialView.topMostEventDispatcher.removeEventListener("mousedown", handleMouseDown, true);
        }
      }
    }

    COMPILE::JS
    private function handlePointerDown(event:PointerEvent):void
    {
      if(!event.isPrimary || event.button != 0){
        return;
      }
      handleDown(event);
    }

    COMPILE::JS
    private function handleMouseDown(event:Event):void
    {
      if(event is MouseEvent && event.button != 0){
        return;
      }
      handleDown(event);
    }

    COMPILE::JS
    private function handleDown(event:Event):void
    {
      var target:Node = event.target as Node;
      for each(var element:HTMLElement in elements){
        if(element && target is Node && element.contains(target)){
          return;
        }
      }
      stop();
      outsideHandler();
    }
  }
}