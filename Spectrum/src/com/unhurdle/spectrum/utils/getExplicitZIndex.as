package com.unhurdle.spectrum.utils{
		import com.unhurdle.spectrum.ISpectrumElement;

		public function getExplicitZIndex(component:ISpectrumElement):Number{
			COMPILE::JS{
				var elem:HTMLElement = component.element
				while(elem){
					if(elem.style.zIndex){
						return Number(elem.style.zIndex);
					}
					elem = elem.parentElement as HTMLElement;
				}
			}
			return 0;
		}
}