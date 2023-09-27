CREATE PROCEDURE sp_ListarAutores()
BEGIN
    SELECT * FROM autores;
END;

CREATE PROCEDURE sp_LivrosPorCategoria(IN categoria VARCHAR(255))
BEGIN
    SELECT * FROM livros WHERE categoria = categoria;
END;

CREATE PROCEDURE sp_ContarLivrosPorCategoria(IN categoria VARCHAR(255), OUT total INT)
BEGIN
    SELECT COUNT(*) INTO total FROM livros WHERE categoria = categoria;
END;

CREATE PROCEDURE sp_VerificarLivrosCategoria(IN categoria VARCHAR(255), OUT possuiLivros BOOLEAN)
BEGIN
    DECLARE count INT;
    SELECT COUNT(*) INTO count FROM livros WHERE categoria = categoria;
    
    IF count > 0 THEN
        SET possuiLivros = TRUE;
    ELSE
        SET possuiLivros = FALSE;
    END IF;
END;

CREATE PROCEDURE sp_LivrosAteAno(IN ano INT)
BEGIN
    SELECT * FROM livros WHERE ano <= ano;
END;

CREATE PROCEDURE sp_TitulosPorCategoria(IN categoria VARCHAR(50))
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE titulo VARCHAR(255);
    DECLARE cur CURSOR FOR SELECT titulo FROM Livro WHERE categoria = categoria;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO titulo;
        IF done THEN
            LEAVE read_loop;
        END IF;
    END LOOP;

    CLOSE cur;
END;

CREATE PROCEDURE sp_AdicionarLivro(IN titulo VARCHAR(255), IN autor VARCHAR(255), IN categoria VARCHAR(50))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    END;

    INSERT INTO Livro (titulo, autor, categoria) VALUES (titulo, autor, categoria);
END;

CREATE PROCEDURE sp_AutorMaisAntigo(OUT nomeAutor VARCHAR(255))
BEGIN
    SELECT nome INTO nomeAutor FROM Autor ORDER BY data_nascimento LIMIT 1;
END;

-- Stored procedure para verificar se há livros em uma determinada categoria
-- Parâmetros:
-- categoria: A categoria para verificar livros
-- possuiLivros: Parâmetro de saída para indicar se há livros na categoria

CREATE PROCEDURE sp_VerificarLivrosCategoria(IN categoria VARCHAR(255), OUT possuiLivros BOOLEAN)
BEGIN
    -- Declarando uma variável para armazenar a contagem de livros na categoria
    DECLARE count INT;
    
    -- Contando o número de livros em uma determinada categoria
    SELECT COUNT(*) INTO count FROM livros WHERE categoria = categoria;
    
    -- Verificando se há livros na categoria
    IF count > 0 THEN
        -- Definindo o parâmetro de saída como verdadeiro se houver livros
        SET possuiLivros = TRUE;
    ELSE
        -- Definindo o parâmetro de saída como falso se não houver livros
        SET possuiLivros = FALSE;
    END IF;
    
END;

CREATE PROCEDURE sp_LivrosESeusAutores()
BEGIN
    SELECT Livro.titulo, Autor.nome, Autor.sobrenome
    FROM Livro
    INNER JOIN Autor ON Livro.id_autor = Autor.id;
END;