<?php

namespace Controllers\Usuario;

use Controllers\PrivateController;
use Dao\Usuario\Usuario as DAOUsuario;
use Views\Renderer;
use Utilities\Site;

class UsuarioList extends PrivateController
{
    public function run(): void
    {
        Site::addLink("public/css/lists.css");
        $viewData = [];
        $viewData["usuario"] = DAOUsuario::obtenerUsuarios();
        Renderer::render("usuario/lista", $viewData);
    }
}
