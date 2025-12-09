<h1>Work With Facturas</h1>

<table border="1">
    <thead>
        <tr>
                    <th>factura_Id</th>
                    <th>orderIdPaypal</th>
                    <th>captureIdPaypal</th>
                    <th>fechaFactura</th>
                    <th>nombreCliente</th>
                    <th>apellidoCliente</th>
                    <th>subtotal</th>
                    <th>impuesto</th>
                    <th>moneda</th>

            <th><a href="index.php?page=Facturas-FormFacturas&mode=INS&codigo=factura_Id">Nuevo</a></th>
        </tr>
    </thead>
    <tbody>
        {{foreach Facturas}}
        <tr>
                    <td>{{factura_Id}}</td>
                    <td>{{orderIdPaypal}}</td>
                    <td>{{captureIdPaypal}}</td>
                    <td>{{fechaFactura}}</td>
                    <td>{{nombreCliente}}</td>
                    <td>{{apellidoCliente}}</td>
                    <td>{{subtotal}}</td>
                    <td>{{impuesto}}</td>
                    <td>{{moneda}}</td>

            <td>
                <a href="index.php?page=Facturas-FormFacturas&mode=UPD&codigo={{factura_Id}}">Editar</a>
                <a href="index.php?page=Facturas-FormFacturas&mode=DEL&codigo={{factura_Id}}">Eliminar</a>
                <a href="index.php?page=Facturas-FormFacturas&mode=DSP&codigo={{factura_Id}}">Ver</a>
            </td>
        </tr>
            
        {{endfor Facturas}}
    </tbody>
    
    
</table>