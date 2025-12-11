<?php

namespace Controllers\Productos;

use Controllers\PrivateController;
use Dao\Productos\Productos as DAOProductos;
use Utilities\Site;
use Utilities\Paging;
use Views\Renderer;

class ProductosList extends PrivateController
{
    private $pageNumber = 1;
    private $itemsPerPage = 10;
    private $productos = [];
    private $productosCount = 0;
    private $pages = 0;
    private $viewData = [];

    public function run(): void
    {
        Site::addLink("public/css/productos/productoslist.css");
        $this->getParams();

        $tmp = DAOProductos::getProductos(
            "",
            $this->pageNumber - 1,
            $this->itemsPerPage
        );

        $this->productos = $tmp["productos"];
        $this->productosCount = $tmp["total"];

        $this->pages = $this->productosCount > 0
            ? ceil($this->productosCount / $this->itemsPerPage)
            : 1;

        if ($this->pageNumber > $this->pages) {
            $this->pageNumber = $this->pages;
        }

        $this->viewData["productos"] = $this->productos;

        $this->viewData["pagination"] = Paging::getPagination(
            $this->productosCount,
            $this->itemsPerPage,
            $this->pageNumber,
            "index.php?page=Productos-ProductosList",
            "Productos-ProductosList"
        );

        Renderer::render("productos/lista", $this->viewData);
    }

    private function getParams(): void
    {
        $this->pageNumber = isset($_GET["pageNum"])
            ? intval($_GET["pageNum"])
            : 1;
    }
}
