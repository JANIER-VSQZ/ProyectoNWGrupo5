<section class="container">
    <section class="depth-2">
        <h2>{{mode}} {{modeDsc}}</h2>
    </section>

    {{if hasErrores}}
    <ul class="error">
        {{foreach errores}}
        <li>{{this}}</li>
        {{endfor errores}}
    </ul>
    {{endif hasErrores}}

    <form action="index.php?page=Usuario-UsuarioForm&mode={{mode}}&usercod={{usercod}}" method="post">
        <div>
            <label for="codigo">Codigo Usuario: </label>
            <input type="number" name="codigo" id="codigo" value="{{usercod}}" {{idReadonly}} {{ifnot readonly}}
                required min="1" {{endifnot readonly}} />
            <input type="hidden" name="xrl8" value="{{token}}" />
        </div>

        <div>
            <label for="correo">Correo: </label>
            <input type="email" name="correo" id="correo" value="{{useremail}}" {{readonly}} {{ifnot readonly}} required
                maxlength="120" {{endifnot readonly}} />
        </div>

        <div>
            <label for="nombre">Nombre: </label>
            <input type="text" name="nombre" id="nombre" value="{{username}}" {{readonly}} {{ifnot readonly}} required
                minlength="3" maxlength="60" {{endifnot readonly}} />
        </div>
        {{ifnot isUpdate}}
        <div>
            <label for="contrasena">Contraseña: </label>
            <input type="text" name="contrasena" id="contrasena" value="{{userpswd}}" readonly />
        </div>
        {{endifnot isUpdate}}
        <div>
            <label for="fechaCreacion">Fecha Creación:</label>
            <input type="text" name="fechaCreacion" id="fechaCreacion" value="{{userfching}}" readonly />
        </div>

        <div>
            <label for="estadoContrasena">Estado Contraseña: </label>
            {{ifnot readonly}}
            <select name="estadoContrasena" id="estadoContrasena">
                <!-- <option value="ACT" {{selectedACT}}>Activo</option>
                <option value="INA" {{selectedINA}}>Inactivo</option> -->
                <option value="ACT" {{selectedPswdACT}}>Activo</option>
                <option value="INA" {{selectedPswdINA}}>Inactivo</option>
            </select>
            {{endifnot readonly}}

            {{if readonly}}
            <input type="text" name="estadoContrasena" id="estadoContrasena" value="{{userpswdest}}" {{readonly}} />
            {{endif readonly}}
        </div>

        <div>
            <label for="fechaExpContrasena">Fecha EXP Contraseña: </label>
            <input type="datetime" name="fechaExpContrasena" id="fechaExpContrasena" value="{{userpswdexp}}" readonly />
        </div>

        <div>
            <label for="estadoUsuario">Estado Usuario: </label>
            {{ifnot readonly}}
            <select name="estadoUsuario" id="estadoUsuario">
                <!-- <option value="ACT" {{selectedACT}}>Activo</option>
                <option value="INA" {{selectedINA}}>Inactivo</option> -->
                <option value="ACT" {{selectedUserACT}}>Activo</option>
                <option value="INA" {{selectedUserINA}}>Inactivo</option>

            </select>
            {{endifnot readonly}}

            {{if readonly}}
            <input type="text" name="estadoUsuario" id="estadoUsuario" value="{{userest}}" {{readonly}} />
            {{endif readonly}}
        </div>
        {{ifnot isUpdate}}
        <div>
            <label for="codigoActivacion">Codigo Activación: </label>
            <input type="text" name="codigoActivacion" id="codigoActivacion" value="{{useractcod}}" readonly />
        </div>

        <div>
            <label for="codigoCambioContrasena">Codigo Cambio Contraseña: </label>
            <input type="text" name="codigoCambioContrasena" id="codigoCambioContrasena" value="{{userpswdchg}}"
                readonly />
        </div>
        {{endifnot isUpdate}}
        <div>
            <label for="tipoUsuario">Tipo de Usuario: </label>
            {{ifnot readonly}}
            <select name="tipoUsuario" id="tipoUsuario">
                <option value="NOR" {{selectedNOR}}>Normal</option>
                <option value="CON" {{selectedCON}}>Consultor</option>
                <option value="CLI" {{selectedCLI}}>Cliente</option>
            </select>
            {{endifnot readonly}}

            {{if readonly}}
            <input type="text" name="tipoUsuario" id="tipoUsuario" value="{{usertipo}}" {{readonly}} />
            {{endif readonly}}
        </div>

        {{if isUpdate}}
        <h3>Roles</h3>

        <div>
            <label for="roles">Rol: </label>
            {{ifnot readonly}}
            <select name="rolescod" id="rolescod">
                {{foreach rol}}
                <option value="{{rolescod}}">{{rolescod}}</option>
                {{endfor rol}}
            </select>
            <button type="submit" name="btnAddRol" value="1">Añadir Rol</button>
            {{endifnot readonly}}

            {{if readonly}}
            <input type="text" name="rolescod" id="rolescod" {{readonly}} value="{{rolescod}}" />
            {{endif readonly}}
        </div>

        {{endif isUpdate}}



        <div>
            <button id="btnCancelar">Cancelar</button>
            {{ifnot isDisplay}}
            <button id="btnConfirmar" type="submit">Confirmar</button>
            {{endifnot isDisplay}}
        </div>



        <h3>Roles asignados</h3>
        <!-- <section class="WWList">
            <table>
                <thead>
                    <tr>
                        <th>UserCod</th>
                        <th>RolCod</th>
                        <th>Descripción</th>
                        <th>Estado</th>
                        <th>Acción</th>
                    </tr>
                </thead>
                <tbody>
                    {{foreach roles_usuario}}
                    <tr>
                        <td>{{usercod}}</td>
                        <td>{{rolescod}}</td>
                        <td>{{rolesdsc}}</td>
                        <td>{{roleuserest}}</td>
                        <button type="submit" name="btnToggleRol" value="1">
                            {{if roleuserest == "ACT"}}Desactivar{{endif}}
                            {{if roleuserest == "INA"}}Activar{{endif}}
                        </button>
                    </tr>
                    {{endfor roles_usuario}}
                </tbody>
            </table>
        </section> -->


        <table border="1">
            <thead>
                <tr>
                    <th>UserCod</th>
                    <th>Código Rol</th>
                    <th>Descripción</th>
                    <th>Estado</th>
                    <th>Acción</th>

                </tr>
            </thead>
            <tbody>
                {{foreach roles_usuario}}
                <tr>
                    <td>{{usercod}}</td>
                    <td>{{rolescod}}</td>
                    <td>{{rolesdsc}}</td>
                    <td>{{roleuserest}}</td>
                    <td>
                        <form method="post" style="display:inline;">
                            <input type="hidden" name="rolescod_" value="{{rolescod}}">
                            <input type="hidden" name="usercod" value="{{usercod}}">

                            <button type="submit" name="btnToggleRol">Cambiar Estado</button>
                        </form>
                    </td>
                </tr>
                {{endfor roles_usuario}}
            </tbody>
        </table>





    </form>
</section>


<script>
    document.addEventListener("DOMContentLoaded", () => {
        document.getElementById("btnCancelar").addEventListener("click", (e) => {
            e.preventDefault();
            e.stopPropagation();
            window.location.assign("index.php?page=Usuario-UsuarioList");
        })
    });
</script>