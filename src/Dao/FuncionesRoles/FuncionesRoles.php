<?php

namespace Dao\FuncionesRoles;

use Dao\Table;

class FuncionesRoles extends Table
{

    // Obtener todos los registros de funciones_roles
    public static function funcionesRol()
    {
        $sqlStr = "SELECT * FROM funciones_roles;";
        return self::obtenerRegistros($sqlStr, []);
    }

    // Obtener un registro por rol (solo el primero encontrado)
    public static function obtenerFuncionPorRol(string $rolescod): array
    {
        $sqlstr = "SELECT * FROM funciones_roles WHERE rolescod = :rolescod;";
        return self::obtenerUnRegistro($sqlstr, ["rolescod" => $rolescod]);
    }

    // Obtener todas las funciones asignadas a un rol
    public static function obtenerFuncionesPorRol($rolescod)
    {
        $sql = "SELECT 
                    fr.rolescod,
                    fr.fncod,
                    f.fndsc,
                    fr.fnrolest
                FROM funciones_roles fr
                INNER JOIN funciones f ON f.fncod = fr.fncod
                WHERE fr.rolescod = :rolescod;";
        return self::obtenerRegistros($sql, ["rolescod" => $rolescod]);
    }

    // Agregar una función a un rol
    public static function agregarFuncionARol($rolescod, $fncod)
    {
        $sql = "INSERT INTO funciones_roles (rolescod, fncod, fnrolest)
                VALUES (:rolescod, :fncod, 'ACT')";

        $params = [
            "rolescod" => $rolescod,
            "fncod" => $fncod
        ];

        return self::executeNonQuery($sql, $params);
    }

    // Verificar si una función ya está asignada a un rol
    public static function obtenerFuncionDeRol($rolescod, $fncod)
    {
        $sql = "SELECT * FROM funciones_roles
                WHERE rolescod = :rolescod AND fncod = :fncod";
        $params = [
            "rolescod" => $rolescod,
            "fncod"    => $fncod
        ];
        return self::obtenerUnRegistro($sql, $params);
    }

    // Cambiar estado ACT ↔ INA
    public static function actualizarEstadoFuncionRol($rolescod, $fncod, $nuevoEstado)
    {
        $sql = "UPDATE funciones_roles
                SET fnrolest = :nuevoEstado
                WHERE rolescod = :rolescod AND fncod = :fncod";

        $params = [
            "nuevoEstado" => $nuevoEstado,
            "rolescod"    => $rolescod,
            "fncod"       => $fncod
        ];

        return self::executeNonQuery($sql, $params);
    }

    // Alternar estado sin pasar parámetro
    public static function cambiarEstadoFuncion($rolescod, $fncod)
    {
        $sql = "UPDATE funciones_roles
                SET fnrolest = IF(fnrolest='ACT','INA','ACT')
                WHERE rolescod = :rolescod AND fncod = :fncod";

        return self::executeNonQuery($sql, ["rolescod" => $rolescod, "fncod" => $fncod]);
    }

    // Eliminar función de un rol
    public static function eliminarFuncionDeRol($rolescod, $fncod)
    {
        $sql = "DELETE FROM funciones_roles
                WHERE rolescod = :rolescod AND fncod = :fncod";

        return self::executeNonQuery($sql, ["rolescod" => $rolescod, "fncod" => $fncod]);
    }
}
