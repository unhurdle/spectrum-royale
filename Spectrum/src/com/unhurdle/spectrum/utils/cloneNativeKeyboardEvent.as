package com.unhurdle.spectrum.utils
{
    import org.apache.royale.utils.BrowserInfo;

    public function cloneNativeKeyboardEvent(event:Object):Object{
      var newEvent:Object;
      var options:KeyboardEventInit = {
        altKey: event.altKey,
        bubbles: event.bubbles,
        cancelBubble: event.cancelBubble,
        cancelable: event.cancelable,
        charCode: event.charCode,
        code: event.code,
        composed: event.composed,
        ctrlKey: event.ctrlKey,
        detail: event.detail,
        isComposing: event.isComposing,
        key: event.key,
        keyCode: event.keyCode,
        location: event.location,
        metaKey: event.metaKey,
        repeat: event.repeat,
        returnValue: event.returnValue,
        shiftKey: event.shiftKey,
        which: event.which
      } as KeyboardEventInit;
      if(BrowserInfo.current().engine == "Trident"){
        // special handling for IE
        newEvent = document.createEvent("KeyboardEvent");
        var modifierList:String = "";
        if(options.shiftKey){
          modifierList += "Shift ";
        }
        if(options.ctrlKey){
          modifierList += "Control ";
        }
        if(options.altKey){
          modifierList += "Alt ";
        }
        if(options.metaKey){
          modifierList += "Meta ";
        }
        newEvent.initKeyboardEvent(event.type, options.cancelable, options.bubbles, window, options.code, options.key, undefined, modifierList, options.repeat);
      } else {
        newEvent = new KeyboardEvent(event.type,options);
      }
      return newEvent;
    }
}