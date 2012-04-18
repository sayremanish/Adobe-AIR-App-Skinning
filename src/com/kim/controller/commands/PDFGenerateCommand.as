package com.kim.controller.commands
{
	import com.kim.events.FileDropEvent;
	import com.kim.service.PDFGenerationService;
	
	import org.robotlegs.mvcs.Command;
	
	public class PDFGenerateCommand extends Command
	{
		[Inject]		
		public var event:FileDropEvent;
		
		[Inject]
		public var service:PDFGenerationService;
		
		override public function execute():void {
			service.generate(event.files);
		}
	}
}