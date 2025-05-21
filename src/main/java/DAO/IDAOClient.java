package DAO;

import entity.Client;
import java.util.List;

public interface IDAOClient {
    void addClient(Client client);
    void updateClient(Client client);
    void deleteClient(Client client);
    Client getClient(int id);
    List<Client> getAllClients();
}