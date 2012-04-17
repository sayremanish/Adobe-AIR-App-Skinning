package org.storybot.controller.bootstrap
{
	
	import org.robotlegs.core.IMediatorMap;
	import org.storybot.view.DragDropAreaView;
	import org.storybot.view.DragDropAreaViewMediator;
	
	public class BootstrapViewMediators
	{
		public function BootstrapViewMediators(mediatorMap:IMediatorMap)
		{
			// map the mediatorView
			mediatorMap.mapView(DragDropAreaView, DragDropAreaViewMediator);
		}
	}
}