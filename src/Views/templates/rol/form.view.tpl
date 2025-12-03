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

    <form action="index.php?page=Rol-RolForm&mode={{mode}}&rolescod={{rolescod}}" method="post">
        <div>
            <label for="codigo">Codigo de Rol: </label>
            <input type="text" name="codigo" id="codigo" value="{{rolescod}}" {{idReadonly}} />
            <input type="hidden" name="xrl8" value="{{token}}" />
        </div>

        <div>
            <label for="descripcion">Descripción de Rol: </label>
            <input type="text" name="descripcion" id="descripcion" value="{{rolesdsc}}" {{readonly}} />
        </div>

        <div>
            <label for="estadoRol">Estado de Rol: </label>
            {{ifnot readonly}}
            <select name="estadoRol" id="estadoRol">
                <option value="ACT" {{selectedACT}}>Activo</option>
                <option value="INA" {{selectedINA}}>Inactivo</option>
            </select>
            {{endifnot readonly}}

            {{if readonly}}
            <input type="text" name="estadoRol" id="estadoRol" value="{{rolesest}}" {{readonly}} />
            {{endif readonly}}
        </div>


        <h3>Agregar Funciones al Rol</h3>

        <div>
            <label for="funciones">Función: </label>
            {{ifnot readonly}}
            <select name="fncod" id="fncod">
                {{foreach funciones}}
                <option value="{{fncod}}">{{fncod}}</option>
                {{endfor funciones}}
            </select>
            <button type="submit" name="agregarFuncion" value="1">Añadir Función</button>
            {{endifnot readonly}}

            {{if readonly}}
            <input type="text" name="fncod" id="fncod" {{readonly}} value="{{fncod}}" />
            {{endif readonly}}
        </div>






        <div>
            <button id="btnCancelar">Cancelar</button>
            {{ifnot isDisplay}}
            <button id="btnConfirmar" type="submit">Confirmar</button>
            {{endifnot isDisplay}}
        </div>




        <h3>Funciones Asignadas</h3>
        <table border="1">
            <thead>
                <tr>
                    <th>Código Rol</th>
                    <th>Función</th>
                    <th>Estado</th>
                    {{ifnot readonlyFunciones}}
                    <th>Acciones</th>
                    {{endifnot readonlyFunciones}}
                </tr>
            </thead>
            <tbody>
                {{foreach funcionesAsignadas}}
                <tr>
                    <td>{{rolescod}}</td>
                    <td>{{fncod}}</td>
                    <td>{{fnrolest}}</td>

                    <td>
                        <!-- DEL
                        <form method="post" style="display:inline;" action="index.php?page=Rol-RolForm&mode={{mode}}&rolescod={{rolescod}}">
                            <input type="hidden" name="fncod" value="{{fncod}}">
                            <button type="submit" name="eliminarFuncion">Eliminar</button>
                        </form> -->

                        <!-- EST -->
                        <form method="post" style="display:inline;">
                            <input type="hidden" name="fncod" value="{{fncod}}">
                            <input type="hidden" name="rolescod" value="{{rolescod}}">

                            <button type="submit" name="cambiarEstado">Cambiar Estado</button>
                        </form>
                    </td>
                </tr>
                {{endfor funcionesAsignadas}}
            </tbody>
        </table>


    </form>
</section>


<script>
    document.addEventListener("DOMContentLoaded", () => {
        document.getElementById("btnCancelar").addEventListener("click", (e) => {
            e.preventDefault();
            e.stopPropagation();
            window.location.assign("index.php?page=Rol-RolList");
        })
    });
</script>