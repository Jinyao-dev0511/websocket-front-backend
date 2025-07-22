/// Simple WebSocket Server - Echo messages back to client
Class WebSocket.Server Extends %CSP.WebSocket
{

/// Main WebSocket server implementation
Method Server() As %Status
{
    Set timeout = 30

    // Send welcome message
    Do ..Write("Connected to WebSocket server")

    // Main message loop
    For {
        Set len = 32656
        Set data = ..Read(.len, .status, timeout)

        If $$$ISERR(status) {
            If $$$GETERRORCODE(status) = $$$CSPWebSocketClosed {
                Quit  // Client disconnected
            }
            If $$$GETERRORCODE(status) = $$$CSPWebSocketTimeout {
                Do ..Write("ping")  // Send ping on timeout
                Continue
            }
            Quit  // Other errors
        }

        // Echo the message back
        Do ..Write("Echo: " _ data)
    }

    // Clean shutdown
    Do ..EndServer()

    Quit $$$OK
}

}
