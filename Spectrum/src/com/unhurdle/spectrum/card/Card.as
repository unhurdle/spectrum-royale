package com.unhurdle.spectrum.card
{
  import com.unhurdle.spectrum.SpectrumBase;
  import com.unhurdle.spectrum.Asset;
  import com.unhurdle.spectrum.QuickActions;
  import org.apache.royale.html.elements.Div;
  import org.apache.royale.core.IPopUpHost;
  import org.apache.royale.core.IPopUpHostParent;

  public class Card extends SpectrumBase implements IPopUpHost, IPopUpHostParent
  {
    public function Card()
    {
      super();
    }
    private var _quiet:Boolean;

    public function get quiet():Boolean
    {
    	return _quiet;
    }

    public function set quiet(value:Boolean):void
    {
      if(value != !!_quiet){
        toggle(valueToSelector("quiet"),value);
      }
    	_quiet = value;
    }
    private var _small:Boolean;

    public function get small():Boolean
    {
    	return _small;
    }

    public function set small(value:Boolean):void
    {
      if(value != !!_small){
        toggle(valueToSelector("small"),value);
      }
    	_small = value;
    }
    private var _gallery:Boolean;

    public function get gallery():Boolean
    {
    	return _gallery;
    }

    public function set gallery(value:Boolean):void
    {
      if(value != !!_gallery){
        toggle(valueToSelector("gallery"),value);
      }
    	_gallery = value;
    }

    private var coverPhoto:CoverPhoto;
    private var _coverSrc:String;

    public function get coverSrc():String
    {
    	return _coverSrc;
    }

    public function set coverSrc(value:String):void
    {
      if(value != _coverSrc){
        //CoverPhoto always at the very beginning
        if(coverPhoto){
          coverPhoto.src = value;
        } else {
          coverPhoto = new CoverPhoto(value);
          addElementAt(coverPhoto,0);
        }
      }
    	_coverSrc = value;
    }
    private var previewDiv:Div;
    private var _preview:Asset;

    public function get preview():Asset
    {
    	return _preview;
    }

    public function set preview(value:Asset):void
    {
      if(value == _preview){
        return;
      }

      if(!previewDiv){
        // preview is either first or after the cover photo
        var index:int = 0;
        if(coverPhoto){
          index = 1;
        }
        previewDiv = new Div();
        previewDiv.className = appendSelector("-preview");
        addElement(previewDiv);
      }
      while(previewDiv.numElements > 0){
        previewDiv.removeElement(previewDiv.getElementAt(0));
      }
      previewDiv.addElement(value);
    	_preview = value;
    }
    private var _body:CardBody;

    public function get body():CardBody
    {
    	return _body;
    }

    public function set body(value:CardBody):void
    {
      if(value != _body){
        if(_body){
          removeElement(_body);
        }
        var index:int = 0;
        if(coverPhoto){
          index++;
        }
        if(previewDiv){
          index++;
        }
        addElementAt(value,index);

        _body = value;
      }
    }

    // The order of actions and quickActions does not matter
    private var _actions:QuickActions;

    public function get actions():QuickActions
    {
    	return _actions;
    }

    public function set actions(value:QuickActions):void
    {
      if(value != _actions){
        if(_actions){
          removeElement(_actions);
        }
        addElement(value);
      	_actions = value;
      }
    }
    private var _quickActions:QuickActions;

    public function get quickActions():QuickActions
    {
    	return _quickActions;
    }

    public function set quickActions(value:QuickActions):void
    {
      if(value != _quickActions){
        if(_quickActions){
          removeElement(_quickActions);
        }
        addElement(value);
      	_quickActions = value;
      }
    }

    override protected function getSelector():String{
      return getCardSelector();
    }
    public function get popUpParent():IPopUpHostParent
    {
        return this;
    }
    
    public function get popUpHost():IPopUpHost
    {
        return this;
    }

  }
}