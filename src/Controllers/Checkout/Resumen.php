<?php

namespace Controllers\Checkout;

use Controllers\PrivateController;
use Utilities\Security;
use Dao\Carretilla\Carretilla as DaoCarretilla;
use Dao\Carretilla\CarretillaAnon as DaoCarretillaAnon;
use Views\Renderer;

class Resumen extends PrivateController
{
    public function run(): void
    {
        $items = [];
        if (Security::isLogged()) {
            $items = DaoCarretilla::getAllByUser(Security::getUserId());
        } else {
            $anoncod = DaoCarretillaAnon::ensureAnonCode();
            $items = DaoCarretillaAnon::getAllByAnon($anoncod);
        }
        Renderer::render("cart/resumen", ["items" => $items]);
    }
}
