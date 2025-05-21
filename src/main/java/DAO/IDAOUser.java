package DAO;

import entity.User;
import java.util.List;

public interface IDAOUser {
    void addUser(User user);
    void updateUser(User user);
    void deleteUser(User user);
    User getUser(int id);
    List<User> getAllUsers();
    User authenticate(String username, String password);
    boolean isUsernameTaken(String username);
    boolean isEmailTaken(String email);
    void updateLastLogin(int userId);
}