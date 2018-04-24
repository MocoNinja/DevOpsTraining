<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<link rel="stylesheet" href="/css/style.css">
<script type="text/javascript" src="/js/app.js"></script>

<title>¡Bienvenido!</title>
</head>
<body>
	<p>
		Es un placer haberte conocido, <span class="user">${guest.firstName }
			${guest.lastName }</span>!
	</p>
	<br />
	<form method="post" action="/signIn.do" class="ninja-form">
		<input value=${guest.firstName } name="firstName" hidden="hidden">
		<input value=${guest.lastName } name="lastName" hidden="hidden">
		Nos encantaría que firmaras nuestro libro de visitas. Si te parece
		bien, pasa por
		<input type="submit" value="aquí!" />
	</form>
	<footer>
		<a href="/">HOME</a>
	</footer>
</body>
</html>