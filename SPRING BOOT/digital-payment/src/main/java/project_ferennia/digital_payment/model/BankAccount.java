package project_ferennia.digital_payment.model;

import jakarta.persistence.*;

@Entity

@Table(name = "bank_accounts")  // connect this entity to the 'bank_accounts' table in database
public class BankAccount {  // represent bank_accounts table

    @Id // primary key
    private int account_number;

    private String fullname;
    private double balance;

    // getters
    public int getAcc() {
        return account_number;
    }
    public String getName() {
        return fullname;
    }
    public double getBalance() {
        return balance;
    }

    // setters
    public void setBalance(double balance) {
        this.balance = balance;
    }
}
