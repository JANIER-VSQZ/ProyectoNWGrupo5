<?php

namespace Controllers\Productos;

use Controllers\PublicController;
use Dao\Productos\Productos as DAOProductos;
use Exception;
use Utilities\Site;
use Utilities\Validators;
use Views\Renderer;

//CONSTANTES
const PRODUCTOSL = "index.php?page=Productos-ProductosList";
const PRODUCTOS_VIEW = "productos/form";


class ProductosForm extends PublicController
{
    private $modes = [
        "INS" => "Nuevo Producto",
        "UPD" => "Editando Producto %s",
        "DSP" => "Detalle de Producto %s",
        "DEL" => "Eliminando Producto %s"
    ];

    private string $mode = '';

    private int $id = 0;
    private string $productoNombre = '';
    private string $productoDescripcion = '';
    private float $productoPrecio = 0;
    private string $productoImg = '';
    private int $productoStock = 0;
    private string $productoEstado = '';

    private array $errores = [];

    private string $tokenValidation = '';


    private function page_init()
    {
        if (isset($_GET["mode"]) && isset($this->modes[$_GET["mode"]])) {
            $this->mode = $_GET["mode"];
            if ($this->mode !== "INS") {
                $tempCodigo = '';
                if (isset($_GET["productId"])) {
                    $tempCodigo = $_GET["productId"];
                } else {
                    throw new Exception("El Codigo no es Válido");
                }
                $tempProducto = DAOProductos::obtenerProductoPorCodigo($tempCodigo);
                if (count($tempProducto) === 0) {
                    throw new Exception("No se encontro función");
                }
                $this->id = $tempProducto["productId"];
                $this->productoNombre = $tempProducto["productName"];
                $this->productoDescripcion = $tempProducto["productDescription"];
                $this->productoPrecio = $tempProducto["productPrice"];
                $this->productoImg = $tempProducto["productImgUrl"];
                $this->productoStock = $tempProducto["productStock"];
                $this->productoEstado = $tempProducto["productStatus"];
            }
        } else {
            throw new Exception("Valor de Mode no es Válido");
        }
    }

    private function generarTokenDeValidacion()
    {
        $this->tokenValidation = md5(gettimeofday(true) . $this->name . rand(1000, 9999));
        $_SESSION[$this->name . "_token"] = $this->tokenValidation;
    }

    private function preparar_datos_vista()
    {
        $viewData = [];
        $viewData["mode"] = $this->mode;

        $viewData["modeDsc"] = $this->modes[$this->mode];

        if ($this->mode !== "INS") {
            $viewData["modeDsc"] = sprintf($viewData["modeDsc"], $this->productoNombre);
        }
        $viewData["productId"] = $this->id;
        $viewData["productName"] = $this->productoNombre;
        $viewData["productDescription"] = $this->productoDescripcion;
        $viewData["productPrice"] = $this->productoPrecio;
        $viewData["productImgUrl"] = $this->productoImg;
        $viewData["productStock"] = $this->productoStock;
        $viewData["productStatus"] = $this->productoEstado;



        $viewData["errores"] = $this->errores;
        $viewData["hasErrores"] = count($this->errores) > 0;


        $this->generarTokenDeValidacion();
        $viewData["token"] = $this->tokenValidation;


        $viewData["codigoReadonly"] = $this->mode !== "INS" ? "readonly" : "";

        $viewData["readonly"] = in_array($this->mode, ["DSP", "DEL"]) ? "readonly" : "";

        $viewData["isDisplay"] = $this->mode === "DSP";
        $viewData["isInsert"] = $this->mode === "INS";

        $viewData["selected" . $this->productoEstado] = "selected";
        return $viewData;
    }

    private function validarPostData(): array
    {
        $errores = [];

        $this->tokenValidation = $_POST["xrl8"] ?? "";
        if (isset($_SESSION[$this->name . "_token"]) && $_SESSION[$this->name . "_token"] !== $this->tokenValidation) {
            throw new Exception("Error de Validación de Token, no hackeable :(");
        }

        $this->id = intval($_POST["id"]);
        $this->productoNombre = $_POST["nombre"];
        $this->productoDescripcion = $_POST["descripcion"];
        $this->productoPrecio = floatval($_POST["precio"]);
        $this->productoImg = $_POST["imagen"];
        $this->productoStock = intval($_POST["stock"]);
        $this->productoEstado = $_POST["estado"] ?? 'ACT';


        //Validaciones de campos vacios
        if ($this->mode !== "INS" && Validators::IsEmpty($this->id)) {
            $errores[] = "El Id no puede ir vacío.";
        }
        if (Validators::IsEmpty($this->productoNombre)) {
            $errores[] = "El Nombre no puede ir vacio.";
        }
        if (Validators::IsEmpty($this->productoDescripcion)) {
            $errores[] = "La Descripción no puede ir vacia.";
        }
        if (Validators::IsEmpty($this->productoPrecio)) {
            $errores[] = "El Precio no puede ir vacio.";
        }
        if (Validators::IsEmpty($this->productoImg)) {
            $errores[] = "La Imagen no puede ir vacia.";
        }
        if (Validators::IsEmpty($this->productoStock)) {
            $errores[] = "El Stock no puede ir vacio.";
        }

        return $errores;
    }

    public function run(): void
    {
        try {
            $this->page_init();
            if ($this->isPostBack()) {
                $this->errores = $this->validarPostData();
                if (count($this->errores) === 0) {
                    try {
                        switch ($this->mode) {
                            case "INS":
                                //Llamar a Dao para Ingresar
                                $affectedRows = DAOProductos::agregarProducto(
                                    $this->productoNombre,
                                    $this->productoDescripcion,
                                    $this->productoPrecio,
                                    $this->productoImg,
                                    $this->productoStock,
                                    $this->productoEstado
                                );

                                if ($affectedRows > 0) {
                                    Site::redirectToWithMsg(PRODUCTOSL, "Nuevo Producto agregado satisfactoriamente.");
                                }
                                break;

                            case "UPD":
                                //Llamar a Dao para Actualizar
                                $affectedRows = DAOProductos::actualizarProducto(
                                    $this->id,
                                    $this->productoNombre,
                                    $this->productoDescripcion,
                                    $this->productoPrecio,
                                    $this->productoImg,
                                    $this->productoStock,
                                    $this->productoEstado
                                );

                                if ($affectedRows > 0) {
                                    Site::redirectToWithMsg(PRODUCTOSL, "Producto actualizado satisfactoriamente.");
                                }
                                break;

                            case "DEL":
                                //Llamar a Dao para Eliminar
                                $affectedRows = DAOProductos::eliminarProducto(
                                    $this->id
                                );

                                if ($affectedRows > 0) {
                                    Site::redirectToWithMsg(PRODUCTOSL, "Producto eliminado satisfactoriamente.");
                                }
                                break;
                        }
                    } catch (Exception $err) {
                        error_log($err, 0);
                        $this->errores[] = $err;
                    }
                }
            }

            Renderer::render(
                PRODUCTOS_VIEW,
                $this->preparar_datos_vista()
            );
        } catch (Exception $ex) {
            error_log($ex->getMessage());
            Site::redirectToWithMsg(PRODUCTOSL, "Sucedió un problema. Reintente de nuevo.");
        }
    }
}
