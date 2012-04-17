package org.storybot.controller.bootstrap
{
	
	import org.robotlegs.core.IInjector;
	
	import org.storybot.service.FileCopyService;
	
	public class BootstrapServices
	{
		public function BootstrapServices(injector:IInjector)
		{
			injector.mapSingleton(FileCopyService);
		}
	}
}