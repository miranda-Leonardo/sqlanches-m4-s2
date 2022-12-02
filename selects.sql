-- Aqui você deve colocar os códigos SQL referentes às
-- Seleções de dados

-- 1)
SELECT 
	ped.id ,
	ped.status,
	ped.cliente_id,
	prod.id,
	prod.nome,
	prod.tipo,
	ROUND(prod.preco::NUMERIC, 2) preco,
	prod.pts_de_lealdade pontos_de_lealdade_do_produto
FROM 
	pedidos ped
JOIN 
	produtos_pedidos pp ON pp.pedido_id = ped.id
JOIN 
	produtos prod ON prod.id = pp.produto_id;

-- 2)
SELECT 
	ped.id
FROM 
	pedidos ped
JOIN
	produtos_pedidos pp ON pp.produto_id = (
		SELECT p.id FROM produtos p WHERE lower(p.nome) = 'fritas' 
	) AND ped.id = pp.pedido_id ;

-- 3)
SELECT 
	c.nome gostam_de_fritas
FROM 
	clientes c
JOIN
	pedidos ped ON ped.cliente_id = c.id 
JOIN 
	produtos_pedidos pp ON pp.pedido_id = ped.id
JOIN
	produtos prod ON prod.id = pp.produto_id 
WHERE 
	lower(prod.nome) = 'fritas' ;

-- 4)
SELECT 
	round(sum(prod.preco)::NUMERIC, 2) sum
FROM 
	produtos prod
JOIN 
	produtos_pedidos pp ON pp.produto_id = prod.id 
JOIN 
	pedidos ped ON ped.id = pp.pedido_id
JOIN 
	clientes c ON c.id = ped.cliente_id
WHERE
	lower(c.nome) = 'laura' ;

-- 5)
SELECT
	prod.nome,
	count(prod.nome) 
FROM 
	produtos prod
JOIN
	produtos_pedidos ped ON ped.produto_id = prod.id
GROUP BY 
	prod.nome
ORDER BY 
	prod.nome;
