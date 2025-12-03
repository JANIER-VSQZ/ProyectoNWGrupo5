<section class="px-4 py-4 depth-2">
    <h2>Listado de Usuarios</h2>
</section>

<section class="WWList">
    <table>
        <thead>
            <tr>
                <th>Codigo Usuario</th>
                <th>Correo</th>
                <th>Nombre</th>
               
                <th>Fecha Creación</th>
                <th>Estado Contraseña</th>
                <th>Fecha EXP Contraseña</th>
                <th>Estado Usario</th>
               
                <th>Codigo Cambio Contraseña</th>
                <th>Tipo Usario</th>
                <th><a href="index.php?page=Sec-Register">Nuevo Usuario</a></th>
            </tr>
        </thead>

        <tbody>
            {{foreach usuario}}
            <tr>
                <td>{{usercod}}</td>
                <td>{{useremail}}</td>
                <td>{{username}}</td>
                
                <td>{{userfching}}</td>
                <td>{{userpswdest}}</td>
                <td>{{userpswdexp}}</td>
                <td>{{userest}}</td>
               
                <td>{{userpswdchg}}</td>
                <td>{{usertipo}}</td>
                <td>
                    <a href="index.php?page=Usuario-UsuarioForm&mode=UPD&usercod={{usercod}}">Editar</a>&nbsp;
                    <a href="index.php?page=Usuario-UsuarioForm&mode=DEL&usercod={{usercod}}">Eliminar</a>&nbsp;
                    <a href="index.php?page=Usuario-UsuarioForm&mode=DSP&usercod={{usercod}}">Ver</a>
                </td>
            </tr>
            {{endfor usuario}}
        </tbody>
    </table>
</section>