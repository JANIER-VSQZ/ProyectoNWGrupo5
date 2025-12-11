<?php

namespace Controllers\Facturas;

use Controllers\PublicController;
use Dao\Dao;
use Views\Renderer;
Use Dao\Facturas\Facturas as FacturasDao;
use Dao\Usuario\Usuario;
use Utilities\Site;

class TabFacturas extends PublicController {

    public function run(): void{
        Site::addLink("public/css/tablaFacturas.css");
        $idUsuario=$_SESSION["login"]["userId"];
        $usuario = Usuario::obtenerUsuarioPorCodigo($idUsuario);
        $tipoUsuario = $usuario["usertipo"];
        $viewData = [];
        if($tipoUsuario==='NOR' || $tipoUsuario==='CLI'){
            $viewData ["Facturas"] = FacturasDao::obtenerFacturasPorUsuario($_SESSION["login"]["userId"]);
            Renderer::render("Facturas/tabFacturas", $viewData);
        }else if($tipoUsuario==='CON'){
            $viewData ["Facturas"] = FacturasDao::obtenerFacturas();
            Renderer::render("Facturas/tabFacturas", $viewData);
        }
        
        
    }
}