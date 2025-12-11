<?php

namespace Controllers\Cart;

use Controllers\PublicController;
use Utilities\Security;
use Dao\Carretilla\Carretilla as DaoCarretilla;
use Dao\Carretilla\CarretillaAnon as DaoCarretillaAnon;

class Quitar extends PublicController
{
    public function run(): void
    {
        header('Content-Type: application/json; charset=utf-8');

        $productId = intval($_POST["productId"] ?? 0);

        if ($productId <= 0) {
            echo json_encode(["ok" => false, "message" => "Parámetros inválidos"]);
            return;
        }

        if (Security::isLogged()) {
            $userId = Security::getUserId();
            $success = DaoCarretilla::remove($userId, $productId);
            $count = DaoCarretilla::getCountByUser($userId);
        } else {
            $anoncod = DaoCarretillaAnon::ensureAnonCode();
            $success = DaoCarretillaAnon::remove($anoncod, $productId);
            $count = DaoCarretillaAnon::getCountByAnon($anoncod);
        }

        if ($success) {
            echo json_encode(["ok" => true, "count" => intval($count)]);
        } else {
            echo json_encode(["ok" => false, "message" => "No se pudo quitar"]);
        }
    }
}
