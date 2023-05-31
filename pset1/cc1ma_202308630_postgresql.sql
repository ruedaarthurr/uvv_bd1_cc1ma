-- Aluno: Arthur Oliveira Rueda
-- Matrícula: 202308630
-- Turma: CC1MA

-- Apagar banco de dados, em caso de existência do mesmo.
DROP DATABASE IF EXISTS uvv;

-- Apagar usuário, em caso de existência do mesmo.
DROP USER IF EXISTS arthurrueda;

-- Criar o usuário que vai ser utilizado.
CREATE USER arthurrueda WITH
SUPERUSER
CREATEDB
CREATEROLE
ENCRYPTED PASSWORD '2401';

-- Criar o banco de dados que vai ser utilizado.
CREATE DATABASE uvv WITH
owner = arthurrueda
template = template0
encoding = 'UTF8'
lc_collate = 'pt_BR.UTF-8'
lc_ctype = 'pt_BR.UTF-8'
allow_connections = TRUE;

-- Comentar o banco de dados que acabou de ser criado.
COMMENT ON DATABASE uvv IS 'Banco de dados do projeto PSET que vai armazenar dados sobre as Lojas UVV';

--Entrar no usuário que foi criado.
SET ROLE arthurrueda;

\c "host=localhost dbname=uvv user=arthurrueda password=2401";

-- Apagar Schema, em caso de existência do mesmo.
--DROP SCHEMA IF EXISTS lojas;

-- Criar o Schema lojas.
CREATE SCHEMA lojas AUTHORIZATION arthurrueda;
SHOW SEARCH_PATH;
SELECT CURRENT_SCHEMA();

-- Alterar o usuário para o que foi criado.
ALTER USER arthurrueda
SET SEARCH_PATH TO LOJAS, "$user", public;

SET SEARCH_PATH TO LOJAS, "$user", public;


-- Criar tabela produtos.
CREATE TABLE lojas.produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                -- Criar restrição de checagem para fazer com que o valor da coluna seja preenchido, sendo igual ou maior a zero.
                preco_unitario NUMERIC(10,2) CHECK(preco_unitario >=0),
                detalhes BYTEA,
                imagem BYTEA,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                CONSTRAINT pk_produtos PRIMARY KEY (produto_id)
);
COMMENT ON TABLE lojas.produtos IS 'Tabela sobre os produtos.';
COMMENT ON COLUMN lojas.produtos.produto_id IS 'Coluna sobre os dados dos produtos.';
COMMENT ON COLUMN lojas.produtos.nome IS 'Coluna sobre os dados dos nomes dos produtos.';
COMMENT ON COLUMN lojas.produtos.preco_unitario IS 'Coluna sobre os dados de preço unitário dos produtos.';
COMMENT ON COLUMN lojas.produtos.detalhes IS 'Coluna sobre os dados dos detalhes dos produtos.';
COMMENT ON COLUMN lojas.produtos.imagem IS 'Coluna sobre os dados da imagem dos produtos.';
COMMENT ON COLUMN lojas.produtos.imagem_mime_type IS 'Coluna sobre os dados da imagem mime type dos produtos.';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo IS 'Coluna sobre os dados das imagens dos arquivos dos produtos.';
COMMENT ON COLUMN lojas.produtos.imagem_charset IS 'Coluna sobre os dados da imagem charset dos produtos.';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao IS 'Coluna sobre os dados das imagens da última atualização dos produtos.';


-- Criar tabela lojas.
CREATE TABLE lojas.lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude NUMERIC,
                longitude NUMERIC,
                logo BYTEA,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                -- Criar restrição de checagem para fazer com que pelo menos uma das colunas 'endereco' seja preenchida.
                CONSTRAINT maior_ou_igualazero CHECK (endereco_web IS NOT NULL OR endereco_fisico IS NOT NULL),
                CONSTRAINT pk_lojas PRIMARY KEY (loja_id)         
);
COMMENT ON TABLE lojas.lojas IS 'Tabela sobre os dados das lojas.';
COMMENT ON COLUMN lojas.lojas.loja_id IS 'Coluna sobre os dados das lojas.';
COMMENT ON COLUMN lojas.lojas.nome IS 'Coluna sobre os dados dos nomes das lojas.';
COMMENT ON COLUMN lojas.lojas.endereco_web IS 'Coluna sobre os dados de endereço web das lojas.';
COMMENT ON COLUMN lojas.lojas.endereco_fisico IS 'Coluna sobre os dados de endereço físico das lojas.';
COMMENT ON COLUMN lojas.lojas.latitude IS 'Coluna sobre os dados da latitude das lojas.';
COMMENT ON COLUMN lojas.lojas.longitude IS 'Coluna sobre os dados da longitude das lojas.';
COMMENT ON COLUMN lojas.lojas.logo IS 'Coluna sobre os dados da logo das lojas.';
COMMENT ON COLUMN lojas.lojas.logo_mime_type IS 'Coluna sobre os dados da logo mime type das lojas.';
COMMENT ON COLUMN lojas.lojas.logo_arquivo IS 'Coluna sobre os dados dos arquivos da logo das lojas.';
COMMENT ON COLUMN lojas.lojas.logo_charset IS 'Coluna sobre os dados da logo charset das lojas.';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS 'Coluna sobre os dados da última atualização da logo das lojas.';

-- Criar tabela estoques.
CREATE TABLE lojas.estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                -- Criar restrição de checagem para fazer com que o valor da coluna seja preenchido, sendo igual ou maior a zero.
                quantidade NUMERIC(38) NOT NULL CHECK(quantidade >=0),
                CONSTRAINT pk_estoques PRIMARY KEY (estoque_id)
);
COMMENT ON TABLE lojas.estoques IS 'Tabela sobre os estoques.';
COMMENT ON COLUMN lojas.estoques.estoque_id IS 'Coluna sobre os estoques.';
COMMENT ON COLUMN lojas.estoques.loja_id IS 'Coluna sobre as lojas dos estoques.';
COMMENT ON COLUMN lojas.estoques.produto_id IS 'Coluna sobre os produtos dos estoques.';
COMMENT ON COLUMN lojas.estoques.quantidade IS 'Coluna sobre a quantidade de estoques.';

-- Criar tabela clientes.
CREATE TABLE lojas.clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT pk_clientes PRIMARY KEY (cliente_id)
);
COMMENT ON TABLE lojas.clientes IS 'Tabela sobre os clientes.';
COMMENT ON COLUMN lojas.clientes.cliente_id IS 'Coluna com os dados dos clientes.';
COMMENT ON COLUMN lojas.clientes.email IS 'Coluna sobre os dados do e-mail dos clientes.';
COMMENT ON COLUMN lojas.clientes.nome IS 'Coluna sobre os dados dos nomes dos clientes.';
COMMENT ON COLUMN lojas.clientes.telefone1 IS 'Coluna sobre os dados dos telefones dos clientes.';
COMMENT ON COLUMN lojas.clientes.telefone2 IS 'Coluna sobre os dados do telefone número 2 dos clientes.';
COMMENT ON COLUMN lojas.clientes.telefone3 IS 'Coluna sobre os dados dos telefones de número 3 dos clientes.';

-- Criar tabela envios.
CREATE TABLE lojas.envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT pk_envios PRIMARY KEY (envio_id)
);
COMMENT ON TABLE lojas.envios IS 'Tabela sobre os envios.';
COMMENT ON COLUMN lojas.envios.envio_id IS 'Coluna sobre os envios.';
COMMENT ON COLUMN lojas.envios.loja_id IS 'Coluna sobre os dados das lojas dos envios.';
COMMENT ON COLUMN lojas.envios.cliente_id IS 'Coluna sobre os dados dos clientes que fizeram envios.';
COMMENT ON COLUMN lojas.envios.endereco_entrega IS 'Coluna sobre os dados de endereço e entrega dos clientes.';
COMMENT ON COLUMN lojas.envios.status IS 'Coluna sobre os dados dos status dos envios.';

-- Criar tabela pedidos.
CREATE TABLE lojas.pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pk_pedidos PRIMARY KEY (pedido_id)
);
COMMENT ON TABLE lojas.pedidos IS 'Tabela sobre os pedidos.';
COMMENT ON COLUMN lojas.pedidos.pedido_id IS 'Coluna sobre os pedidos.';
COMMENT ON COLUMN lojas.pedidos.data_hora IS 'Coluna com os dados da data e da hora dos pedidos.';
COMMENT ON COLUMN lojas.pedidos.cliente_id IS 'Coluna sobre os dados dos clientes que fizeram pedidos.';
COMMENT ON COLUMN lojas.pedidos.status IS 'Coluna sobre os dados dos status dos pedidos.';
COMMENT ON COLUMN lojas.pedidos.loja_id IS 'Coluna sobre os dados das lojas dos pedidos.';

-- Criar tabela pedidos_itens.
CREATE TABLE lojas.pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38),
                CONSTRAINT pk_pedidos_itens PRIMARY KEY (pedido_id, produto_id)
);
COMMENT ON TABLE lojas.pedidos_itens IS 'Tabela sobre os pedidos de itens.';
COMMENT ON COLUMN lojas.pedidos_itens.pedido_id IS 'Coluna sobre os pedidos dos itens.';
COMMENT ON COLUMN lojas.pedidos_itens.produto_id IS 'Coluna sobre os produtos dos pedidos de itens.';
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha IS 'Coluna sobre o número da linha dos pedidos de itens.';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario IS 'Coluna sobre o preço unitário dos pedidos de itens.';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade IS 'Coluna sobre a quantidade de pedidos dos itens.';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id IS 'Coluna sobre os envios dos pedidos de itens.';


ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Criar restrição de checagem para restringir os status dos pedidos aos seguintes valores:
ALTER TABLE lojas.pedidos
ADD CONSTRAINT pedidos_status_check
CHECK (status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'));

-- Criar restrição de checagem para restringir os status dos envios aos seguintes valores:
ALTER TABLE lojas.envios
ADD CONSTRAINT envios_status_check
CHECK (status IN ('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'));