package com.livraria.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.livraria.model.Livro;
import com.livraria.repository.LivroRepository;

@RestController
@RequestMapping("/livros")
public class LivroController {

    private final LivroRepository repository;

    public LivroController(LivroRepository repository) {
        this.repository = repository;
    }

    @GetMapping
    public List<Livro> listarTodos() {
        return repository.findAll();
    }

    @PostMapping
    public Livro criar(@RequestBody Livro livro) {
        return repository.save(livro);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Livro> atualizar(@PathVariable Long id, @RequestBody Livro livroAtualizado) {
        return repository.findById(id)
                .map(livro -> extracted(livroAtualizado, livro))
                .orElse(ResponseEntity.notFound().build());
    }

    private ResponseEntity<Livro> extracted(Livro livroAtualizado, Livro livro) {
        livro.setTitulo(livroAtualizado.getTitulo());
        livro.setDescricao(livroAtualizado.getDescricao());
        livro.setPreco(livroAtualizado.getPreco());
        livro.setAutor((String) livroAtualizado.getAutorId());
        livro.setCategoriaId(livroAtualizado.getCategoriaId());
        return ResponseEntity.ok(repository.save(livro));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> excluir(@PathVariable Long id) {
        if (!repository.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        repository.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}