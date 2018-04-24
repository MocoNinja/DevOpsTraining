<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="/css/style.css">
<script type="text/javascript" src="/js/app.js"></script>
<title>Lista de visitantes</title>
</head>
<body>
	<header>
		<h1>Libro de firmas</h1>
	</header>
	<table class="visitas">
		<thead>
			<tr>
				<th>Nombre</th>
				<th>Apellidos</th>
				<th>Fecha de firma</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="listValue" items="${guests}">
			<tr class="visitas">
				<td>${listValue.firstName}</td>
				<td>${listValue.lastName }</td>
				<td>${listValue.visitDate }</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	<footer>
		<a href="/">HOME</a>
	</footer>
</body>
</html>