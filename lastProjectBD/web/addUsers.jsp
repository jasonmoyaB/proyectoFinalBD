<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="styles/styleaddUsers.css"/>
        <title>Agregar Usuarios</title>
    </head>
    <body>
        <header>
            <nav class="nav">
                <ul>
                    <a class="logo" href="">CODINGRAPH;</a>
                    <a class="nav-link" href="login.jsp">Log-out</a>
                </ul>
            </nav>
        </header>

        <h2>Agregar Usuario</h2>
    <form action="AgregarUsuarioServlet" method="post">
        <table>
            <tr>
                <th>ID</th>
                <th>NOMBRES</th>
                <th>CORREO</th>
                <th>TELEFONO</th>
                <th>ROL (ID)</th>
                <th>DEPARTAMENTO (ID)</th>
                <th>ACCIONES</th>
            </tr>
            <tr>
                <td><input type="text" name="id" required></td>
                <td><input type="text" name="nombre" required></td>
                <td><input type="email" name="correo" required></td>
                <td><input type="text" name="telefono" required></td>
                <td><input type="text" name="rol" required></td>
                <td><input type="text" name="departamento" required></td>
                <td>
                    <button type="submit">Agregar Usuario</button>
                </td>
            </tr>
        </table>
    </form>

    <h2>Usuarios Registrados</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>NOMBRES</th>
            <th>CORREO</th>
            <th>TELEFONO</th>
            <th>ROL</th>
            <th>DEPARTAMENTO</th>
            <th>ACCIONES</th>
        </tr>
        <tr>
            <td>1</td>
            <td>Usuario01</td>
            <td>usuario@gmail.com</td>
            <td>988253459</td>
            <td>1</td> <!-- ID Rol -->
            <td>1</td> <!-- ID Departamento -->
            <td>
                <button>Editar</button>
                <button>Eliminar</button>
            </td>
        </tr>
        <tr>
            <td>2</td>
            <td>Usuario02</td>
            <td>usuario2@gmail.com</td>
            <td>24354354</td>
            <td>2</td>
            <td>1</td>
            <td>
                <button>Editar</button>
                <button>Eliminar</button>
            </td>
        </tr>
        <tr>
            <td>3</td>
            <td>Usuario03</td>
            <td>usuario3@gmail.com</td>
            <td>24432312</td>
            <td>1</td>
            <td>2</td>
            <td>
                <button>Editar</button>
                <button>Eliminar</button>
            </td>
        </tr>
    </table>
    </body>
</html>

