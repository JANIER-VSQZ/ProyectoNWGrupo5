<div class="nav">
    <nav>
        <ul class="menu">
            <li><a href="index.php?page=Productos-ProductosList"><i class="fa-solid fa-boxes-stacked"></i>Inventario</a></li>
            <li><a href="index.php?page=Productos-ProductosList"><i class="fa-solid fa-store"></i>LOREM</a></li>
        </ul>
    </nav>
</div>

<h1 class="center">Todos Nuestros Productos</h1>

<div class="product-list">
    {{foreach productos}}
    <div class="product-card" data-productId="{{productId}}">
        <img src="{{productImgUrl}}" alt="{{productName}}">

        <div class="product-info">
            <h2>{{productName}}</h2>
            <p>{{productDescription}}</p>
            <span class="price">L. {{productPrice}}</span>
            <span class="stock">Stock: {{productStock}}</span>
            <div class="product-actions">
                <button class="add-to-cart" data-productid="{{productId}}">Agregar al Carrito</button>
            </div>
        </div>
    </div>
    {{endfor productos}}
</div>

<!-- icono del carrito -->
<div id="floating-cart">
    <a href="index.php?page=Checkout_Resumen" id="floating-cart-link" title="Ver Carrito">
        <i class="fa fa-shopping-cart"></i>
        <span id="floating-cart-count">0</span>
    </a>
</div>

<!-- .js para funcionalidad del icono carrito-->
<script src="public/js/cart.js"></script>
<link rel="stylesheet" href="public/css/productos/catalogo.css">