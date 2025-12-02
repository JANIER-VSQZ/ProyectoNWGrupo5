<?php

namespace Dao\RolesUsuario;

use Dao\Table;

class RolesUsuario extends Table
{
    //Función para obtener todos los registros de usuario
    public static function rolesUsuario()
    {
        $sqlStr = "SELECT * from roles_usuarios;";
        return self::obtenerRegistros($sqlStr, []);
    }

    //Función para obtener un registro de usuario
    public static function obtenerUsuarioPorCodigo(string $codigoUsuario): array
    {
        $sqlstr = "SELECT * from roles_usuarios WHERE usercod=:codigoUsuario;";
        return self::obtenerUnRegistro($sqlstr, ["codigoUsuario" => $codigoUsuario]);
    }

    public static function obtenerRolesPorUsuario($idUsuario)
    {
        $sql = "SELECT 
                ru.usercod,
                ru.rolescod,
                r.rolesdsc,
                ru.roleuserest
            FROM roles_usuarios ru
            INNER JOIN roles r ON r.rolescod = ru.rolescod
            WHERE ru.usercod = :idUsuario;";

        return self::obtenerRegistros($sql, ["idUsuario" => $idUsuario]);
    }


    public static function agregarRolAUsuario($usercod, $rolescod)
    {
        $sql = "INSERT INTO roles_usuarios (usercod, rolescod, roleuserest)
            VALUES (:usercod, :rolescod, 'ACT')";

        $params = [
            "usercod" => $usercod,
            "rolescod" => $rolescod
        ];

        return self::executeNonQuery($sql, $params);
    }



    public static function obtenerRolUsuario($usercod, $rolescod)
    {
        $sql = "SELECT * FROM roles_usuarios WHERE usercod = :usercod AND rolescod = :rolescod";
        $params = ["usercod" => $usercod, "rolescod" => $rolescod];
        return self::obtenerUnRegistro($sql, $params);
    }

    public static function actualizarEstadoRolUsuario($usercod, $rolescod, $nuevoEstado)
    {
        $sql = "UPDATE roles_usuarios
            SET roleuserest = :nuevoEstado
            WHERE usercod = :usercod AND rolescod = :rolescod";

        $params = [
            "nuevoEstado" => $nuevoEstado,
            "usercod" => $usercod,
            "rolescod" => $rolescod
        ];

        return self::executeNonQuery($sql, $params);
    }
}
