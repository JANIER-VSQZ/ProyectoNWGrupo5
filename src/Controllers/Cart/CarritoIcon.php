<?php

namespace Controllers\Cart;

use Controllers\PublicController;
use Utilities\Security;
use Dao\Carretilla\Carretilla as DaoCarretilla;
use Dao\Carretilla\CarretillaAnon as DaoCarretillaAnon;

class CarritoIcon extends PublicController
{
    public function run(): void
    {
        header('Content-Type: application/json; charset=utf-8');

        if (Security::isLogged()) {
            $total = DaoCarretilla::getCountByUser(Security::getUserId());
        } else {
            $anoncod = DaoCarretillaAnon::ensureAnonCode();
            $total = DaoCarretillaAnon::getCountByAnon($anoncod);
        }

        echo json_encode(["ok" => true, "count" => intval($total)]);
    }
}
