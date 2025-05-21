package DAO;

import entity.RentalRequest;
import java.sql.Date;
import java.util.List;

public interface IDAORentalRequest {
    void addRentalRequest(RentalRequest request);
    void updateRentalRequest(RentalRequest request);
    void deleteRentalRequest(RentalRequest request);
    RentalRequest getRentalRequest(int id);
    List<RentalRequest> getAllRentalRequests();
    List<RentalRequest> getRentalRequestsByStatus(String status);
    List<RentalRequest> getUserRentalRequests(int userId);
    boolean isCarAvailable(int carId, Date startDate, Date endDate);
}