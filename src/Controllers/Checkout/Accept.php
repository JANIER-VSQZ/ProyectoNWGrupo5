<?php

namespace Controllers\Checkout;

use Controllers\PublicController;
Use Dao\Facturas\Facturas as facturasDao;

class Accept extends PublicController
{
    public function run(): void
    {
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
            if($result->status === "COMPLETED"){
                $orderId=$result->id;
                $captureId = $result->purchase_units[0]->payments->captures[0]->id;
                $nombreCliente = $result->payer->name->given_name;
                $apellidoCliente = $result->payer->name->surname;
                $subtotal = $result->purchase_units[0]->payments->captures[0]->amount->value;
                $impuesto = $result->purchase_units[0]->payments->captures[0]->seller_receivable_breakdown->paypal_fee->value;
                $moneda = $result->purchase_units[0]->payments->captures[0]->amount->currency_code;
                facturasDao::insertarFacturas(
                    $orderId,
                    $captureId,
                    $nombreCliente,
                    $apellidoCliente,
                    $subtotal,
                    $impuesto,
                    $moneda
                );
            }
            $items = $orderDetails->purchase_units[0]->items;
            $dataview["productsjson"] = json_encode($items, JSON_PRETTY_PRINT);
            $dataview["orderjson"] = json_encode($result, JSON_PRETTY_PRINT);
        } else {
            $dataview["orderjson"] = "No Order Available!!!";
        }
        \Views\Renderer::render("paypal/accept", $dataview);
    }
}
