#pragma TextEncoding = "UTF-8"
#pragma rtGlobals=3		// Use modern global access method and strict wave access.
function RayleighLength(w0,lambda)
	variable w0, lambda
	return pi*w0^2/lambda
end

function BeamRadius(z,w0,lambda)
	variable z,w0,lambda
	return w0*sqrt(1+(z/(pi*w0^2/lambda))^2)
end

function GaussianBeamIntensity(dataWave,w0x,w0y,lambda)
	wave dataWave
	variable w0x, w0y, lambda
	
	make/O/FREE/N=(dimSize(dataWave,2)) radiusWaveX, radiusWaveY
	setscale/P x,dimOffset(dataWave,2), DimDelta(dataWave,2), radiusWaveX
	setscale/P x,dimOffset(dataWave,2), DimDelta(dataWave,2), radiusWaveY
	radiusWaveX[] = BeamRadius(x,w0x,lambda)
	radiusWaveY[] = BeamRadius(x,w0y,lambda)
	datawave[][][]=2/(pi*radiusWaveX(z)*radiusWaveY(z))*exp(-2*((x/radiusWaveX(z))^2+(y/radiusWaveY(z))^2))
end

function MakeDataWave(wavname, numx,numy,dPix,zmin,zmax,numz)
	string wavname
	variable numx, numy, dPix, zmin, zmax, numz
	
	make/O/N=(numx,numy,numz) $wavName
	wave temp = $wavName
	
	variable dz = (zmax-zmin)/numz
	setScale/P x, (-1*(numx+1)/2*dPix), dPix, temp
	setScale/P y, (-1*(numy+1)/2*dPix), dPix, temp
	setScale/P z, zMin, dz, temp
end

//function imageBeam(datawave, z,theta)
//	wave datawave
//	variable z,theta
//	duplicate/FREE datawave dataWaveRotated
//	setScale/P x, (-1*(numx+1)/2*dPix)*cos(theta), dPix*cos(theta), dataWaveRotated
//	setScale/P z, zMin+, dz, temp
//	
//	
//
//end