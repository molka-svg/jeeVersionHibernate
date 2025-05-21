package entity;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "parc")
public class Parc {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false)
    private int capacite;

    @Column(nullable = false)
    private String adresse;

    @OneToMany(mappedBy = "parc", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Voiture> voitures = new ArrayList<>();

    public Parc() {
    }

    public Parc(int capacite, String adresse) {
        this.capacite = capacite;
        this.adresse = adresse;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public int getCapacite() {
        return capacite;
    }

    public void setCapacite(int capacite) {
        this.capacite = capacite;
    }

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public List<Voiture> getVoitures() {
        return voitures;
    }

    public void setVoitures(List<Voiture> voitures) {
        this.voitures = voitures;
    }
}