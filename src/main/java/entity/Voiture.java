package entity;

import jakarta.persistence.*;

@Entity
@Table(name = "voiture")
public class Voiture {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false)
    private String matricule;

    @Column(nullable = false)
    private String marque;

    @Column(nullable = false)
    private String modele;

    private Float kilometrage;

    @ManyToOne
    @JoinColumn(name = "parc_id")
    private Parc parc;

    private String imageUrl;

    @Column(name = "disponible")
    private Boolean disponible = true;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getMatricule() {
        return matricule;
    }

    public void setMatricule(String matricule) {
        this.matricule = matricule;
    }

    public String getMarque() {
        return marque;
    }

    public void setMarque(String marque) {
        this.marque = marque;
    }

    public String getModele() {
        return modele;
    }

    public void setModele(String modele) {
        this.modele = modele;
    }

    public Float getKilometrage() {
        return kilometrage;
    }

    public void setKilometrage(Float kilometrage) {
        this.kilometrage = kilometrage;
    }

    public Parc getParc() {
        return parc;
    }

    public void setParc(Parc parc) {
        this.parc = parc;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public Boolean getDisponible() {
        return disponible;
    }

    public void setDisponible(Boolean disponible) {
        this.disponible = disponible;
    }

    // Méthode utilitaire pour vérifier si la voiture est disponible
    public boolean isDisponible() {
        return disponible != null && disponible;
    }
}