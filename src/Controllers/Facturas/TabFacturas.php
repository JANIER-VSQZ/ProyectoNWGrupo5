<?php

namespace Controllers\Facturas;

use Controllers\PublicController;
use Dao\Dao;
use Views\Renderer;
Use Dao\Facturas\Facturas as FacturasDao;

class TabFacturas extends PublicController {

    public function run(): void{
        $viewData = [];
        $viewData ["Facturas"] = FacturasDao::obtenerFacturas();
        Renderer::render("Facturas/tabFacturas", $viewData);
    }
}