const express = require('express');
const router = express.Router();

router.get('/', async (req, res) => {
  const [result] = await db.query('SELECT * FROM autores ORDER BY nome');
  res.json(result);
});

router.post('/', async (req, res) => {
  const { nome, nacionalidade, biografia } = req.body;
  const [result] = await db.query(
    'INSERT INTO autores (nome, nacionalidade, biografia) VALUES (?, ?, ?)',
    [nome, nacionalidade || '', biografia || '']
  );
  res.status(201).json({ id: result.insertId, ...req.body });
});

router.put('/:id', async (req, res) => {
  const { nome, nacionalidade, biografia } = req.body;
  await db.query(
    'UPDATE autores SET nome=?, nacionalidade=?, biografia=? WHERE id=?',
    [nome, nacionalidade || '', biografia || '', req.params.id]
  );
  res.json({ mensagem: 'Atualizado' });
});

router.delete('/:id', async (req, res) => {
  await db.query('DELETE FROM autores WHERE id = ?', [req.params.id]);
  res.json({ mensagem: 'Excluído' });
});

module.exports = router;