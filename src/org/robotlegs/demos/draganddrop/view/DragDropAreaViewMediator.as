package org.robotlegs.demos.draganddrop.view
{
	
	import org.robotlegs.demos.draganddrop.model.events.FileDropEvent;
	import org.robotlegs.mvcs.Mediator;
	
	public class DragDropAreaViewMediator extends Mediator
	{
		override public function onRegister():void
		{
			// addContextListener is we pick up app events and translate them for the view
			
			// addViewListener is we pick up user actions and translate them for the app
			addViewListener(FileDropEvent.FILE_DROP, dispatch, FileDropEvent);
		}
	}
}