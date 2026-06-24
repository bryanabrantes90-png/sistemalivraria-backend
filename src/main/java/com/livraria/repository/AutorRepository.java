package com.livraria.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.livraria.model.Autor;

public interface AutorRepository extends JpaRepository<Autor, Long> {
}