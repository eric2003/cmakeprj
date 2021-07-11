function test() {
    Write-Host "Hello, World!"
	Write-Host "Hello, Github actions!"
	Write-Host "Hello, OneFLOW-CFD!"
}

function MyGetFileName( $filePath ) {
	$file_name_complete = [System.IO.Path]::GetFileName("$filePath")
	$file_name_complete
	#Write-Host "fileNameFull :" $file_name_complete	
}

function MyDownloadFile( $fullFilePath ) {
	$my_filename = MyGetFileName("$fullFilePath")
	$my_location = Get-Location
	$my_local_filename = "$my_location" + "/" + $my_filename
	
	$my_client = new-object System.Net.WebClient
	$my_client.DownloadFile( $fullFilePath, $my_local_filename )	
}

function InstallMSMPI() {
    mkdir mpi_dir
    cd mpi_dir
    # install MPI SDK and Runtime
    Write-Host "Installing Microsoft MPI SDK..."
	$msmpisdk_webfilename = 'https://download.microsoft.com/download/A/E/0/AE002626-9D9D-448D-8197-1EA510E297CE/msmpisdk.msi'
	MyDownloadFile( $msmpisdk_webfilename )
	
    Start-Process -FilePath msiexec.exe -ArgumentList "/quiet /qn /i msmpisdk.msi" -Wait
    Write-Host "Microsoft MPI SDK installation complete"
    Write-Host "Installing Microsoft MPI Runtime..."
	
	$msmpisetup_webfilename = 'https://download.microsoft.com/download/A/E/0/AE002626-9D9D-448D-8197-1EA510E297CE/msmpisetup.exe'
	MyDownloadFile( $msmpisetup_webfilename )
	
    Start-Process -FilePath MSMpiSetup.exe -ArgumentList -unattend -Wait
    Write-Host "Microsoft MPI Runtime installation complete..."
	
	ls
	
    c:
    cd "C:/Program Files (x86)/Microsoft SDKs/MPI"
    ls	
	cd "C:/Program Files/Microsoft MPI/Bin"
	ls
	
	$Env:path = $Env:Path + ";C:/Program Files/Microsoft MPI/Bin"
	
	Write-Host "./mpiexec.exe"
	./mpiexec.exe
	Write-Host "./mpiexec"
	./mpiexec
	Write-Host "mpiexec.exe"
	mpiexec.exe
	
    #cd 
    #dir
    #c:
    #cd "C:/Program Files (x86)/Microsoft SDKs/MPI"
    #dir
}

function main() {
    test
	InstallMSMPI
}

main