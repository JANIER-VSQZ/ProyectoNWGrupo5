<?php

namespace Controllers\Cart;

use Controllers\PublicController;
use Utilities\Security;
use Dao\Carretilla\Carretilla as DaoCarretilla;
use Dao\Carretilla\CarretillaAnon as DaoCarretillaAnon;
use Dao\Productos\Productos as DaoProductos;

class Agregar extends PublicController
{
    public function run(): void
    {
        header('Content-Type: application/json; charset=utf-8');

        $productId = intval($_POST["productId"] ?? 0);
        $qty = intval($_POST["qty"] ?? 1);

        if ($productId <= 0 || $qty <= 0) {
            echo json_encode(["ok" => false, "message" => "Parámetros inválidos"]);
            return;
        }

        if (!DaoProductos::validarStockDisponible($productId, $qty)) {
            echo json_encode(["ok" => false, "message" => "Stock insuficiente"]);
            return;
        }

        $prod = DaoProductos::obtenerProductoPorCodigo((string)$productId);
        if (!$prod) {
            echo json_encode(["ok" => false, "message" => "Producto no existe"]);
            return;
        }
        $unitPrice = floatval($prod["productPrice"]);

        if (Security::isLogged()) {
            $userId = Security::getUserId();
            $success = DaoCarretilla::addOrUpdate($userId, $productId, $qty, $unitPrice);
        } else {
            $anoncod = DaoCarretillaAnon::ensureAnonCode();
            $success = DaoCarretillaAnon::addOrUpdate($anoncod, $productId, $qty, $unitPrice);
        }

        if ($success) {
            if (Security::isLogged()) {
                $total = DaoCarretilla::getCountByUser(Security::getUserId());
            } else {
                $total = DaoCarretillaAnon::getCountByAnon($anoncod = $_SESSION["anon"]["anoncod"]);
            }
            echo json_encode(["ok" => true, "count" => intval($total)]);
            return;
        } else {
            echo json_encode(["ok" => false, "message" => "No se pudo agregar al carrito"]);
            return;
        }
    }
}
