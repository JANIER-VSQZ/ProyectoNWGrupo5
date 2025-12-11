<?php
namespace Dao\Facturas;

use Dao\Table;

class Facturas extends Table{
    public static function obtenerFacturas(): array{
        $sqlstr = "SELECT * FROM Facturas";
        return self::obtenerRegistros($sqlstr, []);
    }

    public static function obtenerFacturasPorCodigo(int $factura_Id, int $usuario_id):array{
        $sqlstr = "select f.factura_id,
        f.orderIdPaypal,
        f.captureIdPaypal,
        f.fechaFactura,
        f.usuario_Id,
        u.username,
        f.nombreCliente,
        f.apellidoCliente,
        f.total,
        f.impuesto,
        f.moneda
        from facturas as f 
        inner join usuario as u on f.usuario_id=u.usercod
        where f.factura_Id = :factura_Id AND f.usuario_id=:usuario_Id;";
    $params=[
        "factura_Id" => $factura_Id,
        "usuario_Id" => $usuario_id
    ];
        return self::obtenerUnRegistro($sqlstr, $params);
    }

    public static function obtenerFacturasPorUsuario(int $usercod):array{
        $sqlstr="SELECT * from Facturas where usuario_id = :usercod;";
        return self::obtenerRegistros($sqlstr, ['usercod' => $usercod]);
    }

    public static function verificarSiExisteFactura(string $factura_Id){
        $sqlstr = "SELECT factura_id FROM facturas WHERE orderIdPaypal = :factura_Id";
        return self::obtenerUnRegistro($sqlstr, ["factura_Id" => $factura_Id]);
    }


    public static function insertarFacturas(
        string $orderIdPaypal,
        string $captureIdPaypal,
        int $usuarioId,
        string $nombreCliente,
        string $apellidoCliente,
        float $subtotal,
        float $impuesto,
        string $moneda
    ){
        $sqlstr = "INSERT INTO Facturas (orderIdPaypal, captureIdPaypal, usuario_id, nombreCliente, apellidoCliente, total, impuesto, moneda) VALUES (:orderIdPaypal, :captureIdPaypal, :usuarioId, :nombreCliente, :apellidoCliente, :subtotal, :impuesto, :moneda)";

        $params = [
            'orderIdPaypal' => $orderIdPaypal,
            'captureIdPaypal' => $captureIdPaypal,
            'usuarioId' => $usuarioId,
            'nombreCliente' => $nombreCliente,
            'apellidoCliente' => $apellidoCliente,
            'subtotal' => $subtotal,
            'impuesto' => $impuesto,
            'moneda' => $moneda
        ];
        return self::executeNonQuery($sqlstr, $params);
    }

    public static function actualizarFacturas(
        int $factura_Id,
        string $orderIdPaypal,
        string $captureIdPaypal,
        string $fechaFactura,
        string $nombreCliente,
        string $apellidoCliente,
        float $subtotal,
        float $impuesto,
        string $moneda
    ){
        $sqlstr = "UPDATE Facturas SET orderIdPaypal = :orderIdPaypal, captureIdPaypal = :captureIdPaypal, fechaFactura = :fechaFactura, nombreCliente = :nombreCliente, apellidoCliente = :apellidoCliente, subtotal = :subtotal, impuesto = :impuesto, moneda = :moneda WHERE factura_Id = :factura_Id";

        $params = [
            'factura_Id' => $factura_Id,
            'orderIdPaypal' => $orderIdPaypal,
            'captureIdPaypal' => $captureIdPaypal,
            'fechaFactura' => $fechaFactura,
            'nombreCliente' => $nombreCliente,
            'apellidoCliente' => $apellidoCliente,
            'subtotal' => $subtotal,
            'impuesto' => $impuesto,
            'moneda' => $moneda
        ];
        return self::executeNonQuery($sqlstr, $params);
    }

    public static function eliminarFacturas(
        int $factura_Id
    ){
        $sqlstr = "DELETE FROM Facturas WHERE factura_Id = :factura_Id;";

        $params = [
            'factura_Id' => $factura_Id
        ];
        return self::executeNonQuery($sqlstr, $params);
    }
    
}