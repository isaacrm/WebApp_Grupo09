<%-- 
    Document   : delete
    Created on : 18-nov-2020, 17:29:58
    Author     : rm16034
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>

<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="CSS/estilos.css" type="text/css">      
        <link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/dataTables.bootstrap4.min.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Eliminando Registro</title>
        <style>
            .fila${param.isbn} {background-color:red;color:pink;}
        </style>
    </head>
    <body>
        <!--Conexion a base de datos-->
        <sql:setDataSource var = "fuenteDatos" driver = "org.mariadb.jdbc.Driver"
                           url = "jdbc:mariadb://localhost/biblioteca"
                           user = "root"  password = ""/>
        <!--Fin Conexion a base de datos-->
        <c:set var = "isbn" value = "${param.isbn}"/>
        <div class="container p-3 my-3 bg-light border" id="encabezado">
            <legend class="text-center header">
                <h1>ELIMINANDO REGISTRO</h1>
                <h3>El registro eliminado esta marcado de color rojo en la primera tabla y que en la segunda tabla ya no aparece</h3>
            </legend>
        </div>
        <!--Inicio de tabla original mostrando registro eliminado-->
        <div class="container p-3 my-3 bg-light text-dark border" id="tablaOriginal">
            <div class="table-responsive">
                <legend class="text-center header">
                    <h2>Listado de libros anterior</h2>
                </legend>
                <table class="table" id="tabla">
                    <sql:query dataSource = "${fuenteDatos}" var = "result">
                        SELECT * from libro;
                    </sql:query>
                    <thead class="thead-dark">
                        <tr>
                            <th scope="col">ID</th>
                            <th scope="col">ISBN</th>
                            <th scope="col">Titulo</th>
                            <th scope="col">Editorial</th>
                            <th scope="col">Fecha de Publicación</th>
                            <th scope="col">Autor</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var = "row" items = "${result.rows}">
                            <tr class="table-hover fila${row.isbn}">
                                <th scope="row">
                                    <c:out value = "${row.Id}"/>
                                </th>
                                <td><c:out value = "${row.isbn}"/>
                                </td>
                                <td><c:out value = "${row.titulo}"/></td>
                                <td><c:out value = "${row.editorial}"/>
                                </td>
                                <td><c:out value = "${row.fecha}"/></td>
                                <td><c:out value = "${row.autor}"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <!--Fin de tabla original mostrando registro eliminado-->
        <!--Inicio de consulta para eliminar registro de BD-->
        <sql:update dataSource = "${fuenteDatos}" var = "count">
            DELETE FROM libro WHERE isbn = ?
            <sql:param value = "${isbn}" />
        </sql:update>
        <!--Fin de consulta para eliminar registro de BD-->
        <!--Inicio de tabla actualizada-->
        <div class="container p-3 my-3 bg-light text-dark border" id="tablaModificada">
            <div class="table-responsive">
                <legend class="text-center header">
                    <h2>Listado de libros actualizado</h2>
                </legend>
                <table class="table" id="tabla">
                    <sql:query dataSource = "${fuenteDatos}" var = "result">
                        SELECT * from libro;
                    </sql:query>
                    <thead class="thead-dark">
                        <tr>
                            <th scope="col">ID</th>
                            <th scope="col">ISBN</th>
                            <th scope="col">Titulo</th>
                            <th scope="col">Editorial</th>
                            <th scope="col">Fecha de Publicación</th>
                            <th scope="col">Autor</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var = "row" items = "${result.rows}">
                            <tr class="table-hover">
                                <th scope="row">
                                    <c:out value = "${row.Id}"/>
                                </th>
                                <td><c:out value = "${row.isbn}"/>
                                </td>
                                <td><c:out value = "${row.titulo}"/></td>
                                <td><c:out value = "${row.editorial}"/>
                                </td>
                                <td><c:out value = "${row.fecha}"/></td>
                                <td><c:out value = "${row.autor}"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <h3><a href="index.jsp" style="font-size:1cm;color:blue;">REGRESAR</a></h3>
            </div>
        </div>
        <!--Fin de tabla actualizada-->
    </body>
</html>