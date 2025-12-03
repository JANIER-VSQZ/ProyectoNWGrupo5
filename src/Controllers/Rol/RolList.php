<?php

namespace Controllers\Rol;

use Controllers\PublicController;
use Dao\Rol\Rol as DAORol;
use Views\Renderer;

class RolList extends PublicController
{
    public function run(): void
    {
        $viewData = [];
        $viewData["roles"] = DAORol::obtenerRoles();
        Renderer::render("rol/lista", $viewData);
    }
}
