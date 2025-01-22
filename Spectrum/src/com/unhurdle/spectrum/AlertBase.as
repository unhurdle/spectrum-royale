package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
  }

  import com.unhurdle.spectrum.Icon;

  import org.apache.royale.events.KeyboardEvent;
  import org.apache.royale.events.utils.UIKeys;

  public class AlertBase extends SpectrumBase
  {

    public function AlertBase()
    {
      super();
    }

    override protected function getSelector():String
    {
      return "spectrum-Alert";
    }

    private function handleKeyDown(event:KeyboardEvent):void
    {
      if (event.key == UIKeys.ESCAPE)
      {
        hide();
      }
    }
    private var _noDismiss:Boolean;

    public function get noDismiss():Boolean
    {
      return _noDismiss;
    }

    public function set noDismiss(value:Boolean):void
    {
      _noDismiss = value;
      if (_overlayBead)
      {
        _overlayBead.hideOnClick = !value;
      }
    }

    private var _showOverlay:Boolean;

    public function get showOverlay():Boolean
    {
      return _showOverlay;
    }

    public function set showOverlay(value:Boolean):void
    {
      if (value)
      {
        getOverlayBead();
      }
      else if (_overlayBead)
      {
        removeBead(_overlayBead);
      }
      _showOverlay = value;
    }

    private function getOverlayBead():Underlay
    {
      if (!_overlayBead)
      {
        _overlayBead = new Underlay();
        addBead(_overlayBead);
      }
      _overlayBead.hideOnClick = !_noDismiss;
      return _overlayBead;
    }
    private var _overlayBead:Underlay;

    private var _closeText:String;

    public function get closeText():String
    {
      return _closeText;
    }

    public function set closeText(value:String):void
    {
      if (value != _closeText)
      {
        setCloseButton(value);
      }
      _closeText = value;
    }

    private var _header:String;

    public function get header():String
    {
      return _header;
    }

    public function set header(value:String):void
    {
      headerNode.text = value;
      _header = value;
    }

    private var _content:String;

    public function get content():String
    {
      return _content;
    }

    public function set content(value:String):void
    {
      contentNode.text = value;
      _content = value;
    }

    private var headerNode:TextNode;

    private var contentNode:TextNode;

    private var button:Button;

    private var icon:Icon;

    private function createIcon(status:String):void
    {
      var type:String;

      switch (status)
      {
        case AlertBase.ERROR:
          type = "Alert";
          break;
        case AlertBase.HELP:
          type = "Help";
          break;
        case AlertBase.INFO:
          type = "Info";
          break;
        case AlertBase.SUCCESS:
          type = "Success";
          break;
        case AlertBase.WARNING:
          type = "Alert";
          break;
        default:
          type = "Alert";
      }
      var sizedType:String = type + "Medium";
      var iconClass:String = appendSelector("-icon");
      var selector:String = Icon.getCSSTypeSelector(sizedType);
      if (icon)
      {
        icon.type = sizedType;
        icon.className = iconClass;
        icon.selector = selector;
      }
      else
      {
        icon = new Icon(selector);
        icon.type = sizedType;
        icon.className = iconClass;
        addElementAt(icon, 0);
      }
    }
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      var elem:WrappedHTMLElement = super.createElement();
      var styleStr:String = "z-index:100;";
      elem.setAttribute("style", styleStr);
      headerNode = new TextNode("div");
      headerNode.className = appendSelector("-header");
      elem.appendChild(headerNode.element);

      contentNode = new TextNode("div");
      contentNode.className = appendSelector("-content");
      contentNode.element.style.whiteSpace = "pre-wrap";
      elem.appendChild(contentNode.element);

      return elem;
    }

    private function setCloseButton(value:String):void
    {
      COMPILE::JS
      {
        if (!button)
        {
          var footer:HTMLElement = newElement('div');
          footer.className = appendSelector("-footer");
          button = new Button();
          button.quiet = true;
          button.element.onclick = hide;
          footer.appendChild(button.element);
          element.appendChild(footer);
        }
        button.text = value;
      }
    }

    public function show():void
    {
      visible = true;
      window.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
    }

    public function hide():void
    {
      window.removeEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
      visible = false;
    }

    public static const ERROR:String = "error";
    public static const HELP:String = "help";
    public static const INFO:String = "info";
    public static const SUCCESS:String = "success";
    public static const WARNING:String = "warning";

    private var _status:String;

    public function get status():String
    {
      return _status;
    }

    [Inspectable(category="General", enumeration="error,help,info,success,warning")]
    public function set status(value:String):void
    {
      // TODO can status be none?
      if (value != _status)
      {
        switch (value)
        {
          case AlertBase.ERROR:
          case AlertBase.HELP:
          case AlertBase.INFO:
          case AlertBase.SUCCESS:
          case AlertBase.WARNING:
            break;
          default:
            throw new Error("Invalid status: " + value);
        }
        if (_status)
        {
          toggle(valueToSelector(_status), false);
        }
        toggle(valueToSelector(value), true);
        COMPILE::JS
        {
          createIcon(value);
        }
      }
      _status = value;
    }
  }
}
