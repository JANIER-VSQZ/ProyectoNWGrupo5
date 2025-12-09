<?php
namespace Dao\Facturas;

use Dao\Table;

class Facturas extends Table{
    public static function obtenerFacturas(): array{
        $sqlstr = "SELECT * FROM Facturas";
        return self::obtenerRegistros($sqlstr, []);
    }

    public static function obtenerFacturasPorCodigo(int $factura_Id): array{
        $sqlstr = "SELECT * from Facturas where factura_Id = :factura_Id";
        return self::obtenerUnRegistro($sqlstr, ["factura_Id" => $factura_Id]);
    }

    public static function insertarFacturas(
        string $orderIdPaypal,
        string $captureIdPaypal,
        string $nombreCliente,
        string $apellidoCliente,
        float $subtotal,
        float $impuesto,
        string $moneda
    ){
        $sqlstr = "INSERT INTO Facturas (orderIdPaypal, captureIdPaypal, nombreCliente, apellidoCliente, subtotal, impuesto, moneda) VALUES (:orderIdPaypal, :captureIdPaypal, :nombreCliente, :apellidoCliente, :subtotal, :impuesto, :moneda)";

        $params = [
            'orderIdPaypal' => $orderIdPaypal,
            'captureIdPaypal' => $captureIdPaypal,
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