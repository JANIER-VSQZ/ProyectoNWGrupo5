<?php

namespace Controllers\Rol;

use Controllers\PrivateController;
use Dao\Rol\Rol as DAORol;
use Views\Renderer;
use Utilities\Site;

class RolList extends PrivateController
{
    public function run(): void
    {
        Site::addLink("public/css/lists.css");
        $viewData = [];
        $viewData["roles"] = DAORol::obtenerRoles();
        Renderer::render("rol/lista", $viewData);
    }
}
