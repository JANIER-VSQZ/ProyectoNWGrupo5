<h1>Facturas</h1>

<section class="tablaFacturas">
    <table border="1">
        <thead>
            <tr>
                <th>Id</th>
                <th>Id de Orden</th>
                <th>Id Capture</th>
                <th>Fecha</th>
                <th>Id usuario</th>
                <th>Nombre del Cliente</th>
                <th>Apellido del Cliente</th>
                <th>Subtotal</th>
                <th>Impuesto</th>
                <th>Moneda</th>
                <th>Accion</th>
            </tr>
        </thead>
        <tbody>
            {{foreach Facturas}}
            <tr>
                <td>{{factura_Id}}</td>
                <td>{{orderIdPaypal}}</td>
                <td>{{captureIdPaypal}}</td>
                <td>{{fechaFactura}}</td>
                <td>{{usuario_id}}</td>
                <td>{{nombreCliente}}</td>
                <td>{{apellidoCliente}}</td>
                <td>{{total}}</td>
                <td>{{impuesto}}</td>
                <td>{{moneda}}</td>

                <td>
                    <a href="index.php?page=Factura-Factura&idFactura={{factura_Id}}&idUsuario={{usuario_id}}">Ver
                        Detalles</a>
                </td>
            </tr>

            {{endfor Facturas}}
        </tbody>


    </table>
</section>