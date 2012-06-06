package com.kim.controller.commands
{
	import com.kim.events.FileDropEvent;
	import com.kim.service.StoryLocalPreparationService;
	
	import org.robotlegs.mvcs.Command;
	
	
	public class SaveStoryLocalCommand extends Command
	{
		
		[Inject]		
		public var event:FileDropEvent;
		
		[Inject]
		public var localStoryService:StoryLocalPreparationService;
		
		override public function execute():void {
			
			
			if (createNewStory) {
				localStoryService.save(event.files, event.currentStoryFolder);	
			}
			
		}
	}

}