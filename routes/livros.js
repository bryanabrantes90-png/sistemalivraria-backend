const express = require('express');
const router = express.Router();

router.get('/', async (req, res) => {
  try {
    const [result] = await db.query(`
      SELECT l.*, a.nome AS autor_nome, c.nome AS categoria_nome
      FROM livros l
      LEFT JOIN autores a ON l.autor_id = a.id
      LEFT JOIN categorias c ON l.categoria_id = c.id
      ORDER BY l.titulo
    `);
    res.json(result);
  } catch (err) {
    res.status(500).json({ erro: err.message });
  }
});

router.post('/', async (req, res) => {
  try {
    const { titulo, descricao, preco, autor_id, categoria_id } = req.body;
    const [result] = await db.query(
      'INSERT INTO livros (titulo, descricao, preco, autor_id, categoria_id) VALUES (?, ?, ?, ?, ?)',
      [titulo, descricao || '', preco, autor_id || null, categoria_id || null]
    );
    res.status(201).json({ id: result.insertId, ...req.body });
  } catch (err) {
    res.status(400).json({ erro: err.message });
  }
});

router.put('/:id', async (req, res) => {
  try {
    const { titulo, descricao, preco, autor_id, categoria_id } = req.body;
    await db.query(
      'UPDATE livros SET titulo=?, descricao=?, preco=?, autor_id=?, categoria_id=? WHERE id=?',
      [titulo, descricao || '', preco, autor_id || null, categoria_id || null, req.params.id]
    );
    res.json({ mensagem: 'Atualizado com sucesso' });
  } catch (err) {
    res.status(400).json({ erro: err.message });
  }
});

router.delete('/:id', async (req, res) => {
  try {
    await db.query('DELETE FROM livros WHERE id = ?', [req.params.id]);
    res.json({ mensagem: 'Excluído com sucesso' });
  } catch (err) {
    res.status(500).json({ erro: err.message });
  }
});

module.exports = router;