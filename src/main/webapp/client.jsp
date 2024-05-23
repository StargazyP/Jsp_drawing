<meta charset="UTF-8">
<title>Tomcat WebSocket</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
</head>

    <style>
        /* Canvas styles */
        canvas {
            border: 1px solid #000;
            background-color: #fff;
        }
    </style>

<body>
<%
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String)session.getAttribute("userID");
	}
%>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <button type="button" class="navbar-toggler" 
            data-bs-toggle="collapse" 
            data-bs-target="#bs-example-navbar-collapse-1" 
            aria-controls="bs-example-navbar-collapse-1"
            aria-expanded="false"
            aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <a class="navbar-brand" href="index.jsp">Web</a>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="active"><a class="nav-link" href="main.jsp">MAIN</a></li>
                <li class="nav-item"><a class="nav-link" href="bbs.jsp">PAGE</a></li>
                <!-- <li class="nav-item"><a class="nav-link" href="room.jsp">Room</a></li> --> <!-- 아직미구현 -->
                <li class="nav-item"><a class="nav-link" href="client.jsp">Client</a></li>
            </ul>
            <%
           		 if(userID == null){
            %>
            <ul class="navbar-nav ml-auto mb-2 mb-lg-0">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
                        role="button" data-bs-toggle="dropdown"
                        aria-expanded="false">CONNECT</a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="login.jsp">LOGIN</a></li>
                        <li><a class="dropdown-item" href="register.jsp">SIGNUP</a></li>
                    </ul>
                </li>
            </ul>
            <%
            	} else {
            %>
      
            <ul class="navbar-nav ml-auto mb-2 mb-lg-0">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
                    role="button" data-bs-toggle="dropdown"
                    aria-expanded="false">USER CONTROL</a>
                <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <li><a class="dropdown-item" href="logoutAction.jsp">LOGOUT</a></li>
                </ul>
            </li>
        </ul>
        <%
            	}
        %>
           
        </div>
    </div>
</nav>
	<form>
		<input id="message" type="text">
		<input onclick="wsSendMessage();" value="Echo" type="button">
		<input onclick="wsCloseConnection();" value="Disconnect" type="button">
	</form>
	<br>
	<textarea id="echoText" rows="5" cols="30"></textarea>
	<script type="text/javascript">
		var webSocket = new WebSocket("ws://localhost:8080/JSPWEB/websocketendpoint");
		var echoText = document.getElementById("echoText");
		echoText.value = "";
		var message = document.getElementById("message");
		webSocket.onopen = function(message){ wsOpen(message);};
		webSocket.onmessage = function(message){ wsGetMessage(message);};
		webSocket.onclose = function(message){ wsClose(message);};
		webSocket.onerror = function(message){ wsError(message);};
		function wsOpen(message){
			echoText.value += "Connected ... \n";
		}
		function wsSendMessage(){
			webSocket.send(message.value);
			echoText.value += "Message sended to the server : " + message.value + "\n";
			message.value = "";
		}
		function wsCloseConnection(){
			webSocket.close();
		}
		function wsGetMessage(message){
			echoText.value += "Message received from to the server : " + message.data + "\n";
		}
		function wsClose(message){
			echoText.value += "Disconnect ... \n";
		}

		function wserror(message){
			echoText.value += "Error ... \n";
		}
	</script>
</body>
</html>