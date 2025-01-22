package com.unhurdle.spectrum
{
  COMPILE::JS {
    import org.apache.royale.core.WrappedHTMLElement;
  }

  import com.unhurdle.spectrum.Icon;

  public class InlineAlert extends SpectrumBase {

    public function InlineAlert() {
      super();
    }

    override protected function getSelector():String {
      return "spectrum-Alert";
    }

    private var _closeText:String;

    public function get closeText():String {
      return _closeText;
    }

    public function set closeText(value:String):void {
      if (value != _closeText) {
        setCloseButton(value);
      }
      _closeText = value;
    }

    private var _header:String;

    public function get header():String {
      return _header;
    }

    public function set header(value:String):void {
      headerNode.text = value;
      _header = value;
    }

    private var _content:String;

    public function get content():String {
      return _content;
    }

    public function set content(value:String):void {
      contentNode.text = value;
      _content = value;
    }

    private var headerNode:TextNode;

    private var contentNode:TextNode;

    private var button:Button;

    private var icon:Icon;

    private function createIcon(status:String):void {
      var type:String;

      switch (status) {
        case InlineAlert.ERROR:
          type = "Alert";
          break;
        case InlineAlert.HELP:
          type = "Help";
          break;
        case InlineAlert.INFO:
          type = "Info";
          break;
        case InlineAlert.SUCCESS:
          type = "Success";
          break;
        case InlineAlert.WARNING:
          type = "Alert";
          break;
        default:
          type = "Alert";
      }
      var sizedType:String = type + "Medium";
      var iconClass:String = appendSelector("-icon");
      var selector:String = Icon.getCSSTypeSelector(sizedType);
      if (icon) {
        icon.type = sizedType;
        icon.className = iconClass;
        icon.selector = selector;
      }
      else {
        icon = new Icon(selector);
        icon.type = sizedType;
        icon.className = iconClass;
        addElementAt(icon, 0);
      }
    }
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement {
      var elem:WrappedHTMLElement = super.createElement();
      headerNode = new TextNode("div");
      headerNode.className = appendSelector("-header");
      elem.appendChild(headerNode.element);

      contentNode = new TextNode("div");
      contentNode.className = appendSelector("-content");
      contentNode.element.style.whiteSpace = "pre-wrap";
      elem.appendChild(contentNode.element);

      return elem;
    }

    private function setCloseButton(value:String):void {
      COMPILE::JS
      {
        if (!button) {
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

    public function show():void {
      visible = true;
    }

    public function hide():void {
      visible = false;
    }

    public static const ERROR:String = "error";
    public static const HELP:String = "help";
    public static const INFO:String = "info";
    public static const SUCCESS:String = "success";
    public static const WARNING:String = "warning";

    private var _status:String;

    public function get status():String {
      return _status;
    }

    [Inspectable(category="General", enumeration="error,help,info,success,warning")]
    public function set status(value:String):void {
      // TODO can status be none?
      if (value != _status) {
        switch (value) {
          case InlineAlert.ERROR:
          case InlineAlert.HELP:
          case InlineAlert.INFO:
          case InlineAlert.SUCCESS:
          case InlineAlert.WARNING:
            break;
          default:
            throw new Error("Invalid status: " + value);
        }
        if (_status) {
          toggle(valueToSelector(_status), false);
        }
        toggle(valueToSelector(value), true);
        COMPILE::JS {
          createIcon(value);
        }
      }
      _status = value;
    }
  }
}
