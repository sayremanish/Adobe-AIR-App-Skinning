package com.kim
{
	import com.kim.controller.commands.CBZGenerateCommand;
	import com.kim.controller.commands.PDFGenerateCommand;
	import com.kim.controller.commands.PublishStoryCommand;
	
	import com.kim.events.FileCreatedEvent;
	import com.kim.events.FileDropEvent;
	import com.kim.service.CBZGenerationService;
	import com.kim.service.PDFGenerationService;
	
	import com.kim.service.IPublishService;
	import com.kim.service.StoryzerPublishService;
	
	
	import com.kim.service.helpers.StoryzerPublishResultParser;
	import com.kim.service.helpers.IPublishResultParser;	
	
	
	import com.kim.view.DropBox;
	import com.kim.view.DropBoxMediator;
	
	import org.robotlegs.mvcs.Context;
	
	public class DragAndDropContext extends Context
	{
		override public function startup():void
		{
			mediatorMap.mapView(DropBox, DropBoxMediator);
			
			//injector.mapSingleton(PDFGenerationService);
			injector.mapSingleton(CBZGenerationService);
			injector.mapSingletonOf(IPublishService, StoryzerPublishService);
			injector.mapSingletonOf(IPublishResultParser, StoryzerPublishResultParser);
			
			
			//commandMap.mapEvent(FileDropEvent.FILE_DROP,PDFGenerateCommand);
			commandMap.mapEvent(FileDropEvent.FILE_DROP,CBZGenerateCommand);
			commandMap.mapEvent(FileCreatedEvent.FILE_CREATED, PublishStoryCommand, FileCreatedEvent);
			
			super.startup();
		}
		
	}
}