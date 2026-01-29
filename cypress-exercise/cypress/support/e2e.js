import './commands';

beforeEach(() => {
  cy.intercept('POST', 'https://events.backtrace.io/**', {
    statusCode: 204,
    body: ''
  });
});
