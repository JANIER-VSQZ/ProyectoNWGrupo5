<section class="px-4 py-4 depth-2">
    <h2>Listado de Productos</h2>
</section>

<section class="grid">
    <div class="row">
        <div class="col-12 col-m-8 flex align-center">
            <a class="add mg-2" href="index.php?page=Productos-ProductosForm&mode=INS">Agregar Nuevo Producto</a>
            <a class="add" href="index.php?page=Productos-Catalogo">Volver a Catalogo</a>
        </div>
    </div>
</section>

<section class="WWList">
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Nombre</th>
                <th>Imagen URL</th>
                <th>Precio</th>
                <th>Stock</th>
                <th>Estado</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
            {{foreach productos}}
            <tr>
                <td class="center">{{productId}}</td>
                <td>{{productName}}</td>
                <td>{{productImgUrl}}</td>
                <td class="center">{{productPrice}}</td>
                <td class="center">{{productStock}}</td>
                <td class="center">{{productStatusDsc}}</td>
                <td class="center">
                    <a href="index.php?page=Productos-ProductosForm&mode=UPD&productId={{productId}}">Editar</a>&nbsp;
                    <a href="index.php?page=Productos-ProductosForm&mode=DEL&productId={{productId}}">Eliminar</a>
                </td>
            </tr>
            {{endfor productos}}
        </tbody>
    </table>

    {{pagination}}
</section>