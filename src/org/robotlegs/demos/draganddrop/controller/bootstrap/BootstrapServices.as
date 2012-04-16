package org.robotlegs.demos.draganddrop.controller.bootstrap
{
	
	import org.robotlegs.core.IInjector;
	
	import org.robotlegs.demos.draganddrop.service.FileCopyService;
	
	public class BootstrapServices
	{
		public function BootstrapServices(injector:IInjector)
		{
			injector.mapSingleton(FileCopyService);
		}
	}
}