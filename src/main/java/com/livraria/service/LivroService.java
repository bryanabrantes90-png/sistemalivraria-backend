package com.livraria.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.livraria.model.Livro;
import com.livraria.repository.LivroRepository;

@Service
public class LivroService {

    private final LivroRepository livroRepository;

    // Injeção de dependência via construtor
    public LivroService(LivroRepository livroRepository) {
        this.livroRepository = livroRepository;
    }

    // Listar todos os livros
    public List<Livro> listarTodos() {
        return livroRepository.findAll();
    }

    // Buscar livro por ID
    public Optional<Livro> buscarPorId(Long id) {
        return livroRepository.findById(id);
    }

    // Salvar novo livro
    public Livro salvar(Livro livro) {
        return livroRepository.save(livro);
    }

    // Atualizar livro existente
    public Livro atualizar(Long id, Livro livroAtualizado) {
        return livroRepository.findById(id)
                .map(livro -> {
                    livro.setTitulo(livroAtualizado.getTitulo());
                    livro.setDescricao(livroAtualizado.getDescricao());
                    livro.setPreco(livroAtualizado.getPreco());
                    livro.setAutorId(livroAtualizado.getAutorId());
                    livro.setCategoriaId(livroAtualizado.getCategoriaId());
                    return livroRepository.save(livro);
                })
                .orElseThrow(() -> new RuntimeException("Livro não encontrado com o ID: " + id));
    }

    // Excluir livro
    public void excluir(Long id) {
        if (!livroRepository.existsById(id)) {
            throw new RuntimeException("Livro não encontrado com o ID: " + id);
        }
        livroRepository.deleteById(id);
    }
}