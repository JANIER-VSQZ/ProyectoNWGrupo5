<section class="container"> 
    <section class="depth-2 container-m row px-4 py-4">
        <h2>{{mode}} {{modeDsc}}</h2>
    </section>

    {{if hasErrores}}
    <ul class="error">
        {{foreach errores}}
        <li>{{this}}</li>
        {{endfor errores}}
    </ul>
    {{endif hasErrores}}
    <!-- <section class="container-m row px-4 py-4"> -->
        <form action="index.php?page=Rol-RolForm&mode={{mode}}&rolescod={{rolescod}}" method="post">
            <div class="row my-2 align-center">
                <label for="codigo" class="col-12 col-m-3">Codigo de Rol: </label>
                <input type="text" name="codigo" id="codigo" value="{{rolescod}}" {{idReadonly}} class="col-12 col-m-9" />
                <input type="hidden" name="xrl8" value="{{token}}" />
            </div>

            <div class="row my-2 align-center">
                <label for="descripcion" class="col-12 col-m-3">Descripción de Rol: </label>
                <input type="text" name="descripcion" id="descripcion" value="{{rolesdsc}}" {{readonly}}
                    class="col-12 col-m-9" />
            </div>

            <div class="row my-2 align-center">
                <label for="estadoRol" class="col-12 col-m-3">Estado de Rol: </label>
                {{ifnot readonly}}
                <select name="estadoRol" id="estadoRol">
                    <option value="ACT" {{selectedACT}}>Activo</option>
                    <option value="INA" {{selectedINA}}>Inactivo</option>
                </select>
                {{endifnot readonly}}

                {{if readonly}}
                <input type="text" name="estadoRol" id="estadoRol" value="{{rolesest}}" {{readonly}}
                    class="col-12 col-m-9" />
                {{endif readonly}}
            </div>


            <h3 class="py-4">Agregar Funciones al Rol</h3>

            <div class="row my-2 align-center">
                <label for="funciones" class="col-12 col-m-3">Función: </label>
                {{ifnot readonly}}
                <select name="fncod" id="fncod">
                    {{foreach funciones}}
                    <option value="{{fncod}}">{{fncod}}</option>
                    {{endfor funciones}}
                </select>
                <button type="submit" name="agregarFuncion" value="1" class="col-12 col-m-2">Añadir Función</button>
                {{endifnot readonly}}

                {{if readonly}}
                <input type="text" name="fncod" id="fncod" {{readonly}} value="{{fncod}}" class="col-12 col-m-9" />
                {{endif readonly}}
            </div>






            <div class="row my-2 align-center">
                <button id="btnCancelar" class="primary col-12 col-m-2">Cancelar</button>
                {{ifnot isDisplay}}
                <button id="btnConfirmar" type="submit" class="primary col-12 col-m-2">Confirmar</button>
                {{endifnot isDisplay}}
            </div>



            <section class="WWList">
                <h3>Funciones Asignadas</h3>
                <table>
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
                                    <input type="hidden" name="fncod_" value="{{fncod}}">
                                    <input type="hidden" name="rolescod" value="{{rolescod}}">

                                    <button type="submit" name="cambiarEstado">Cambiar Estado</button>
                                </form>
                            </td>
                        </tr>
                        {{endfor funcionesAsignadas}}
                    </tbody>
                </table>
            </section>

        </form>
    <!-- </section> -->
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