package Utilitaire;

import entity.Client;

public class SimpleTest {
    public static void main(String[] args) {
        Client client = new Client();
        client.setNcin(123459);
        System.out.println("Client NCIN: " + client.getNcin());
    }
}