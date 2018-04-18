package app.repository;

import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;

import app.model.Guest;

public interface GuestRepository extends MongoRepository<Guest, String> {

    public Guest findByFirstName(String firstName);
    public List<Guest> findByLastName(String lastName);

}
