Cypress.Commands.add('login', (username = 'standard_user', password = 'secret_sauce') => {
   cy.visit('/');
   cy.get('#user-name').clear().type(username);
   cy.get('#password').clear().type(password);
   cy.get('#login-button').click();
 });
