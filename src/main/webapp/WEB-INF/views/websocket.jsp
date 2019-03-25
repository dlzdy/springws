<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="false" %>
<html>
<head>
    <title>My WebSocket</title>
</head>

<body>
Welcome<br/>
<input id="text" type="text" /><button onclick="send()">Send</button>    <button onclick="closeWebSocket()">Close</button>
<div id="message">
</div>
</body>

<script type="text/javascript">
    var websocket = null;


    if('WebSocket' in window){
        websocket = new WebSocket("ws://localhost:8080/websocket/333");
    }
    else{
        alert('Not support websocket')
    }
    websocket.onerror = function(){
        setMessageInnerHTML("error");
    };
    websocket.onopen = function(event){
        setMessageInnerHTML("open");
    }
    websocket.onmessage = function(event){
        setMessageInnerHTML(event.data);
    }
    websocket.onclose = function(){
        setMessageInnerHTML("close");
    }
    window.onbeforeunload = function(){
        websocket.close();
    }
    function setMessageInnerHTML(innerHTML){
        document.getElementById('message').innerHTML += innerHTML + '<br/>';
    }
    function closeWebSocket(){
        websocket.close();
    }
    function send(){
        var message = document.getElementById('text').value;
        websocket.send(message);
    }
</script>
</html>