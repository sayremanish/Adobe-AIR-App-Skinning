package org.storybot.model.events {
	
	import flash.events.Event;
	import flash.filesystem.File;
	import org.storybot.model.vo.FileCollection;

	public class FileDropEvent extends Event {
		public static const FILE_DROP:String='org.storybot.model.events.FileDrop.FILE_DROP';
		protected var _files:FileCollection;
		
		public function FileDropEvent(type:String, $files:FileCollection, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			_files=$files;
		}
		public function get files():FileCollection {
			return _files;
		}
		override public function clone():Event {
			return new FileDropEvent(type, files, bubbles, cancelable);
		}
		override public function toString():String {
			return formatToString('FileDrop', 'type', 'bubbles', 'cancelable', 'files');
		}
	}
}