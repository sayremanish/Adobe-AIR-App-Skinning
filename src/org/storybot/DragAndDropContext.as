package org.storybot
{
	
	import org.robotlegs.mvcs.Context;
	
	import org.storybot.controller.bootstrap.BootstrapViewMediators;
	import org.storybot.controller.bootstrap.BootstrapClasses;
	import org.storybot.controller.bootstrap.BootstrapCommands;
	import org.storybot.controller.bootstrap.BootstrapConfigValues;
	import org.storybot.controller.bootstrap.BootstrapModels;
	import org.storybot.controller.bootstrap.BootstrapServices;
	
	public class DragAndDropContext extends Context
	{
		override public function startup():void
		{
			// map views to mediator
			//mediatorMap.mapView(StatusGroup, StatusGroupMediator);
			new BootstrapConfigValues(injector);
			new BootstrapModels(injector);
			new BootstrapServices(injector);
			new BootstrapCommands(commandMap);
			new BootstrapClasses(injector);
			new BootstrapViewMediators(mediatorMap);
			
			// and we're done
			super.startup();

		}

	}
}