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