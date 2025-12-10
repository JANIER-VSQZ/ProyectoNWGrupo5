<?php

namespace Controllers\Checkout;

use Controllers\PublicController;
Use Dao\Facturas\Facturas as facturasDao;
use Dao\Facturas\DetallesFactura;
use Dao\Dao;

class Accept extends PublicController
{
    private string $orderId = "";
    private string $captureId = "";
    private string $nombreCliente = "";
    private string $apellidoCliente = "";
    private float $subtotal = 0.0;
    private float $impuesto = 0.0;
    private string $moneda = "";
    
    public function run(): void
    {
        $conn = Dao::getConn();
        $dataview = array();
        $token = $_GET["token"] ?: "";
        $session_token = $_SESSION["orderid"] ?: "";
        if ($token !== "" && $token == $session_token) {
            $PayPalRestApi = new \Utilities\PayPal\PayPalRestApi(
                \Utilities\Context::getContextByKey("PAYPAL_CLIENT_ID"),
                \Utilities\Context::getContextByKey("PAYPAL_CLIENT_SECRET")
            );
            $result = $PayPalRestApi->captureOrder($session_token);
            $orderDetails = $PayPalRestApi->getOrder($session_token);
            
            $this->orderId = $result->id;
            $this->captureId = $result->purchase_units[0]->payments->captures[0]->id;
            $this->nombreCliente = $result->payer->name->given_name;
            $this->apellidoCliente = $result->payer->name->surname;
            $this->subtotal = $result->purchase_units[0]->payments->captures[0]->amount->value;
            $this->impuesto = $result->purchase_units[0]->payments->captures[0]->seller_receivable_breakdown->paypal_fee->value;
            $this->moneda = $result->purchase_units[0]->payments->captures[0]->amount->currency_code;
            $idFactura;
            if($result->status === "COMPLETED"){

                if(!facturasDao::verificarSiExisteFactura($this->orderId)){
                    facturasDao::insertarFacturas(
                        $this->orderId,
                        $this->captureId,
                        $_SESSION["login"]["userId"],
                        $this->nombreCliente,
                        $this->apellidoCliente,
                        $this->subtotal,
                        $this->impuesto,
                        $this->moneda
                    );
                    $idFactura = $conn->lastInsertId();
                    $items = $orderDetails->purchase_units[0]->items;
                    foreach($items as $item){
                        DetallesFactura::insertarDetalles(
                            $idFactura,
                            $item->name,
                            $item->sku,
                            $item->unit_amount->value,
                            $item->tax->value,
                            $item->quantity,
                            ($item->unit_amount->value*$item->quantity)+($item->quantity*$item->tax->value)
                        );
                    }
                }else{
                    $idFactura=facturasDao::verificarSiExisteFactura($this->orderId)["factura_id"];
                }
                $dataview["idFactura"]=$idFactura;
                $dataview["idUsuario"]=$_SESSION["login"]["userId"];
            }
            
            
            
        } else {
            $dataview["factura"] = "No Order Available!!!";
        }
        \Views\Renderer::render("paypal/accept", $dataview);
    }
}
