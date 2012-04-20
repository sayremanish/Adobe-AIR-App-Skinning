package com.kim.service
{
	import com.kim.collections.FileCollection;
	
	import deng.fzip.FZip;
	
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
			
			var destinationFile:File = File.applicationStorageDirectory.resolvePath(_newPath);
			var stream:FileStream = new FileStream();
			stream.open(destinationFile, FileMode.WRITE);
			_zip.serialize(stream);
			stream.close();
		}
		
		override protected function writeToFile():void{
			_zip.filesList = null;
			_zip.filesDict = null;
		}
		
	}
}