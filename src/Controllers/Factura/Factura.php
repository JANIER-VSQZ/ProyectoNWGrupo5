<?php

namespace Controllers\Factura;

use Controllers\PublicController;
Use Dao\Facturas\Facturas as facturasDao;
use Dao\Facturas\DetallesFactura;
use Dao\Dao;
use Views\Renderer;

class Factura extends PublicController{
    public function run():void{
        $idFactura = intval($_GET["idFactura"]);
        $idUsuario = intval($_GET["idUsuario"]);
        $dataview = [];

        if($idUsuario === $_SESSION["login"]["userId"]){
            $factura = facturasDao::obtenerFacturasPorCodigo($idFactura, $idUsuario);
            $detalles = DetallesFactura::obtenerDetalles($idFactura);
            $dataview ["facturaCorrecta"] = true;
                
            $dataview["fechaFactura"] = $factura["fechaFactura"];
            $dataview["nombreUsuario"] = $factura["username"];
            $dataview["nombreCliente"] = $factura["nombreCliente"] . " " . $factura["apellidoCliente"];
                foreach($detalles as $detalle){
                    $dataview["detalles"][] = [
                        "nombreProducto" => $detalle["nombreProducto"],
                        "cantidadProducto" => $detalle["cantidad"],
                        "precioProducto" => $detalle["precio"],
                        "impuestoProducto" => $detalle["impuesto"],
                        "subtotalProducto" => $detalle["subtotal"],
                        "moneda" => $factura["moneda"]
                    ];
                }            
                $dataview["totalFactura"] = $factura["total"];
                $dataview["moneda"]=$factura["moneda"];
        }else{
            $dataview ["facturaCorrecta"] = false;
        }
        
        Renderer::render("Facturas/factura", $dataview);
    }
    
}