package org.robotlegs.demos.draganddrop.controller.bootstrap
{
	
	import org.robotlegs.core.ICommandMap;
	import org.robotlegs.demos.draganddrop.controller.commands.FilterUnwantedFilesCommand;
	import org.robotlegs.demos.draganddrop.model.events.FileDropEvent;
	
	public class BootstrapCommands
	{
		public function BootstrapCommands(commandMap:ICommandMap)
		{
			commandMap.mapEvent(FileDropEvent.FILE_DROP, FilterUnwantedFilesCommand, FileDropEvent, true);
		}
	}
}