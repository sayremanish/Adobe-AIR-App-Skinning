package com.kim.controller.commands
{
	
	import com.kim.events.FormSubmitEvent;
	import com.kim.service.StoryzerLoginService;
	
	import org.robotlegs.mvcs.Command;

	public class StoryzerLoginCommand extends Command
	{
		[Inject]		
		public var event:FormSubmitEvent;
		
		[Inject]
		public var service:StoryzerLoginService;
		
		override public function execute():void {
			service.login(event.params);
		}


	}
}