// Step definitions for the generated Gherkin feature(s) — Node 18+ built-in
// fetch(), no extra HTTP dependency. One flexible step vocabulary shared by
// both the generic REST and generic GraphQL feature files.
const { When, Then, setDefaultTimeout } = require('@cucumber/cucumber');
const assert = require('assert');

setDefaultTimeout(15 * 1000);
const BASE_URL = ({}).BASE_URL || 'http://localhost:5179';

When('I send a {word} request to {string} with body:', async function (method, path, body) {
  const res = await fetch(BASE_URL + path, {
    method: method.toUpperCase(),
    headers: { 'Content-Type': 'application/json' },
    body,
  });
  this.status = res.status;
  this.bodyText = await res.text();
});

When('I send a GraphQL request with query and variables:', async function (body) {
  const res = await fetch(BASE_URL + '/graphql', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body,
  });
  this.status = res.status;
  this.bodyText = await res.text();
  try { this.bodyJson = JSON.parse(this.bodyText); } catch { this.bodyJson = null; }
});

Then('the response status should be below {int}', function (max) {
  assert.ok(this.status < max, `expected status < ${max}, got ${this.status}: ${this.bodyText}`);
});

Then('the response status should be at least {int}', function (min) {
  assert.ok(this.status >= min, `expected status >= ${min}, got ${this.status}: ${this.bodyText}`);
});

Then('the response status should be at least {int} and below {int}', function (min, max) {
  assert.ok(this.status >= min && this.status < max, `expected ${min} <= status < ${max}, got ${this.status}: ${this.bodyText}`);
});

Then('the response should contain a GraphQL error', function () {
  assert.ok(this.bodyJson && this.bodyJson.errors, `expected a GraphQL error, got: ${this.bodyText}`);
});

Then('the response should not contain a GraphQL error', function () {
  assert.ok(!(this.bodyJson && this.bodyJson.errors), `expected no GraphQL error, got: ${this.bodyText}`);
});
