<?php

namespace Controllers\Checkout;

use Controllers\PrivateController;


///
use Utilities\Security;
use Dao\Carretilla\Carretilla as DaoCarretilla;
use Dao\Carretilla\CarretillaAnon as DaoCarretillaAnon;
use Dao\Productos\Productos as DaoProductos;

class Checkout extends PrivateController
{

    public function run(): void
    {
        $viewData = array();

        if ($this->isPostBack()) {

            // Obtener items del carrito
            $items = [];
            if (Security::isLogged()) {
                $items = DaoCarretilla::getAllByUser(Security::getUserId());
            } else {
                $anoncod = DaoCarretillaAnon::ensureAnonCode();
                $items = DaoCarretillaAnon::getAllByAnon($anoncod);
            }

            if (!is_array($items) || count($items) == 0) {
                $viewData["error"] = "Carrito vacío";
                \Views\Renderer::render("paypal/checkout", $viewData);
                return;
            }

            $total = 0.0;

            $PayPalOrder = new \Utilities\Paypal\PayPalOrder(
                "order-" . time(),
                "http://localhost:8080/ProyectoNWGrupo5/index.php?page=Checkout_Error",
                "http://localhost:8080/ProyectoNWGrupo5/index.php?page=Checkout_Accept"
            );

            foreach ($items as $it) {

                $name = $it["productName"];
                $sku = $it["productId"];
                $unitPrice = floatval($it["crrprc"]);

                // Cantidad del carrito
                $quantity = intval($it["crrctd"]);
                if ($quantity <= 0) {
                    $quantity = 1;
                }

                // impuesto sobre venta
                $tax = round($unitPrice * 0.15, 2);

                $total += ($unitPrice * $quantity);

                $PayPalOrder->addItem(
                    $name,
                    $name,
                    $sku,
                    $unitPrice,
                    $tax,
                    $quantity,
                    "PHYSICAL_GOODS"
                );
            }

            $PayPalRestApi = new \Utilities\PayPal\PayPalRestApi(
                \Utilities\Context::getContextByKey("PAYPAL_CLIENT_ID"),
                \Utilities\Context::getContextByKey("PAYPAL_CLIENT_SECRET")
            );
            $PayPalRestApi->getAccessToken();
            $response = $PayPalRestApi->createOrder($PayPalOrder);

            $_SESSION["orderid"] = $response->id;
            foreach ($response->links as $link) {
                if ($link->rel == "approve") {
                    \Utilities\Site::redirectTo($link->href);
                }
            }
            die();
        }

        \Views\Renderer::render("paypal/checkout", $viewData);
    }
}
