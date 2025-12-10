{{if facturaCorrecta}}
<section class="factura">
    <div class="titulo">
        <h2>Hackers</h2>
        <p>Revolucion tecnologica</p>
        <p>Gracias, Lempira</p>
    </div>
    <div class="cuerpo">
        <p>Nombre de Usuario: {{nombreUsuario}}</p>
        <p>Nombre del Cliente: {{nombreCliente}}</p>
        <p>Fecha: {{fechaFactura}}</p>
        <table>
            <thead>
                <tr>
                    <th>Nombre</th>
                    <th>cantidad</th>
                    <th>Precio</th>
                    <th>Impuesto</th>
                    <th>Subtotal</th>
                    <th>Moneda</th>
                </tr>
            </thead>
            <tbody>
                {{foreach detalles}}
                <tr>
                    <td>
                        {{nombreProducto}}
                    </td>
                    <td>
                        {{cantidadProducto}}
                    </td>
                    <td>
                        {{precioProducto}}
                    </td>
                    <td>
                        {{impuestoProducto}}
                    </td>
                    <td>
                        {{subtotalProducto}}
                    </td>
                    <td>
                        {{moneda}}
                    </td>
                </tr>
                {{endfor detalles}}
            </tbody>
        </table>
        
        <p>Total: {{totalFactura}} {{moneda}}</p>
    </div>
</section>
<section class="botones">
    <button><a href="index.php">Regresar a Inicio</a></button>
</section>
{{endif facturaCorrecta}}

{{ifnot facturaCorrecta}}
    <h2>Los datos de usuario no coinciden.</h2>
{{endifnot facturaCorrecta}}

