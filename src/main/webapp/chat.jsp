<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="org.apache.commons.net.ftp.FTPClient,org.apache.commons.net.ftp.FTPFile" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chat Application</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
    <style>
        #myCanvas {
            border: 1px solid #000;
            background-color: #fff;
            width: 100%;
            height: 500px;
        }
        #chat-content {
            height: 400px;
            overflow-y: auto;
        }
    </style>
</head>
<body>

<%

String userID = null;
if (session.getAttribute("userID") == null) {
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('PLEASE LOGIN');");
    script.println("location.href = 'login.jsp'");
    script.println("</script>");
}
if (session.getAttribute("userID") != null) {
    userID = (String) session.getAttribute("userID");
}
int pageNumber = 1;
if (request.getParameter("pageNumber") != null) {
    pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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

<div class="container-fluid">
    <div class="row">
        <div class="col-md-6">
            <canvas id="myCanvas"></canvas>
        </div>
        <div class="col-md-6">
            <div class="card card-bordered">
                <div class="card-header">
                    <h4 class="card-title"><strong>Chat</strong></h4>
                </div>
                <div class="ps-container ps-theme-default ps-active-y" id="chat-content">
                    <!-- Your chat content here -->
                </div>
                <div class="publisher bt-1 border-light">
                    <input id="message" type="text" class="form-control" placeholder="Type a message">
                    <button onclick="sendMessage();" class="btn btn-primary mt-2">Send</button>
                    <button onclick="clearCanvas();" class="btn btn-danger mt-2">Clear Canvas</button>
                    <a class="publisher-btn" href="#" data-abc="true"><i class="fa fa-smile"></i></a>
                    <a class="publisher-btn text-info" href="#" data-abc="true"><i class="fa fa-paper-plane"></i></a>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    var webSocket = new WebSocket("ws://localhost:8080/JSPWEB/websocketendpoint");
    var echoText = document.getElementById("chat-content");
    var messageInput = document.getElementById("message");
    var loggedInUserId = "<%= session.getAttribute("userID") %>";

    webSocket.onopen = function(event){ wsOpen(event); };
    webSocket.onmessage = function(event){ wsGetMessage(event); };
    webSocket.onclose = function(event){ wsClose(event); };
    webSocket.onerror = function(event){ wsError(event); };

    function wsOpen(event){
        echoText.innerHTML += "Connected ... <br>";
    }

    function sendMessage() {
        var message = messageInput.value;
        if (message.trim() !== "") {
            var chatMessage = JSON.stringify({ type: 'chat', user: loggedInUserId, text: message });
            webSocket.send(chatMessage);
            messageInput.value = "";
        }
    }

    function wsGetMessage(event){
        var data = JSON.parse(event.data);
        if (data.type === 'chat') {
            echoText.innerHTML += data.user + ": " + data.text + "<br>";
        } else if (data.type === 'draw') {
            drawFromMessage(data);
        } else if (data.type === 'clear') {
            clearCanvasLocal();
        }
    }

    function wsClose(event){
        echoText.innerHTML += "Disconnected ... <br>";
    }

    function wsError(event){
        echoText.innerHTML += "Error ... <br>";
    }

    function drawFromMessage(data) {
        ctx.beginPath();
        ctx.moveTo(data.x, data.y);
        ctx.lineTo(data.newX, data.newY);
        ctx.strokeStyle = "black"; 
        ctx.lineWidth = 2; 
        ctx.stroke();
    }

    function clearCanvasLocal() {
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        drawGrid();
    }

    function clearCanvas() {
        clearCanvasLocal();
        var clearMessage = JSON.stringify({ type: 'clear' });
        webSocket.send(clearMessage);
    }

    function drawGrid() {
        for (let x = 0; x < canvas.width; x += gridSize) {
            ctx.beginPath();
            ctx.moveTo(x, 0);
            ctx.lineTo(x, canvas.height);
            ctx.strokeStyle = "#ccc";
            ctx.stroke();
        }
        for (let y = 0; y < canvas.height; y += gridSize) {
            ctx.beginPath();
            ctx.moveTo(0, y);
            ctx.lineTo(canvas.width, y);
            ctx.strokeStyle = "#ccc";
            ctx.stroke();
        }
    }

    const canvas = document.getElementById("myCanvas");
    const ctx = canvas.getContext("2d");
    const gridSize = 20;
    let isDrawing = false;
    let lastX = 0;
    let lastY = 0;

    // 캔버스 크기를 부모 컨테이너에 맞춤
    canvas.width = canvas.offsetWidth;
    canvas.height = canvas.offsetHeight;

    // 그리드 그리기
    drawGrid();

    canvas.addEventListener("mousedown", (e) => {
        isDrawing = true;
        lastX = e.clientX - canvas.getBoundingClientRect().left;
        lastY = e.clientY - canvas.getBoundingClientRect().top;
    });

    canvas.addEventListener("mousemove", (e) => {
        if (!isDrawing) return;

        const x = e.clientX - canvas.getBoundingClientRect().left;
        const y = e.clientY - canvas.getBoundingClientRect().top;

        ctx.beginPath();
        ctx.moveTo(lastX, lastY);
        ctx.lineTo(x, y);
        ctx.strokeStyle = "black";
        ctx.lineWidth = 2;
        ctx.stroke();

        const drawMessage = JSON.stringify({ type: 'draw', x: lastX, y: lastY, newX: x, newY: y });
        webSocket.send(drawMessage);

        lastX = x;
        lastY = y;
    });

    canvas.addEventListener("mouseup", () => {
        isDrawing = false;
    });

    canvas.addEventListener("mouseleave", () => {
        isDrawing = false;
    });

    webSocket.addEventListener('message', (event) => {
        const data = JSON.parse(event.data);
        if (data.type === 'draw') {
            drawFromMessage(data);
        } else if (data.type === 'clear') {
            clearCanvasLocal();
        }
    });
</script>


</body>
</html>

