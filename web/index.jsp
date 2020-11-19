<%-- 
    Document   : index
    Created on : 18-nov-2020, 2:06:29
    Author     : Grupo 09 - TPI115
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="CSS/estilos.css" type="text/css">      
        <link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/dataTables.bootstrap4.min.css">
        <script src="https://code.jquery.com/jquery-3.3.1.js"></script>
        <script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.10.19/js/dataTables.bootstrap4.min.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Actualizar, eliminar y crear registros</title>
    </head>
    <body>
        <script type="text/javascript" src="JS/metodos.js"></script>
        <!--Conexion a base de datos-->
        <sql:setDataSource var = "fuenteDatos" driver = "org.mariadb.jdbc.Driver"
                           url = "jdbc:mariadb://localhost/biblioteca"
                           user = "root"  password = ""/>
        <!--Fin Conexion a base de datos-->

        <div class="container p-3 my-3 bg-light border" id="formulario">
            <form action="matto.jsp" method="get" name="Actualizar">
                <legend class="text-center header">
                    <a id="home" href=#><H1>MANTENIMIENTO DE LIBROS</H1></a>
                </legend>
                <div class="form-group">
                    <div class="row">
                        <div class="col-md-4"> <!-- ISBN -->
                            <label for="isbn_id" class="control-label">ISBN</label>
                            <input type="text" class="form-control" id="isbn" name="isbn" placeholder="0000000000  ">
                        </div>    

                        <div class="col-md-4"> <!-- Titulo -->
                            <label for="titulo_id" class="control-label">Título</label>
                            <input type="text" class="form-control" id="titulo" name="titulo" placeholder="Ingrese un libro...">
                        </div>                    

                        <div class="col-md-4"> <!-- Autor -->
                            <label for="autor_id" class="control-label">Autor</label>
                            <input type="text" class="form-control" id="autor" name="autor" placeholder="Ingrese un autor...">
                        </div>    
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <div class="col-md-4"> <!-- Editorial -->
                            <label for="editorial_id" class="control-label">Editorial</label>
                            <select class="form-control" id="listaEditorial" name="listaEditorial">
                                <option value= "">Elija su editorial...</option>
                                <optgroup>
                                    <sql:query dataSource = "${fuenteDatos}" var = "editorial">
                                        SELECT editorial from libro;
                                    </sql:query>
                                    <c:forEach var = "row" items = "${editorial.rows}">
                                        <option>
                                            <c:out value = "${row.editorial}"/>
                                        </option>
                                    </c:forEach>
                                </optgroup>
                            </select>                    
                        </div>

                        <div class="col-md-4"> <!-- Fecha Publicacion-->
                            <label for="fechaPublicacion_id" class="control-label">Fecha de Publicación</label>
                            <input type="date" class="form-control" id="fechaPublicacion" name="fechaPublicacion" value="">
                        </div>        
                    </div>
                </div>
                <div class="form-group"> <!-- Boton Insertar -->
                    <input type="hidden" name="Action" value="Crear" checked/>
                    <button id="insertar" type="SUBMIT" name="boton_A" value="INSERTAR" class="btn btn-success"/>INSERTAR</button>
                </div>     
            </form>
        </div>
        <div class="container p-3 my-3 bg-light text-dark border" id="tablaDatos">
            <div class="table-responsive">
                <legend class="text-center header">
                    <h2>Listado de libros</h2>
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
                            <th scope="col">Acción</th>
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
                                <td>
                                    <a id="actualizate" href="frmupdate.jsp?isbn=${row.isbn}&titulo=${row.titulo}&editorial=${row.editorial}&fecha=${row.fecha}&autor=${row.autor}" class="btn btn-warning">Actualizar</a>
                                    <br><a id="eliminate" onclick="eliminar('${row.isbn}')" class="btn btn-danger" >Eliminar</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <a href="#"><div class="up">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>↑</b></div></a>
    </body>
</html>