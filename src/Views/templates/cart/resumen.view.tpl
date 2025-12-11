<h1>Resumen de tu compra</h1>
<section class="WWList">
<table >
    <thead>
        <tr>
            <th>Producto</th>
            <th>Precio Unitario</th>
            <th>Cantidad</th>
            <th>Subtotal</th>
            <th>Acción</th>
        </tr>
    </thead>
    <tbody>
        {{foreach items}}
        <tr data-productid="{{productId}}">
            <td>
                <img src="{{productImgUrl}}" alt="{{productName}}" style="margin-right: 10px;width:60px;height:60px;">
                {{productName}}
            </td>
            <td>{{crrprc}}</td>
            <td>
                <input type="number" class="cart-qty" data-productid="{{productId}}" value="{{crrctd}}" min="1">
            </td>
            <td class="cart-subtotal">{{= crrprc * crrctd }}</td>
            <td><button class="remove-from-cart" data-productid="{{productId}}">Quitar</button></td>
        </tr>
        {{endfor items}}
    </tbody>
</table>
</section>
<form action="index.php?page=checkout_checkout" method="post">
  <button type="submit">Place Order</button>
</form>

<script src="public/js/cart.js"></script>
