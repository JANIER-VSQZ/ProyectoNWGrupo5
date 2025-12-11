<?php

namespace Dao\Carretilla;

use Dao\Table;

class CarretillaAnon extends Table
{
    //Función para obtener session de carretilla si no esta logeado el usuario
    public static function ensureAnonCode(): string
    {
        if (!isset($_SESSION["anon"]["anoncod"])) {
            $_SESSION["anon"]["anoncod"] = bin2hex(random_bytes(16));
        }
        return $_SESSION["anon"]["anoncod"];
    }

    //Función para obtener todo de carretilla anonima
    public static function getAllByAnon(string $anoncod): array
    {
        $sql = "SELECT c.anoncod, c.productId, c.crrctd, c.crrprc, c.crrfching, p.productName, p.productImgUrl, p.productStock
                FROM carretillaanon c
                JOIN products p ON p.productId = c.productId
                WHERE c.anoncod = :anoncod;";
        return self::obtenerRegistros($sql, ["anoncod" => $anoncod]);
    }

    //Función para obtener conteo en carretilla anonima
    public static function getCountByAnon(string $anoncod): int
    {
        $sql = "SELECT SUM(crrctd) as total FROM carretillaanon WHERE anoncod = :anoncod;";
        $row = self::obtenerUnRegistro($sql, ["anoncod" => $anoncod]);
        return $row ? intval($row["total"]) : 0;
    }

    //Función para verificar que exista en carretilla anonima
    public static function exists(string $anoncod, int $productId): bool
    {
        $sql = "SELECT count(*) as cnt FROM carretillaanon WHERE anoncod = :anoncod AND productId = :productId;";
        $row = self::obtenerUnRegistro($sql, ["anoncod" => $anoncod, "productId" => $productId]);
        return $row && intval($row["cnt"]) > 0;
    }

    //Función para agregar o actualizar en carretilla anonima
    public static function addOrUpdate(string $anoncod, int $productId, int $qty, float $price): bool
    {
        if (self::exists($anoncod, $productId)) {
            $sql = "UPDATE carretillaanon SET crrctd = crrctd + :qty, crrprc = :price, crrfching = NOW()
                    WHERE anoncod = :anoncod AND productId = :productId;";
            return self::executeNonQuery($sql, ["qty" => $qty, "price" => $price, "anoncod" => $anoncod, "productId" => $productId]);
        } else {
            $sql = "INSERT INTO carretillaanon (anoncod, productId, crrctd, crrprc, crrfching)
                    VALUES (:anoncod, :productId, :qty, :price, NOW());";
            return self::executeNonQuery($sql, ["anoncod" => $anoncod, "productId" => $productId, "qty" => $qty, "price" => $price]);
        }
    }

    //Función para eliminar en carretilla anonima, codigo y producto
    public static function remove(string $anoncod, int $productId): bool
    {
        $sql = "DELETE FROM carretillaanon WHERE anoncod = :anoncod AND productId = :productId;";
        return self::executeNonQuery($sql, ["anoncod" => $anoncod, "productId" => $productId]);
    }

    //Función para eliminar en carretilla anonima, codigo
    public static function clear(string $anoncod): bool
    {
        $sql = "DELETE FROM carretillaanon WHERE anoncod = :anoncod;";
        return self::executeNonQuery($sql, ["anoncod" => $anoncod]);
    }
}
