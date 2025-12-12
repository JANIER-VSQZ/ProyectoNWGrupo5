<?php

namespace Controllers\Rol;

use Controllers\PublicController;
use Dao\Rol\Rol as DAORol;
use Views\Renderer;
use Utilities\Site;

class RolList extends PublicController
{
    public function run(): void
    {
        Site::addLink("public/css/lists.css");
        $viewData = [];
        $viewData["roles"] = DAORol::obtenerRoles();
        Renderer::render("rol/lista", $viewData);
    }
}
