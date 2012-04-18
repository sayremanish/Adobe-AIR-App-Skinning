package com.kim.service
{
	import com.kim.collections.FileCollection;
	import com.kim.utils.Utils;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	import mx.collections.Sort;
	import mx.collections.SortField;
	
	import org.purepdf.elements.images.ImageElement;
	import org.purepdf.pdf.PageSize;
	import org.purepdf.pdf.PdfDocument;
	import org.purepdf.pdf.PdfVersion;
	import org.purepdf.pdf.PdfWriter;
	import org.robotlegs.mvcs.Actor;
	
	public class PDFGenerationService extends Actor
	{
		private var __destinationFolder:String = 'destination';
		private var _pdf:PdfDocument;
		private var _writer:PdfWriter;
		private var _scale:int;
		private var _margin:int;
		private var _buffer:ByteArray;
		private var _currentFile:File;
		
		public function PDFGenerationService()
		{
			super();
		}
		
		public function generate(files:FileCollection):void{
			var path:String = this.__destinationFolder + File.separator;
			
			_buffer = new ByteArray();
			_writer = PdfWriter.create(_buffer, PageSize.A4);
			_pdf = _writer.pdfDocument;
			
			_pdf.setPdfVersion(PdfVersion.VERSION_1_5);
			
			
			//Filter files before use
			var filteredFiles:FileCollection = Utils.filterFiles(files, ["png", "jpg", "jpeg"]);
			
			//Sort the files
			var nameSortField:SortField= new SortField();
			nameSortField.name = "name";
			nameSortField.caseInsensitive = true;
			
			var sort:Sort = new Sort();
			sort.fields = [nameSortField];
			filteredFiles.sort = sort;
			filteredFiles.refresh();
			
			var byteArr:ByteArray;
			var fs:FileStream;
			for each(_currentFile in filteredFiles)
			{
				byteArr = new ByteArray();
				fs = new FileStream();
				fs.open(_currentFile,FileMode.READ);
				fs.readBytes(byteArr);
				processImages(byteArr);
			}
			
			//Generate PDF
			var newPath:String = (new Date()).milliseconds.toString() + ".pdf";
			var destinationFile:File = File.applicationStorageDirectory.resolvePath(newPath);
			
			_pdf.close();
			_buffer.position = 0;
			
			fs = new FileStream();
			fs.open(destinationFile, FileMode.WRITE);
			fs.writeBytes(_buffer, 0, _buffer.length);
			fs.close();
		}
		
		//This will process jpg and gif image and add it to new pdf page
		private function processImages(bArr:ByteArray):void
		{
			var image:ImageElement = ImageElement.getInstance(bArr);
			image.scalePercent(50, 50);
			
			if(_pdf.opened){
				_pdf.newPage();		
			}else{
				_pdf.open();
			}
			_pdf.add(image);
			
		}
	}
}