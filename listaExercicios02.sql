CREATE PROCEDURE sp_ListarAutores()
BEGIN
    SELECT * FROM autores;
END;

CREATE PROCEDURE sp_LivrosPorCategoria(IN categoria VARCHAR(255))
BEGIN
    SELECT * FROM livros WHERE categoria = categoria;
END;