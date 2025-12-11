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
                <button class="add-to-cart">Agregar al Carrito</button>
            </div>
        </div>
    </div>
    {{endfor productos}}
</div>