package examples.util;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.javafaker.Faker;
import examples.dto.User;

public class Util {

    public static String createRandomUser() {

        String resultAsString="";
        Faker faker = new Faker();
        User user = new User();

        user.setFirstname(faker.name().firstName());
        user.setLastname(faker.name().lastName());

        ObjectMapper mapper = new ObjectMapper();

        try{
            resultAsString=mapper.writeValueAsString(user);
        }catch(Exception e){
            e.printStackTrace();
        }
        return resultAsString;
    }


    public static String createRandomName() {
        Faker faker = new Faker();
        return faker.name().firstName();
    }
}
