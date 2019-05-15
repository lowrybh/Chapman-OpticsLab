#pragma TextEncoding = "UTF-8"
#pragma rtGlobals=3		// Use modern global access method and strict wave access.

//function CreateNewExperiment(expName)
//	string expName
//
//end


////////////////////////////////////////////
//GrabFrames(cam, imgArrStr,[numImgs],
//var cam: Camera index, usually 0
//str imgArrStr: name of the wave to hold the images
//var numImgs: number of images to grab (optional, defaults to 1)
////////////////////////////////////////////
function GrabFrames(cam, imgArrStr,[numImgs])
	variable cam, numImgs
	string imgArrStr
	numImgs = (paramisDefault(numImgs)||numtype(numImgs))? 1:numImgs
	
	make/O/N=(1288,964,numImgs) $imgArrStr
	wave imgArr = $imgArrStr
	variable ii=0
	do
		wave/Z tempImg = PGR_GetFrame(cam)
		imgArr[][][ii] = tempImg[p][q]
		ii+=1
	while(ii<numImgs )
	

end

Function BackgroundImageGrab(s)		// This is the function that will be called periodically
	STRUCT WMBackgroundStruct &s
	wave/Z tempImg = PGR_GetFrame(0)
	duplicate/O tempImg currImg
	return 0	// Continue background task
End

Function StartContinuousImageGrab()
	Variable numTicks = 1		// Run every two seconds (120 ticks)
	CtrlNamedBackground GrabImgsCont, period=numTicks, proc=BackgroundImageGrab
	CtrlNamedBackground GrabImgsCont, start
End

Function StopContinuousImageGrab()
	CtrlNamedBackground GrabImgsCont, stop
End

function initializeIPGUI()
	DFREF prevDFR = GetDataFolderDFR();
	
	DoWindow/F ImageProcessing
	if( V_Flag==1 )							// is the "panel" up already?
		return 0
	endif
end


Function MultiImageStats(imgArr)
	wave imgArr;
	string imgArrStr = NameOfWave(imgArr);
	variable numRows = DimSize(imgArr,0);
	variable numCols = DimSize(imgArr,1);
	variable numlayers = DimSize(imgArr,2);
	
	
//	string imgArrStr_avg = imgArrStr+"_avg"
	//Make a wave to hold an average of all the images passed thru imgArr
	make/O/N=(numRows,numCols) $(imgArrStr+"_avg")	
	wave imageArr_avg = $(imgArrStr+"_avg")
	make/O/N=(numRows,numCols) $(imgArrStr+"_sdev")
	wave imageArr_sdev = $(imgArrStr+"_sdev")
	
 	
	
end

function/WAVE ImageSetStats(imgArr)
	wave imgArr;

	variable numlayers = DimSize(imgArr,2)
	
	MatrixOP/FREE pixelMean = sumBeams(imgArr)
	pixelMean /= numLayers
	duplicate/FREE pixelMean pixelDev
	variable i
	for(  i=0;i<numLayers;i+=1)	// Initialize variables;continue test
		
	endfor						// Execute body code until continue test is FALSE

	
	return pixelMean

end

function SetBrightness(val)
	// range: 1.367 to 
	variable val
	variable ret = PGR_SetSetting(0,0,1,val,0,1)
	return ret
end

function SetExposure(val)
	variable val
	variable ret = PGR_SetSetting(0,1,1,val,0,1)
	return ret
end

function SetSharpness(val)
	variable val
	variable ret = PGR_SetSetting(0,2,1,val,0,1)
	return ret
end

function SetGamma(val)
	variable val
	variable ret = PGR_SetSetting(0,3,1,val,0,1)
	return ret
end


function SetShutter(val)
	variable val
	variable ret = PGR_SetSetting(0,4,1,val,0,1)
	return ret
end

function SetGain(val)
	variable val
	variable ret = PGR_SetSetting(0,5,1,val,0,1)
	return ret
end

function SetFrameRate(val)
	variable val
	variable ret = PGR_SetSetting(0,6,1,val,0,1)
	return ret
end