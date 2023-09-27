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