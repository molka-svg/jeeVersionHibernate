package DAO;

import entity.Notification;
import java.util.List;

public interface IDAONotification {
    void addNotification(Notification notification);
    void updateNotification(Notification notification);
    void deleteNotification(Notification notification);
    Notification getNotification(int id);
    List<Notification> getUserNotifications(int userId);
    int getUnreadNotificationCount(int userId);
    void markAsRead(int notificationId);
    void markAllAsRead(int userId);
}