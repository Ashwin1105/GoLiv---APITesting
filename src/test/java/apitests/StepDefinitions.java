package apitests;

import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.RestAssured;
import io.restassured.http.ContentType;
import io.restassured.http.Method;
import io.restassured.response.Response;

import static io.restassured.RestAssured.given;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

public class StepDefinitions {
    private Response response;

    static {
        RestAssured.baseURI = System.getProperty("baseUrl", "http://host.docker.internal:5179");
    }

    @When("I send a {word} request to {string} with body:")
    public void i_send_a_request_with_body(String method, String path, String body) {
        response = given().contentType(ContentType.JSON).body(body)
            .when().request(Method.valueOf(method.toUpperCase()), path);
    }

    @When("I send a GraphQL request with query and variables:")
    public void i_send_a_graphql_request(String body) {
        response = given().contentType(ContentType.JSON).body(body)
            .when().post("/graphql");
    }

    @Then("the response status should be below {int}")
    public void status_below(Integer max) {
        assertTrue(response.getStatusCode() < max,
            "expected status < " + max + ", got " + response.getStatusCode() + ": " + response.getBody().asString());
    }

    @Then("the response status should be at least {int}")
    public void status_at_least(Integer min) {
        assertTrue(response.getStatusCode() >= min,
            "expected status >= " + min + ", got " + response.getStatusCode() + ": " + response.getBody().asString());
    }

    @Then("the response status should be at least {int} and below {int}")
    public void status_between(Integer min, Integer max) {
        int actual = response.getStatusCode();
        assertTrue(actual >= min && actual < max,
            "expected " + min + " <= status < " + max + ", got " + actual + ": " + response.getBody().asString());
    }

    @Then("the response should contain a GraphQL error")
    public void should_contain_graphql_error() {
        Object errors = response.jsonPath().get("errors");
        assertNotNull(errors, "expected a GraphQL error, got: " + response.getBody().asString());
    }

    @Then("the response should not contain a GraphQL error")
    public void should_not_contain_graphql_error() {
        Object errors = response.jsonPath().get("errors");
        assertNull(errors, "expected no GraphQL error, got: " + response.getBody().asString());
    }
}
