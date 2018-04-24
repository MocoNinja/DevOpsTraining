package app.bd;

import org.springframework.context.annotation.Configuration;
import org.springframework.data.mongodb.config.AbstractMongoConfiguration;
import org.springframework.data.mongodb.repository.config.EnableMongoRepositories;

import com.mongodb.Mongo;
import com.mongodb.MongoClient;

@Configuration
@EnableMongoRepositories(basePackages = "app.repository")
public class MongoConfig  extends AbstractMongoConfiguration {
  
    @Override
    protected String getDatabaseName() {
        return "test-with-client";
    }
  
    
    @Override
    public Mongo mongo() throws Exception {
        return new MongoClient("mongo-db-test-client", 27017);
    }
  	
  	
    @Override
    protected String getMappingBasePackage() {
        return "app";
    }

}
