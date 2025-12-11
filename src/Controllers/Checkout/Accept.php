<?php

namespace Controllers\Checkout;

use Controllers\PrivateController;
use Dao\Facturas\Facturas as facturasDao;
use Dao\Facturas\DetallesFactura;
use Dao\Dao;

//
use Dao\Productos\Productos as DAOProductos;

class Accept extends PrivateController
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
            // $this->impuesto = $result->purchase_units[0]->payments->captures[0]->seller_receivable_breakdown->paypal_fee->value;
            $this->impuesto = $this->subtotal * 0.15; //impuesto sobre venta
            $this->moneda = $result->purchase_units[0]->payments->captures[0]->amount->currency_code;
            $idFactura;
            if ($result->status === "COMPLETED") {

                if (!facturasDao::verificarSiExisteFactura($this->orderId)) {
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
                    foreach ($items as $item) {
                        DetallesFactura::insertarDetalles(
                            $idFactura,
                            $item->name,
                            $item->sku,
                            $item->unit_amount->value,
                            $item->tax->value,
                            $item->quantity,
                            ($item->unit_amount->value * $item->quantity) + ($item->quantity * $item->tax->value),
                            //
                            DAOProductos::restarStock($item->sku, $item->quantity)
                        );
                    }
                } else {
                    $idFactura = facturasDao::verificarSiExisteFactura($this->orderId)["factura_id"];
                }
                $dataview["idFactura"] = $idFactura;
                $dataview["idUsuario"] = $_SESSION["login"]["userId"];


                //////CARRITO TEMPORAL
                // Si fue usuario logueado, vaciamos su carretilla
                if (isset($_SESSION["login"]) && isset($_SESSION["login"]["userId"])) {
                    \Dao\Carretilla\Carretilla::clear($_SESSION["login"]["userId"]);
                } else {
                    // si era anon, limpiar carretillaanon
                    if (isset($_SESSION["anon"]["anoncod"])) {
                        \Dao\Carretilla\CarretillaAnon::clear($_SESSION["anon"]["anoncod"]);
                    }
                }
            }
        } else {
            $dataview["factura"] = "No Order Available!!!";
        }
        \Views\Renderer::render("paypal/accept", $dataview);
    }
}
