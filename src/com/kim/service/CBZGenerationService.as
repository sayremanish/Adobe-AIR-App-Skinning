package com.kim.service
{
	import com.kim.collections.FileCollection;
	import com.kim.events.FileCreatedEvent;
	import com.kim.events.UnsuccessfulFileCreatedEvent;

	
	import deng.fzip.FZip;
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	import org.robotlegs.mvcs.Actor;
	
	public class CBZGenerationService extends BaseGenerationService
	{
		private var _zip:FZip;
		
		override public function generate(files:FileCollection):void{
			_zip = new FZip();
			_newPath = (new Date()).milliseconds.toString() + ".cbz";
			
			super.generate(files);
			
		}
		
		override protected function createPage(byteArray:ByteArray):void{
			_zip.addFile(_currentFile.name, byteArray);
			
			_destinationFile = File.applicationStorageDirectory.resolvePath(_newPath);
			var stream:FileStream = new FileStream();
			stream.open(_destinationFile, FileMode.WRITE);
			_zip.serialize(stream);
			//stream.addEventListener(Event.CLOSE, dispatchFileCreatedEvent);
			stream.close();
		}
		
		override protected function writeToFile():void{
			_zip.filesList = null;
			_zip.filesDict = null;
			dispatch(new FileCreatedEvent(FileCreatedEvent.FILE_CREATED, _destinationFile));
		}
		
		private function dispatchFileCreatedEvent(event:Event):void {
			trace(_destinationFile);
			dispatch(new FileCreatedEvent(FileCreatedEvent.FILE_CREATED, _destinationFile));
		}
		
	}
}