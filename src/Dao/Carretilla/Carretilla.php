<?php

namespace Dao\Carretilla;

use Dao\Table;
use Utilities\Security;

class Carretilla extends Table
{
    //Función para obtener los usaarios de carretillas
    public static function getAllByUser(int $usercod): array
    {
        $sql = "SELECT c.usercod, c.productId, c.crrctd, c.crrprc, c.crrfching, p.productName, p.productImgUrl, p.productStock
                FROM carretilla c
                JOIN products p ON p.productId = c.productId
                WHERE c.usercod = :usercod;";
        return self::obtenerRegistros($sql, ["usercod" => $usercod]);
    }

    //Función para obtener conteo de usuarios de carretillas
    public static function getCountByUser(int $usercod): int
    {
        $sql = "SELECT SUM(crrctd) as total FROM carretilla WHERE usercod = :usercod;";
        $row = self::obtenerUnRegistro($sql, ["usercod" => $usercod]);
        return $row ? intval($row["total"]) : 0;
    }

    //Función para validr que exista los usaarios de carretillas
    public static function exists(int $usercod, int $productId): bool
    {
        $sql = "SELECT count(*) as cnt FROM carretilla WHERE usercod = :usercod AND productId = :productId;";
        $row = self::obtenerUnRegistro($sql, ["usercod" => $usercod, "productId" => $productId]);
        return $row && intval($row["cnt"]) > 0;
    }

    //Función para remover  en carretilla
    public static function addOrUpdate(int $usercod, int $productId, int $qty, float $price): bool
    {
        // si existe actualiza la cantidad, sino la inserta
        if (self::exists($usercod, $productId)) {
            $sql = "UPDATE carretilla SET crrctd = crrctd + :qty, crrprc = :price, crrfching = NOW()
                    WHERE usercod = :usercod AND productId = :productId;";
            return self::executeNonQuery($sql, ["qty" => $qty, "price" => $price, "usercod" => $usercod, "productId" => $productId]);
        } else {
            $sql = "INSERT INTO carretilla (usercod, productId, crrctd, crrprc, crrfching)
                    VALUES (:usercod, :productId, :qty, :price, NOW());";
            return self::executeNonQuery($sql, ["usercod" => $usercod, "productId" => $productId, "qty" => $qty, "price" => $price]);
        }
    }

    //Función para actualizar la cantidad en carretilla
    public static function updateQuantity(int $usercod, int $productId, int $qty): bool
    {
        if ($qty <= 0) {
            return self::remove($usercod, $productId);
        }
        $sql = "UPDATE carretilla SET crrctd = :qty, crrfching = NOW() WHERE usercod = :usercod AND productId = :productId;";
        return self::executeNonQuery($sql, ["qty" => $qty, "usercod" => $usercod, "productId" => $productId]);
    }

    //Función para eliminar en carretilla, el usuario y producto
    public static function remove(int $usercod, int $productId): bool
    {
        $sql = "DELETE FROM carretilla WHERE usercod = :usercod AND productId = :productId;";
        return self::executeNonQuery($sql, ["usercod" => $usercod, "productId" => $productId]);
    }

    //Función para eliminar en carretilla el usuario
    public static function clear(int $usercod): bool
    {
        $sql = "DELETE FROM carretilla WHERE usercod = :usercod;";
        return self::executeNonQuery($sql, ["usercod" => $usercod]);
    }
}
