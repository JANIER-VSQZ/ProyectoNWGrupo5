<?php

namespace Controllers\Funciones;

use Controllers\PublicController;
use Dao\Funciones\Funciones as DAOFunciones;
use Views\Renderer;
use Utilities\Site;

class FuncionesList extends PublicController
{
    public function run(): void
    {
        Site::addLink("public/css/lists.css");
        $viewData = [];
        $viewData["funciones"] = DAOFunciones::obtenerFunciones();
        Renderer::render("funciones/lista", $viewData);
    }
}
