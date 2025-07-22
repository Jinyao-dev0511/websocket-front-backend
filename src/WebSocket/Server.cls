/// Simple WebSocket Server - Echo messages with lifecycle events
Class WebSocket.Server Extends %CSP.WebSocket
{

/// Property to store client info
Property ClientId As %String;

/// Property to store connection time
Property ConnectedAt As %String;

/// Called before WebSocket server starts
Method OnPreServer() As %Status
{
    // Generate simple client ID
    Set ..ClientId = $Random(9999) + 1000
    Set ..ConnectedAt = $ZDateTime($Horolog, 3)

    // Set shared connection for better performance
    Set ..SharedConnection = 1

    // Store client info in a global for OnPostServer access
    Set ^WebSocketClients(..ClientId) = ..ConnectedAt
    
    // Send detailed OnPreServer info to client
    Do ..Write("[OnPreServer123] 🚀 WebSocket server initializing...")

    Quit $$$OK
}

/// Main WebSocket server implementation
Method Server() As %Status
{
    Set timeout = 30

    // Main message loop
    For {
        Set len = 32656
        Set data = ..Read(.len, .status, timeout)

        If $$$ISERR(status) {
            If $$$GETERRORCODE(status) = $$$CSPWebSocketClosed {
                // Send disconnect message before OnPostServer
                Do ..Write("[Server] Client disconnecting...")
                Quit
            }
            If $$$GETERRORCODE(status) = $$$CSPWebSocketTimeout {
                Do ..Write("[Server] Heartbeat ping from server")
                Continue
            }
            Do ..Write("[Server] Error: " _ $System.Status.GetErrorText(status))
            Quit
        }

        // Echo the message back with timestamp
        Set response = "[Server] Echo: " _ data _ " (at " _ $ZDateTime($Horolog, 3) _ ")"
        Do ..Write(response)
    }

    // Clean shutdown
    Do ..EndServer()

    Quit $$$OK
}

/// Called after WebSocket server ends
Method OnPostServer() As %Status
{
    Set disconnectedAt = $ZDateTime($Horolog, 3)

    // Calculate session duration
    If $Data(^WebSocketClients(..ClientId)) {
        Set connectedAt = ^WebSocketClients(..ClientId)
        Set duration = $ZDateTime($Horolog, 3) - connectedAt
        Kill ^WebSocketClients(..ClientId)
    } Else {
        Set duration = "unknown"
    }

    // Try to send final messages to client (may not work if connection is already closed)
    Try {
        Do ..Write("[OnPostServer] 👋 Goodbye!")
    } Catch ex {
        // Connection already closed, that's expected
        // We could log this to system log if needed
    }

    Quit $$$OK
}

}
