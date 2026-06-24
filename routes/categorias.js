const express = require('express');
const router = express.Router();

router.get('/', async (req, res) => {
  const [result] = await db.query('SELECT * FROM categorias ORDER BY nome');
  res.json(result);
});

router.post('/', async (req, res) => {
  const { nome, descricao } = req.body;
  const [result] = await db.query(
    'INSERT INTO categorias (nome, descricao) VALUES (?, ?)',
    [nome, descricao || '']
  );
  res.status(201).json({ id: result.insertId, ...req.body });
});

router.put('/:id', async (req, res) => {
  const { nome, descricao } = req.body;
  await db.query(
    'UPDATE categorias SET nome=?, descricao=? WHERE id=?',
    [nome, descricao || '', req.params.id]
  );
  res.json({ mensagem: 'Atualizado' });
});

router.delete('/:id', async (req, res) => {
  await db.query('DELETE FROM categorias WHERE id = ?', [req.params.id]);
  res.json({ mensagem: 'Excluído' });
});

module.exports = router;