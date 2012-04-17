package org.storybot.controller.bootstrap
{
	
	import org.robotlegs.core.ICommandMap;
	import org.storybot.controller.commands.FilterUnwantedFilesCommand;
	import org.storybot.model.events.FileDropEvent;
	
	public class BootstrapCommands
	{
		public function BootstrapCommands(commandMap:ICommandMap)
		{
			commandMap.mapEvent(FileDropEvent.FILE_DROP, FilterUnwantedFilesCommand, FileDropEvent, true);
		}
	}
}