<?php

namespace Controllers\Factura;

use Controllers\PrivateController;
Use Dao\Facturas\Facturas as facturasDao;
use Dao\Facturas\DetallesFactura;
use Dao\Dao;
use Views\Renderer;
use Utilities\Site;
use Utilities\Security;
use Dao\Usuario\Usuario;
use Dao\Security\UsuarioTipo;

class Factura extends PrivateController{
    public function run():void{
        Site::addLink("public/css/factura.css");
        $idFactura = intval($_GET["idFactura"]);
        $idUsuario = intval($_GET["idUsuario"]);
        $idUsuarioLogged=Security::getUserId();
        $dataview = [];
        $impuesto=0;
        $subtotal=0;
        $usuario=Usuario::obtenerUsuarioPorCodigo($idUsuarioLogged);


        if($idUsuario === $idUsuarioLogged || $usuario["usertipo"]===UsuarioTipo::AUDITOR || $usuario["usertipo"]===UsuarioTipo::ADMINITRADAOR){
            $factura = facturasDao::obtenerFacturasPorCodigo($idFactura, $idUsuario);
            $detalles = DetallesFactura::obtenerDetalles($idFactura);
            $dataview ["facturaCorrecta"] = true;
            $dataview ["orderId"] = $factura["orderIdPaypal"];
            $dataview ["fechaFactura"] = $factura["fechaFactura"];
            $dataview ["nombreUsuario"] = $factura["username"];
            $dataview ["nombreCliente"] = $factura["nombreCliente"] . " " . $factura["apellidoCliente"];
            $dataview ["email"] = $_SESSION["login"]["userEmail"];
            $dataview ["impuestoFactura"]=0;
            $dataview ["subtotalFactura"]=0;

                foreach($detalles as $detalle){
                    $dataview["detalles"][] = [
                        "nombreProducto" => $detalle["nombreProducto"],
                        "cantidadProducto" => $detalle["cantidad"],
                        "precioProducto" => $detalle["precio"],
                        "impuestoProducto" => $detalle["impuesto"],
                        "subtotalProducto" => $detalle["subtotal"],
                        "moneda" => $factura["moneda"]
                    ];
                    $dataview["impuestoFactura"]+=($detalle["impuesto"]*$detalle["cantidad"]);
                    $dataview["subtotalFactura"]+=($detalle["precio"]*$detalle["cantidad"]);
                }            
                $dataview["totalFactura"] = $factura["total"];
                $dataview["moneda"]=$factura["moneda"];
        }else{
            $dataview ["facturaCorrecta"] = false;
        }
        
        Renderer::render("Facturas/factura", $dataview);
    }
    
}