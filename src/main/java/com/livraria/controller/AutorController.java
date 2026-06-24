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

import com.livraria.model.Autor;
import com.livraria.repository.AutorRepository;

@RestController
@RequestMapping("/autores") // ← Caminho principal da rota
public class AutorController {

    private final AutorRepository repository;

    public AutorController(AutorRepository repository) {
        this.repository = repository;
    }

    @GetMapping
    public List<Autor> listarTodos() {
        return repository.findAll();
    }

    @PostMapping
    public Autor criar(@RequestBody Autor autor) {
        return repository.save(autor);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Autor> atualizar(@PathVariable Long id, @RequestBody Autor autorAtualizado) {
        return repository.findById(id)
                .map(autor -> {
                    autor.setNome(autorAtualizado.getNome());
                    autor.setNacionalidade(autorAtualizado.getNacionalidade());
                    autor.setBiografia(autorAtualizado.getBiografia());
                    return ResponseEntity.ok(repository.save(autor));
                })
                .orElse(ResponseEntity.notFound().build());
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