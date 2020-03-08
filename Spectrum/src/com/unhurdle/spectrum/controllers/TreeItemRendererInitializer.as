package com.unhurdle.spectrum.controllers
{	
    
    import org.apache.royale.collections.TreeData;
    import org.apache.royale.core.Bead;
    import org.apache.royale.core.IDataProviderModel;
    import org.apache.royale.core.IIndexedItemRenderer;
    import org.apache.royale.core.IIndexedItemRendererInitializer;
    import org.apache.royale.core.IItemRenderer;
    import org.apache.royale.core.IItemRendererOwnerView;
    import org.apache.royale.core.IListDataItemRenderer;
    import org.apache.royale.core.IStrand;
    import org.apache.royale.core.IUIBase;
    import org.apache.royale.core.SimpleCSSStyles;
    import org.apache.royale.core.UIBase;
    import org.apache.royale.html.supportClasses.TreeListData;
    import org.apache.royale.html.beads.IndexedItemRendererInitializer;
    
	/**
	 *  The TreeItemRendererInitializer class initializes item renderers
     *  in tree classes.
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion Royale 0.0
	 */
	public class TreeItemRendererInitializer extends IndexedItemRendererInitializer
	{
		/**
		 *  constructor.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.0
		 */
		public function TreeItemRendererInitializer()
		{
		}
				
		/**
		 *  @private
		 *  @royaleignorecoercion org.apache.royale.core.HTMLElementWrapper
		 */
		override public function initializeIndexedItemRenderer(ir:IIndexedItemRenderer, data:Object, index:int):void
		{
            if (!dataProviderModel)
                return;
            
            super.initializeIndexedItemRenderer(ir, data, index);
            
            var treeData:TreeData = dataProviderModel.dataProvider as TreeData;
            var depth:int = treeData.getDepth(data);
            var isOpen:Boolean = treeData.isOpen(data);
            var hasChildren:Boolean = treeData.hasChildren(data);
            
            // Set the listData with the depth of this item
            var treeListData:TreeListData = new TreeListData();
            treeListData.depth = depth;
            treeListData.isOpen = isOpen;
            treeListData.hasChildren = hasChildren;
            
            (ir as IListDataItemRenderer).listData = treeListData;
            
        }
        
	}
}
