<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="false" %>
<html>
<head>
    <title>WebSocket with SockJS</title>
</head>
<body>
<h1>Welcome!</h1>
<ul id="ul">
</ul>
<script type="text/javascript" src="/resources/js/sockjs-1.0.0.min.js"></script>
<script>
    // SockJS与原生的WebSocket的方法基本是一致的，
    // 所以只需要将 new WebSocket(url); 换成 new SockJS(url); 就可以了
//     var url = "/echo";
//     var sock = new SockJS(url);
//     sock.onopen = function (ev) {
//         console.log("opening");
//         sayHey();
//     };

//     sock.onmessage = function (ev) {
//         console.log(ev.data);
//         var li = document.createElement("li");
//         li.innerText = ev.data;
//         document.getElementById("ul").appendChild(li);
//         setTimeout(sayHey, 2000);
//     };

//     sock.onclose = function (ev) {
//         console.log("closed");
//     };

//     function sayHey() {
//         console.log("sending 'Hey guy!'");
//         sock.send("Hey guy!");
//     };
    
    
    var CONNECT_COUNT = 3; 
    var sockjs; 
    var sockjs_url = '/echo'; 
    var isClose = false; 
    var connectCount = 1; 
    new_conn = function() {
    	sockjs = new SockJS(sockjs_url);

    	sockjs.onopen = function(){
            console.log("opening");
    		connectCount = 1; // 重置重连次数
    		checkHeartBeat(); // 心跳检测
            sayHey();
    	} 
    	
    	sockjs.onmessage = function(e) { 
    		//var data = JSON.parse(e.data);  
    		handleMessage(e.data);
    	};
    	
    	sockjs.onclose = function(e) { 
    		// 已经关闭的情况，不重连
    		if (isClose) {
    			return;
    		} 
    		// 小于重连次数
    		if (connectCount < CONNECT_COUNT) {
    			setTimeout(function() {
    				new_conn();
    			}, (Math.random() * 3 + 1 )* 1000);
    		} else {
    			isClose = true;
    		}
    	};
    }
    
    function checkHeartBeat(){
		console.log("checkHeartBeat");
		setTimeout(checkHeartBeat, 10000);
	};
	
	function sayHey() {
	 	console.log("sending 'Hey guy!'");
	 	sockjs.send("Hey guy!");
	};	
  
    function handleMessage(data) {
        console.log(data);
        var li = document.createElement("li");
        li.innerText = data;
        document.getElementById("ul").appendChild(li);
        setTimeout(sayHey, 2000);
    } 
    new_conn();
   
</script>
</body>
</html>
