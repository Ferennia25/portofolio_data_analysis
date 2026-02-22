### Hi! This is Ferennia
> I’d like to share my simple REST API for managing digital bank accounts activity such as deposit, withdrawal, and transfer. This project follows a layered architecture pattern (Controller–Service(Logic Business)–Repository-Model(Database)) to separate responsibilities and improve maintainability.

### Tech Stack
  - Java 25
  - Spring Boot
  - Spring Web
  - Spring Data JPA
  - MySQL Driver
  - MySQL
  - Maven

### Project Structure

<img width="404" height="460" alt="Image" src="https://github.com/user-attachments/assets/f6b2d022-f7c7-43b9-87e2-0007c53a85e8" />

  - controller handles HTTP requests.
  - model represents database entities.
  - repository manages database operations.
  - service contains business logic.

### Features

  - Deposit money
  - Withdraw money
  - Transfer money
  - Record transaction history

### API Endpoints

  - POST payment/deposit
  - POST payment/withdraw
  - POST payment/transfer

    example:
    POST [http://localhost:8080/payment/deposit?acc=10001&amount=1000000]

    Response: 
	    Deposit success
<img width="945" height="556" alt="Image" src="https://github.com/user-attachments/assets/ddeeeb4e-264e-4f10-81b4-3b45a24c39ce" />

### Database Configuration
<img width="444" height="159" alt="Image" src="https://github.com/user-attachments/assets/68e064e0-3fb6-469f-950e-44ab98304380" />
  
### How to Run the Project
1. Clone this repository
2. Run **‘port java.sql’** in MySQL
3. Update database configuration in `application.properties`
4. Run the project by running DigitalPaymentApplication directly on IntelliJ IDEA


### Future Improvements
  - Add new bank account creation
  - Add testing
  - Add exception handling in detail for each class
  - Add authentication

