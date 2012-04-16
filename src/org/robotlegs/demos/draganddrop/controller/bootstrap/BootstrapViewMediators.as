package org.robotlegs.demos.draganddrop.controller.bootstrap
{
	
	import org.robotlegs.core.IMediatorMap;
	import org.robotlegs.demos.draganddrop.view.DragDropAreaView;
	import org.robotlegs.demos.draganddrop.view.DragDropAreaViewMediator;
	
	public class BootstrapViewMediators
	{
		public function BootstrapViewMediators(mediatorMap:IMediatorMap)
		{
			// map the mediatorView
			mediatorMap.mapView(DragDropAreaView, DragDropAreaViewMediator);
		}
	}
}