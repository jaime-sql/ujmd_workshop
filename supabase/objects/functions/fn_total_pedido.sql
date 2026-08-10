-- Function: fn_total_pedido
-- Description: Returns the subtotal (before shipping) for a given order
-- Edit this file freely — it is re-applied on every deployment.

CREATE OR REPLACE FUNCTION fn_total_pedido(p_id_pedido INT)
RETURNS NUMERIC AS $$
    SELECT COALESCE(SUM(cantidad * precio_unitario_historico), 0)
    FROM detalle_pedido
    WHERE id_pedido = p_id_pedido;
$$ LANGUAGE sql STABLE;
