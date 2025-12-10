<h1>Work With Facturas</h1>

<table border="1">
    <thead>
        <tr>
                    <th>factura_Id</th>
                    <th>orderIdPaypal</th>
                    <th>captureIdPaypal</th>
                    <th>fechaFactura</th>
                    <th>id usuario</th>
                    <th>nombreCliente</th>
                    <th>apellidoCliente</th>
                    <th>subtotal</th>
                    <th>impuesto</th>
                    <th>moneda</th>
                    <th>accion</th>
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
                <a href="index.php?page=Factura-Factura&idFactura={{factura_Id}}&idUsuario={{usuario_id}}">Ver Detalles</a>
            </td>
        </tr>
            
        {{endfor Facturas}}
    </tbody>
    
    
</table>