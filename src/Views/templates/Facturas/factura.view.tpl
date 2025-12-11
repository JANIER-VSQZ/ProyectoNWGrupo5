{{if facturaCorrecta}}
<section class="fondoFactura">
    <section class="factura">
        <div class="encabezadoFactura">
            <div class="infoEmpresa">
                <div class="logoFactura">
                    <img src="public/imgs/logo.jpg">
                </div>
                <div>
                    <h2>HACKERS</h2>
                    <p>Revolucion tecnologica</p>
                    <p>Gracias, Lempira</p>
                </div>
            </div>
            <div class="infoFactura">
                <p>Factura No. {{orderId}}</p>
                <p>Fecha: {{fechaFactura}}</p>
            </div>
            
        </div>
        <div class="datosFactura">
            <div class="tarjeta">
                <p><strong>Facturar a:</strong></p>
                <p>Nombre de Usuario: {{nombreUsuario}}</p>
                <p>Nombre del Pagador: {{nombreCliente}}</p>
                <p>Correo: {{email}}</p>
            </div>
            
        </div>
        <div class="cuerpofactura">
            <p>Detalles de compra:</p>
            <table>
                <thead>
                    <tr>
                        <th style="width:30%;">Nombre</th>
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
                        <td style="text-align: left;">
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
        </div>
        
        <div class="tarjetasMovil">
            <p class="label"><strong>Detalles de compra: </strong></p>
            {{foreach detalles}}
                <div class="tarjeta">
                    <p>Nombre Producto: {{nombreProducto}}</p>
                    <p>Cantidad: {{cantidadProducto}}</p>
                    <p>Precio: {{precioProducto}} {{Moneda}}</p>
                    <p>Impuesto: {{ImpuestoProducto}} {{Moneda}}</p>
                    <p>Subtotal: {{subtotalProducto}} {{Moneda}}</p>
                </div>
            {{endfor detalles}}
        </div>
        <div class="total" >
            <div class="tarjeta">
                <p>Subtotal: {{subtotalFactura}} {{moneda}} Impuesto: {{impuestoFactura}} {{moneda}}</p>
                <p>Total: {{totalFactura}} {{moneda}}</p>
            </div>
        </div>
        <div class="botones">
            <button><a href="index.php">Regresar a Inicio</a></button>
        </div>
    </section>



    {{endif facturaCorrecta}}

    {{ifnot facturaCorrecta}}
    <h2>Los datos de usuario no coinciden.</h2>
    {{endifnot facturaCorrecta}}
</section>