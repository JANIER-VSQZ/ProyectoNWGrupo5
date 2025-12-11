<?php

namespace Controllers\Productos;

use Controllers\PublicController;
use Dao\Productos\Productos as DAOProductos;
use Utilities\Site;
use Views\Renderer;

class Catalogo extends PublicController
{
    public function run(): void
    {
        Site::addLink("public/css/productos/catalogo.css");
        $viewData = [];
        $viewData["productos"] = DAOProductos::obtenerProductos();
        // $productosTemp = DAOProductos::obtenerProductos();

        // $productosConEstado = [];
        // if (is_array($productosTemp)) {
        //     foreach ($productosTemp as $prod) {
        //         $status = isset($prod["productStatus"]) ? $prod["productStatus"] : null;
        //         $prod["estado"] = ($status === "ACT") ? "Activo" : "Inactivo";
        //         $productosConEstado[] = $prod;
        //     }
        // }
        // $viewData["productos"] = $productosConEstado;
        Renderer::render("productos/productoscatalogo", $viewData);
    }
}
