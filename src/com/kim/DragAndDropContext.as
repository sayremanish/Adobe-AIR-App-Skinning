package com.kim
{
	import com.kim.controller.commands.CBZGenerateCommand;
	import com.kim.controller.commands.PDFGenerateCommand;
	import com.kim.controller.commands.PublishStoryCommand;
	import com.kim.controller.commands.SaveStoryLocalCommand;
	import com.kim.controller.commands.StoryzerLoginCommand;
	import com.kim.events.FileCreatedEvent;
	import com.kim.events.FileDropEvent;
	import com.kim.events.FormSubmitEvent;
	import com.kim.service.CBZGenerationService;
	import com.kim.service.IPublishService;
	import com.kim.service.PDFGenerationService;
	import com.kim.service.StoryLocalPreparationService;
	import com.kim.service.StoryzerLoginService;
	import com.kim.service.StoryzerPublishService;
	import com.kim.service.helpers.IPublishResultParser;
	import com.kim.service.helpers.StoryzerPublishResultParser;
	import com.kim.view.DropBox;
	import com.kim.view.DropBoxMediator;
	import com.kim.view.LoginForm;
	import com.kim.view.LoginFormMediator;
	
	import org.robotlegs.mvcs.Context;
	
	public class DragAndDropContext extends Context
	{
		override public function startup():void
		{
			mediatorMap.mapView(DropBox, DropBoxMediator);
			mediatorMap.mapView(LoginForm, LoginFormMediator);
			
			//injector.mapSingleton(PDFGenerationService);
			injector.mapSingleton(CBZGenerationService);
			injector.mapSingleton(StoryLocalPreparationService);
			injector.mapSingletonOf(IPublishService, StoryzerPublishService);
			injector.mapSingletonOf(IPublishResultParser, StoryzerPublishResultParser);
			injector.mapSingleton(StoryzerLoginService);
			
			//commandMap.mapEvent(FileDropEvent.FILE_DROP,PDFGenerateCommand);
			//commandMap.mapEvent(FileDropEvent.FILE_DROP, SaveStoryLocalCommand);
			commandMap.mapEvent(FileDropEvent.FILE_DROP,CBZGenerateCommand);
			commandMap.mapEvent(FileCreatedEvent.FILE_CREATED, PublishStoryCommand, FileCreatedEvent);
			commandMap.mapEvent(FormSubmitEvent.SUBMIT, StoryzerLoginCommand);
			
			super.startup();
		}
		
	}
}