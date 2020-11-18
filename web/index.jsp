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
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <title>Actualizar, eliminar y crear registros</title>

      <style type="text/css">
h1{
  padding-top: 10px;
  text-align: center;
  color:black;
}

#formulario{
border: black 1px solid;
display:inline-block;
padding:1%;
border-radius: 5px;
padding-bottom: 0%;
background-color: #4F71E1;
}

body{
  background-color: #BCBECF;
  color:white;
}

#campo{
padding-left: 1%;
padding-bottom: 1%;
}

.up{
  background:#4F71E1;
  color:white;
  bottom:1%;
  display:flex;
  height:50px;
  position:fixed;
  right:1%;
  width:50px;
  border-radius: 100%;
  align-items:center;
  border: black 0.5px solid;}

.up:hover{background:#808082;}

#insertar{
  display:block;
  position: relative;
  margin-top: 1%;
  margin-bottom: 2%;
  }

#insertar,#registro,#actualizate,#eliminate{background-color: #C4BED4;}

#actualizate,#eliminate{
  border:black 0.5px solid;
  height: 100%;
  background-color: #C4BED4;
  width:100%;
  padding-left:10px;
  padding-right:10px;
  padding-left:6px;
  padding-right:6px;
  border-radius: 5px;
  position: relative;
  display: block;}

input,select{
  border-radius: 3px;
  border: black 0.5px solid;}

#busqueda:hover,#insertar:hover{background-color: #A6ACD3;}

#actualizate:hover{
  background-color: #A8D3A6;
  color:black;
  cursor:pointer;}

#eliminate:hover{
  background-color: #D3A6A6;
  color:black;
  cursor:pointer;}

#tabla{
  background-color: #9DA9F4;
  text-align: center;
  display: inline-block;
  position: relative;
  display: inline-flex;
  color:black;}

#tabla td{
padding:1%;
border:black 0.5 solid;}

a{color:black;}

a:hover{
  text-decoration:none;
  color:blue;}

#lista{
  position:relative;
  display:block;
  top:1%;
  color:black;}

h2{
  color:black;
  text-align: center;}

h1:hover{color:blue;}

        </style>

   </head>
   <body>
       <sql:setDataSource var = "fuenteDatos" driver = "org.mariadb.jdbc.Driver"
                           url = "jdbc:mariadb://localhost:3308/biblioteca"
                           user = "root"  password = ""/>
      <br><a id="home" href=insert.jsp><H1>MANTENIMIENTO DE LIBROS</H1></a><br><center><div id="formulario">
      <form action="matto.jsp" method="get" name="Actualizar">
         <table>
            <tr>
               <td>ISBN:</td><td id="campo"><input type="text" name="isbn" value="" size="50" placeholder="&nbsp;0000000000"/></td>
            </tr>
            <tr>
               <td id="title">Título:</td><td id="campo"><input type="text" name="titulo" value="" size="50" placeholder="&nbsp;Ingrese un libro..."/></td>
            </tr>
            <!--INICIO DE AGREGADO POR EJERCICIO 5 (Campo Autor)-->
            <tr>
               <td>Autor:</td><td id="campo"><input type="text" name="autor" value="" size="50" placeholder="&nbsp;Ingrese un autor..."/></td>
            </tr>
            <!--FIN DE AGREGADO POR EJERCICIO 5-->
            <!-- listbox de editorial ejerciocio 7 */ -->
            <!------------------------------ comienzo de corrrecion ------------------->
            <tr>
               <td>Editorial:</td><td id="campo">
                  <select name="listaEditorial" >
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
               </td>
            </tr>
            <!------------------------------ fin  de corrrecion               ------------------->
            <!------------------------------ comienzo de corrrecion               ------------------->
            <tr>
               <td>
                  <label>Fecha de publicación: </label></td><td id="campo">
                  <input type="date" name="Anio" value="">
               </td>
            <!------------------------------ fin de corrrecion               ------------------->
         </table><div><center>
               <input type="hidden" name="Action" value="Crear" checked/>
               <input id="insertar" type="SUBMIT" name="boton_A" value="INSERTAR"/>
             </center></div>
      </form>
      </div></center>
<br><h2>Listado de libros</h2>
      <div id="lista">
            <sql:query dataSource = "${fuenteDatos}" var = "result">
            SELECT * from libro;
            </sql:query>
               <center><table id="tabla" border="1"><tr style='background-color:#767A93;'><td>ID</td><td>ISBN</td><td id=\"title\">Título</td><td>Editorial</td><td>Fecha de publicación</td><td>Autor</td><td>Acción</td></tr>
            <c:forEach var = "row" items = "${result.rows}">
                        <tr><td>
                    <c:out value = "${row.Id}"/>
                    </td>
                    <td><c:out value = "${row.isbn}"/>
                    </td>
                    <td><c:out value = "${row.titulo}"/></td>
                    <td><c:out value = "${row.editorial}"/>
                    </td>
                    <td><c:out value = "${row.fecha}"/></td>
                    <td><c:out value = "${row.autor}"/></td>
                    <td>
                    <a id="actualizate" href="frmupdate.jsp?isbn=${row.isbn}&titulo=${row.titulo}&editorial=${row.editorial}&fecha=${row.fecha}&autor=${row.autor}" style="width:100%">Actualizar</a>
                    <br><a id="eliminate" href="delete.jsp?Action=Eliminar&isbn=${row.isbn}&boton_A=ACEPTAR" style="width:100%;">Eliminar</a>
                    </td>
                </tr>
            </c:forEach>
        </table></div>
<a href="#"><div class="up">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>↑</b></div></a><br>
   </body>
</html>
