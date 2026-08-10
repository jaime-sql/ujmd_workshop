-- View: resumen_pedidos
-- Description: Full order summary with client, delivery cost and total
-- Edit this file freely — it is re-applied on every deployment.

CREATE OR REPLACE VIEW resumen_pedidos AS
SELECT
    pe.id_pedido,
    cl.nombre                                                      AS cliente,
    (cl.direccion_linea1 || ', ' || mun.nombre || ', ' || dep.nombre) AS direccion,
    re.nombre                                                      AS repartidor,
    SUM(dp.cantidad * dp.precio_unitario_historico)                AS subtotal,
    pe.costo_envio                                                 AS envio,
    SUM(dp.cantidad * dp.precio_unitario_historico) + pe.costo_envio AS total,
    pe.estado_pedido,
    pe.metodo_pago,
    pe.fecha_hora
FROM pedido pe
JOIN cliente      cl  ON pe.dui_cliente   = cl.dui_cliente
JOIN municipio    mun ON cl.id_municipio  = mun.id_municipio
JOIN departamento dep ON mun.id_departamento = dep.id_departamento
JOIN repartidor   re  ON pe.id_repartidor = re.id_repartidor
JOIN detalle_pedido dp ON pe.id_pedido    = dp.id_pedido
GROUP BY
    pe.id_pedido, cl.nombre, cl.direccion_linea1,
    mun.nombre, dep.nombre, re.nombre,
    pe.costo_envio, pe.estado_pedido, pe.metodo_pago, pe.fecha_hora;
