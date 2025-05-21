package entity;

import jakarta.persistence.*;

@Entity
@Table(name = "client")
public class Client {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column
    private Integer ncin;

    @Column
    private String nom;

    @Column
    private String prenom;

    @Column(name = "num_tel")
    private Integer numTel;

    @Column
    private String email;

    @Column
    private String adresse;

    @Column(name = "num_permis")
    private Integer numPermis;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getNcin() {
        return ncin;
    }

    public void setNcin(Integer ncin) {
        this.ncin = ncin;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public Integer getNumTel() {
        return numTel;
    }

    public void setNumTel(Integer numTel) {
        this.numTel = numTel;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public Integer getNumPermis() {
        return numPermis;
    }

    public void setNumPermis(Integer numPermis) {
        this.numPermis = numPermis;
    }
}