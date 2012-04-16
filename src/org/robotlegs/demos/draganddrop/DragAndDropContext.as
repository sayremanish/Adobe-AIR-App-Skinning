package org.robotlegs.demos.draganddrop
{
	
	import org.robotlegs.mvcs.Context;
	
	import org.robotlegs.demos.draganddrop.controller.bootstrap.BootstrapViewMediators;
	import org.robotlegs.demos.draganddrop.controller.bootstrap.BootstrapClasses;
	import org.robotlegs.demos.draganddrop.controller.bootstrap.BootstrapCommands;
	import org.robotlegs.demos.draganddrop.controller.bootstrap.BootstrapConfigValues;
	import org.robotlegs.demos.draganddrop.controller.bootstrap.BootstrapModels;
	import org.robotlegs.demos.draganddrop.controller.bootstrap.BootstrapServices;
	
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