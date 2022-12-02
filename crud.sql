-- Aqui você deve colocar os códigos SQL referentes às
-- Simulações de um CRUD

-- Criação

-- 1)
INSERT INTO clientes 
	(nome, lealdade)
VALUES 
	('Georgia', 0)
RETURNING *;

-- 2)
INSERT INTO pedidos 
	(status, cliente_id)
 VALUES 
 	('Recebido', 6)
 RETURNING *;

-- 3)
INSERT INTO produtos_pedidos 
	(pedido_id, produto_id)
VALUES 
	(6, 1),
	(6, 2),
	(6, 6),
	(6, 8),
	(6, 8)
RETURNING *;


-- Leitura

-- 1)
SELECT 
	c.id,
	c.nome,
	c.lealdade,
	p.id,
	p.status,
	p.cliente_id,
	prod.id,
	prod.nome,
	prod.tipo,
	round(prod.preco:: NUMERIC, 2) preco,
	prod.pts_de_lealdade 
FROM 
	clientes c
JOIN
	pedidos p ON p.cliente_id = c.id 
JOIN
	produtos_pedidos pp ON pp.pedido_id = p.id
JOIN 
	produtos prod ON prod.id = pp.produto_id
WHERE
	lower(c.nome) = 'georgia';


-- Atualização

-- 1)
UPDATE 
	clientes 
SET
	lealdade = (
		SELECT 
			sum(prod.pts_de_lealdade) 
		FROM 
			pedidos p 
		JOIN
			produtos_pedidos pp ON pp.pedido_id  = p.id 
		JOIN 
			produtos prod ON prod.id = pp.produto_id
		WHERE 
			p.cliente_id = 6
	)
WHERE
	lower(clientes.nome) = 'georgia'
RETURNING *;


-- Deleção

-- 1)
DELETE FROM clientes c 
WHERE lower(c.nome) = 'marcelo'
RETURNING *;

