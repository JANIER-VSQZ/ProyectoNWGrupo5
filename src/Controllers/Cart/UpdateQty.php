<?php

namespace Controllers\Cart;

use Controllers\PublicController;
use Utilities\Security;
use Dao\Carretilla\Carretilla as DaoCarretilla;
use Dao\Carretilla\CarretillaAnon as DaoCarretillaAnon;
use Dao\Productos\Productos as DaoProductos;

class UpdateQty extends PublicController
{
    public function run(): void
    {
        header('Content-Type: application/json; charset=utf-8');
        $productId = intval($_POST["productId"] ?? 0);
        $qty = intval($_POST["qty"] ?? 1);

        if ($productId <= 0 || $qty < 0) {
            echo json_encode(["ok" => false, "message" => "Parámetros inválidos"]);
            return;
        }

        if (Security::isLogged()) {
            $userId = Security::getUserId();
            $success = DaoCarretilla::updateQuantity($userId, $productId, $qty);
            $count = DaoCarretilla::getCountByUser($userId);
        } else {
            $anoncod = DaoCarretillaAnon::ensureAnonCode();
            if ($qty <= 0) {
                $success = DaoCarretillaAnon::remove($anoncod, $productId);
            } else {
                DaoCarretillaAnon::remove($anoncod, $productId);
                $prod = DaoProductos::obtenerProductoPorCodigo((string)$productId);
                $success = DaoCarretillaAnon::addOrUpdate($anoncod, $productId, $qty, floatval($prod["productPrice"]));
            }
            $count = DaoCarretillaAnon::getCountByAnon($anoncod);
        }

        if ($success) {
            echo json_encode(["ok" => true, "count" => intval($count)]);
        } else {
            echo json_encode(["ok" => false, "message" => "No se pudo actualizar cantidad"]);
        }
    }
}
