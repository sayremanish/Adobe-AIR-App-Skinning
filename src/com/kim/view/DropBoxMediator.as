package com.kim.view
{
	import com.kim.events.FileDropEvent;
	import com.kim.collections.FileCollection;
	
	import flash.desktop.ClipboardFormats;
	import flash.desktop.NativeDragManager;
	import flash.events.NativeDragEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class DropBoxMediator extends Mediator
	{
		[Inject]
		public var view:DropBox;
		
		
		override public function onRegister():void{
			addViewListener(NativeDragEvent.NATIVE_DRAG_ENTER, handleNativeDrag);
			addViewListener(NativeDragEvent.NATIVE_DRAG_DROP, handleNativeDrop);
		}
		
		private function handleNativeDrag(event:NativeDragEvent):void{
			var url:String = event.clipboard.getData( ClipboardFormats.URL_FORMAT ) as String;
			var files:FileCollection = new FileCollection(event.clipboard.getData( ClipboardFormats.FILE_LIST_FORMAT ) as Array);
			if( ( files != null && files.length >= 0 ) || ( url != null ) ){ 
				NativeDragManager.acceptDragDrop(view);
			}
		}
		
		private function handleNativeDrop(event:NativeDragEvent):void{
			var files:FileCollection = new FileCollection(event.clipboard.getData( ClipboardFormats.FILE_LIST_FORMAT ) as Array);
			if (files.length > 0) {
				dispatch(new FileDropEvent(FileDropEvent.FILE_DROP, files));
			}
		}
	}
}