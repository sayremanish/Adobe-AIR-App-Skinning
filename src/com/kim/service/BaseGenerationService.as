package com.kim.service
{
	import com.kim.collections.FileCollection;
	import com.kim.events.FileCreatedEvent;
	import com.kim.events.UnsuccessfulFileCreatedEvent;
	import com.kim.utils.Utils;
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	import org.robotlegs.mvcs.Actor;
	
	import spark.collections.Sort;
	import spark.collections.SortField;
	
	public class BaseGenerationService extends Actor
	{
		protected var _buffer:ByteArray = new ByteArray();
		protected var _currentFile:File;
		protected var _newPath:String;
		protected var _destinationFile:File;
		protected var _fs:FileStream;
		public function generate(files:FileCollection):void{
			
			//Filter files before use
			var filteredFiles:FileCollection = Utils.filterFiles(files, ["png", "jpg", "jpeg"]);

			//Sort the files
			var nameSortField:SortField= new SortField();
			nameSortField.name = "name";
			
			var sort:Sort = new Sort();
			sort.fields = [nameSortField];
			sort.compareFunction = Utils.sortFiles;
			
			filteredFiles.sort = sort;
			filteredFiles.refresh();
			
			var byteArr:ByteArray;
			
			for each(_currentFile in filteredFiles)
			{
				byteArr = new ByteArray();
				_fs = new FileStream();
				_fs.open(_currentFile,FileMode.READ);
				_fs.readBytes(byteArr);
				createPage(byteArr);
			}
			
			//do clean up
			cleanUp();
			
			_buffer.position = 0;
			
			writeToFile();
		}
		
		protected function writeToFile():void{
			_destinationFile = File.applicationStorageDirectory.resolvePath(_newPath);

			var fs:FileStream = new FileStream();
			
			fs.open(_destinationFile, FileMode.WRITE);
			fs.writeBytes(_buffer, 0, _buffer.length);
			trace('reached here');
			fs.addEventListener(Event.CLOSE, dispatchFileCreatedEvent);
			
			fs.close();	
			trace('closed');
		}
		
		private function dispatchFileCreatedEvent(event:Event):void {
			trace(_destinationFile);
			dispatch(new FileCreatedEvent(FileCreatedEvent.FILE_CREATED, _destinationFile));
		}
		
		protected function createPage(byteArray:ByteArray):void{
			//To be overriden by subclass
		}
		
		protected function cleanUp():void{
			//To be overriden by subclass
		}
	}
}