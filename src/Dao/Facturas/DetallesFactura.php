<?php
namespace Dao\Facturas;

use Dao\Table;
class DetallesFactura extends Table{
    public static function insertarDetalles(
        $facturaId,
        $nombreProducto,
        $sku,
        $precio,
        $impuesto,
        $cantidad,
        $subtotal,
    ){
        $sql = "INSERT INTO detalles_factura 
        (factura_id, nombreProducto, sku, precio, impuesto, cantidad, subtotal) 
        values (:facturaId, :nombreProducto, :sku, :precio, :impuesto, :cantidad, :subtotal);";
        $params = [
            'facturaId' => $facturaId,
            'nombreProducto' => $nombreProducto,
            'sku' => $sku,
            'precio' => $precio,
            'impuesto' => $impuesto,
            'cantidad' => $cantidad,
            'subtotal' => $subtotal
        ];

        return self::executeNonQuery($sql, $params);
    }


    public static function obtenerDetalles(string $factura_Id){
        $sqlstr = "Select * from detalles_factura where factura_id=:factura_Id;";
        $params = [
            'factura_Id'=>$factura_Id
        ];
        return self::obtenerRegistros($sqlstr, $params);
    }
}