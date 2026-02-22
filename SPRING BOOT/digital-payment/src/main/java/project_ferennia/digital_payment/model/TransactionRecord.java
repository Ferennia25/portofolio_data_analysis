package project_ferennia.digital_payment.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "transactions_record")
public class TransactionRecord {

    // primary Key + auto increment
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private int accountId;
    private String type;
    private double amount;
    private LocalDateTime timestamp;
    private String note;

    @PrePersist // is called automatically right before the data is saved to the database
    public void setTime() {
        timestamp = LocalDateTime.now();
    }

    // setters
    public void setAccountId(int accountId) { this.accountId = accountId; }
    public void setType(String type) { this.type = type; }
    public void setAmount(double amount) { this.amount = amount; }
    public void setNote(String note) { this.note = note; }
}
