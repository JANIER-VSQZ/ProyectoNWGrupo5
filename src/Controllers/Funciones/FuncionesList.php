<?php

namespace Controllers\Funciones;

use Controllers\PrivateController;
use Dao\Funciones\Funciones as DAOFunciones;
use Views\Renderer;
use Utilities\Site;

class FuncionesList extends PrivateController
{
    public function run(): void
    {
        Site::addLink("public/css/lists.css");
        $viewData = [];
        $viewData["funciones"] = DAOFunciones::obtenerFunciones();
        Renderer::render("funciones/lista", $viewData);
    }
}
