def createUnit(String buildDir)
{
	echo "Creating unit..."
	script{		
		def unitFullPath="${buildDir}"
		sh "chmod +x ./shellScripts/createTranslatorWorkerUnit.sh "
		sh "./shellScripts/createTranslatorWorkerUnit.sh ${params.NXRelease} ${unitFullPath}"		
	}
}

def buildUnit(String buildDir)
{
	echo "Building unit..."
	script{		
		def unitFullPath="${buildDir}"
		sh "chmod +x ./shellScripts/buildTranslatorWorkerUnit.sh "
		sh "./shellScripts/buildTranslatorWorkerUnit.sh ${unitFullPath}"		
	}
}

def TestUnit(String buildDir)
{
	echo "Executing devtests..."
	script{		
		def unitFullPath="${buildDir}"
		sh "chmod +x ./shellScripts/executeTranslatorWorkerTest.sh "
		sh "./shellScripts/executeTranslatorWorkerTest.sh ${unitFullPath}"		
	}
}

def StageForContainer(String buildDir, String stageDir)
{
	echo "Executing stage and deploy..."
	script{		
		def unitFullPath="${buildDir}"
		def stagePath="${stageDir}"
		
		sh "chmod +x ./shellScripts/stageForContainer.sh "
		sh "./shellScripts/stageForContainer.sh ${unitFullPath} ${stagePath} 'Artifacts' "		
	}
}

def CheckLicenseServer()
{
	echo "Executing CheckLicenseServer..."
	script{
		sh "chmod +x ./shellScripts/CheckLicenseServer.sh "
		sh "./shellScripts/CheckLicenseServer.sh"		
	}
}

def BuildAndRunDocker(String buildDir, String stageDir)
{
	echo "Executing Build and Run docker script..."
	script{		
		def unitFullPath="${buildDir}"
		def stagePath="${stageDir}"
		
		sh "chmod +x ./shellScripts/buildAndRunDockerImage.sh "
		sh "./shellScripts/buildAndRunDockerImage.sh ${unitFullPath} ${stagePath}"		
	}
}

def DockerCleanup(String stageDir)
{
	echo "Executing Docker cleanup script..."
	script{		
		def stagePath="${stageDir}"
		
		sh "chmod +x ./shellScripts/cleanDocker.sh "
		sh "./shellScripts/cleanDocker.sh ${stagePath}"		
	}
}

def DeployContainer(String stageDir)
{
	echo "Executing DeployContainer..."
	script{		
		def stagePath="${stageDir}"
		def deployFlag="${params.Deploy}"
		def unitFullPath="${buildDir}"
		
		sh "chmod +x ./shellScripts/deployContainer.sh "
		sh "./shellScripts/deployContainer.sh ${stagePath} ${deployFlag} ${unitFullPath}"		
	}
}

def Purge(String dirName)
{
	echo "Executing Purge ..."
	script{		
		def fullPath="${dirName}"
		sh "chmod +x ./shellScripts/purge.sh "
		sh "./shellScripts/purge.sh ${fullPath}"		
	}
}

return this
