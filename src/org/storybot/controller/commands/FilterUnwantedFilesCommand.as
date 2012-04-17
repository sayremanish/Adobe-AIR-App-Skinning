package org.storybot.controller.commands
{
	
	import flash.filesystem.File;
	
	import org.storybot.model.events.FileDropEvent;
	import org.storybot.service.FileCopyService;
	import org.robotlegs.mvcs.Command;
	import org.storybot.model.vo.FileCollection;
	
	public class FilterUnwantedFilesCommand extends Command
	{
		
		[Inject]
		public var event:FileDropEvent;
		
		[Inject]
		public var fileCopyService:FileCopyService;
		
		
		public var allowedFiles:FileCollection = new FileCollection();
		
		private var allowedExtensions:Array = new Array('png', 'jpg', 'jpeg');
		
		override public function execute():void {
			
			// loop through passed files
			for each(var file:File in event.files) {
				// check if passed files are legit
				if (allowedExtensions.indexOf(file.extension) != -1) {
					// if legit, put in allowedFiles Array
					this.allowedFiles.addItem(file);
				}
			}
			
			// send to FileCopyService for processing
			fileCopyService.process(this.allowedFiles);
		}
	}
}