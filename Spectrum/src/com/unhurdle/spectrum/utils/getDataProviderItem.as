package com.unhurdle.spectrum.utils
{
  import org.apache.royale.collections.ICollection;

  public function getDataProviderItem(provider:Object,index:int):Object
  {
    if(provider is Array)
      return provider[index];
      
    return (provider as ICollection).getItemAt(index);
  }
}