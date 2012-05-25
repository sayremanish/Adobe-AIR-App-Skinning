package com.kim.controller.commands
{
	import com.kim.events.FileCreatedEvent;
	import com.kim.service.StoryzerPublishService;
	
	import org.robotlegs.mvcs.Command;
	
	public class PublishStoryCommand extends Command
	{
		
		[Inject]		
		public var event:FileCreatedEvent;
		
		[Inject]
		public var service:StoryzerPublishService;
		
		override public function execute():void {
			service.publishStory(event.file);
		}
	}
}