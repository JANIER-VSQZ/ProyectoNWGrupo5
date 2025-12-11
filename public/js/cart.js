document.addEventListener("DOMContentLoaded", () => {
    function actualizarIconoCarrito(count) {
        const cartCount = document.getElementById("floating-cart-count");
        if (cartCount) cartCount.textContent = count;
    }

    function cambiarBotonEstado(btn, inCart) {
        if (inCart) {
            btn.textContent = "En Carrito";
            btn.classList.add("in-cart");
        } else {
            btn.textContent = "Agregar";
            btn.classList.remove("in-cart");
        }
    }

    //Para agregar o quitar los productos
    document.querySelectorAll(".add-to-cart").forEach(btn => {
        btn.addEventListener("click", async (e) => {
            e.preventDefault();
            const productId = btn.dataset.productid;
            if (!productId) return alert("Producto no válido");

            try {
                const formData = new FormData();
                formData.append("productId", productId);
                formData.append("qty", 1);

                const response = await fetch("index.php?page=Cart_Agregar", {
                    method: "POST",
                    body: formData
                });
                const data = await response.json();

                if (data.ok) {
                    actualizarIconoCarrito(data.count);
                    cambiarBotonEstado(btn, true);
                } else {
                    alert(data.message || "No se pudo agregar al carrito");
                }

            } catch (err) {
                console.error(err);
                alert("Error de conexión al servidor");
            }
        });
    });

    // para cambiar la cantida en la vista de resumen
    document.addEventListener("change", async (e) => {
        if (e.target && e.target.classList.contains("cart-qty")) {
            const productId = e.target.dataset.productid;
            const qty = parseInt(e.target.value) || 1;

            try {
                const formData = new FormData();
                formData.append("productId", productId);
                formData.append("qty", qty);

                const response = await fetch("index.php?page=Cart_UpdateQty", {
                    method: "POST",
                    body: formData
                });

                const data = await response.json();

                if (data.ok) {
                    const row = document.querySelector(`tr[data-productid="${productId}"]`);
                    if (row) {
                        const price = parseFloat(row.querySelector("td:nth-child(2)").textContent);
                        const subtotalCell = row.querySelector(".cart-subtotal");
                        if (subtotalCell) subtotalCell.textContent = (price * qty).toFixed(2);
                    }
                    actualizarIconoCarrito(data.count);

                    const addBtn = document.querySelector(`.add-to-cart[data-productid="${productId}"]`);
                    if (addBtn) cambiarBotonEstado(addBtn, qty > 0);
                } else {
                    alert(data.message || "No se pudo actualizar la cantidad");
                }

            } catch (err) {
                console.error(err);
                alert("Error al actualizar cantidad");
            }
        }
    });

    // Para quitar el producto desde la vista de reusmen 
    document.addEventListener("click", async (e) => {
        if (e.target && e.target.classList.contains("remove-from-cart")) {
            const productId = e.target.dataset.productid;
            if (!productId) return;

            try {
                const formData = new FormData();
                formData.append("productId", productId);

                const response = await fetch("index.php?page=Cart_UpdateQty", {
                    method: "POST",
                    body: formData
                });

                const data = await response.json();

                if (data.ok) {
                    // Elimina la fila de la vista resumen "o eso deberia, no lo hace actualmente"
                    const row = document.querySelector(`tr[data-productid="${productId}"]`);
                    if (row) row.remove();
                    actualizarIconoCarrito(data.count);

                    const addBtn = document.querySelector(`.add-to-cart[data-productid="${productId}"]`);
                    if (addBtn) cambiarBotonEstado(addBtn, false);
                } else {
                    alert(data.message || "No se pudo quitar el producto");
                }

            } catch (err) {
                console.error(err);
                alert("Error al quitar producto");
            }
        }
    });

    async function cargarIconoInicial() {
        try {
            const response = await fetch("index.php?page=Cart_CarritoIcon");
            const data = await response.json();
            if (data.ok) actualizarIconoCarrito(data.count);
        } catch (err) {
            console.error(err);
        }
    }

    cargarIconoInicial();

});