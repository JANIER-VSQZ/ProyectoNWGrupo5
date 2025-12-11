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

    <form action="index.php?page=Productos-ProductosForm&mode={{mode}}&productId={{productId}}" method="post">
        {{ifnot isInsert}}
        <div>
            <label for="id">Producto ID: </label>
            <input type="number" name="id" id="id" value="{{productId}}" {{codigoReadonly}} />
        </div>
        {{endifnot isInsert}}

        <div>
            <label for="nombre">Nombre: </label>
            <input type="text" name="nombre" id="nombre" value="{{productName}}" {{readonly}} />
            <input type="hidden" name="xrl8" value="{{token}}" />
        </div>

        <div>
            <label for="descripcion">Descripción: </label>
            <input type="text" name="descripcion" id="descripcion" value="{{productDescription}}" {{readonly}} />
        </div>

        <div>
            <label for="precio">Precio: </label>
            <input type="text" name="precio" id="precio" value="{{productPrice}}" {{readonly}} />
        </div>

        <div>
            <label for="imagen">Imagen URL: </label>
            <input type="text" name="imagen" id="imagen" value="{{productImgUrl}}" {{readonly}} />
        </div>

        <div>
            <label for="stock">Stock: </label>
            <input type="text" name="stock" id="stock" value="{{productStock}}" {{readonly}} />
        </div>


        <div>
            <label for="estado">Estado Producto: </label>
            {{ifnot readonly}}
            <select name="estado" id="estado">
                <option value="ACT" {{selectedACT}}>Activo</option>
                <option value="INA" {{selectedINA}}>Inactivo</option>
            </select>
            {{endifnot readonly}}

            {{if readonly}}
            <input type="text" name="estado" id="estado" value="{{productStatus}}" {{readonly}} />
            {{endif readonly}}
        </div>


        <div>
            <button id="btnCancelar">Cancelar</button>
            {{ifnot isDisplay}}
            <button id="btnConfirmar" type="submit">Confirmar</button>
            {{endifnot isDisplay}}
        </div>
    </form>
</section>

<script>
    document.addEventListener("DOMContentLoaded", () => {
        document.getElementById("btnCancelar").addEventListener("click", (e) => {
            e.preventDefault();
            e.stopPropagation();
            window.location.assign("index.php?page=Productos-ProductosList");
        })
    });
</script>