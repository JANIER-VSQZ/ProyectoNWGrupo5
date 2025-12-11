<?php

namespace Dao\Productos;

use Dao\Table;

class Productos extends Table
{
    //Función para obtener todos los registros de productos
    public static function obtenerProductos()
    {
        $sqlstr = "SELECT * FROM products WHERE productStatus = 'ACT' AND productStock > 3";
        // $sqlstr = "SELECT * FROM products";

        $params = [];
        $registros = self::obtenerRegistros($sqlstr, $params);
        return $registros;
    }

    //Función para obtener un registro de producto
    public static function obtenerProductoPorCodigo(string $id): array
    {
        $sqlstr = "SELECT * from products WHERE productId=:id;";
        return self::obtenerUnRegistro($sqlstr, ["id" => $id]);
    }

    //Función para obtener todos los registros de productos para lista
    public static function getProductos(
        string $status = "",
        int $page = 0,
        int $itemsPerPage = 10
    ) {
        $sqlBase = "FROM products p";
        $conditions = [];
        $params = [];

        if ($status !== "") {
            $conditions[] = "p.productStatus = :status";
            $params["status"] = $status;
        }

        if (count($conditions) > 0) {
            $sqlBase .= " WHERE " . implode(" AND ", $conditions);
        }

        // COUNT
        $countSql = "SELECT COUNT(*) as count " . $sqlBase;
        $total = self::obtenerUnRegistro($countSql, $params)["count"];

        // PAGINACIÓN
        $pages = ceil($total / $itemsPerPage);
        if ($page > $pages - 1) {
            $page = $pages - 1;
        }

        $offset = $page * $itemsPerPage;

        // DATA
        $dataSql = "
            SELECT
                p.productId,
                p.productName,
                p.productDescription,
                p.productPrice,
                p.productImgUrl,
                p.productStock,
                p.productStatus,
                CASE
                    WHEN p.productStatus = 'ACT' THEN 'Activo'
                    WHEN p.productStatus = 'INA' THEN 'Inactivo'
                    ELSE 'Sin asignar'
                END AS productStatusDsc
            $sqlBase
            LIMIT $offset, $itemsPerPage
        ";

        $productos = self::obtenerRegistros($dataSql, $params);

        return [
            "productos" => $productos,
            "total" => $total
        ];
    }

    //Función para insertar un registro en productos
    public static function agregarProducto(
        string $productoNombre,
        string $productoDescripcion,
        float $productoPrecio,
        string $productoImg,
        int $productoStock,
        string $productoEstado
    ) {
        $insSql = "INSERT INTO products (productName, productDescription, productPrice, productImgUrl, productStock, productStatus)
        VALUES (:productoNombre, :productoDescripcion, :productoPrecio, :productoImg, :productoStock, :productoEstado);";

        $newInsertData = [
            "productoNombre" => $productoNombre,
            "productoDescripcion" => $productoDescripcion,
            "productoPrecio" => $productoPrecio,
            "productoImg" => $productoImg,
            "productoStock" => $productoStock,
            "productoEstado" => $productoEstado
        ];

        return self::executeNonQuery($insSql, $newInsertData);
    }


    //Función para actualizar un registro en productos
    public static function actualizarProducto(
        int     $id,
        string $productoNombre,
        string $productoDescripcion,
        float $productoPrecio,
        string $productoImg,
        int $productoStock,
        string $productoEstado
    ) {
        $updSql = "UPDATE products SET productName=:productoNombre, productDescription=:productoDescripcion, productPrice=:productoPrecio, productImgUrl=:productoImg, productStock=:productoStock, productStatus=:productoEstado
        WHERE productId=:id;";

        $newUpdateData = [
            "id" => $id,
            "productoNombre" => $productoNombre,
            "productoDescripcion" => $productoDescripcion,
            "productoPrecio" => $productoPrecio,
            "productoImg" => $productoImg,
            "productoStock" => $productoStock,
            "productoEstado" => $productoEstado
        ];

        return self::executeNonQuery($updSql, $newUpdateData);
    }

    //Función para eliminar un registro en productos
    public static function eliminarProducto(
        int $id
    ) {
        $delSql = "DELETE FROM products WHERE productId=:id;";

        $delData = [
            "id" => $id
        ];

        return self::executeNonQuery($delSql, $delData);
    }
}
