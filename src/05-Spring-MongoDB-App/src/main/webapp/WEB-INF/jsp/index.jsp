<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<link rel="stylesheet" href="/css/style.css">
<script type="text/javascript" src="/js/app.js"></script>

<title>Spring Boot with MongoDB Dockerized App</title>
</head>
<body>
	<header>
		<h1>¡Bienvenido a nuestra página web!</h1>
		<hr />
		<div class="main">
			<p>En esta página web vamos a realizar nuestros pequeños
				experimentos con MongoDB</p>
		</div>
	</header>

	<div class="form">
		<form class="center" action="/hello.do" method="post"
			onsubmit="return validate()">
			<h1>¿Eres nuevo? Preséntate!</h1>
			<h3>O si ya has estado aquí antes, pulsa <a href="/guests.do">aquí</a> para ver el libro de visitas...</h3>
			<hr />
			<p>
				<label>Nombre: </label><input id="firstName" name="firstName">
			</p>
			<p>
				<label>Apellidos: </label><input id="lastName" name="lastName">
			</p>
			<p>
				<input type="submit" value="Submit">
			</p>
		</form>
	</div>

</body>
</html>