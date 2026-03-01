package project_ferennia.digital_payment.service;

import project_ferennia.digital_payment.model.*;
import project_ferennia.digital_payment.repository.*;
import org.springframework.stereotype.Service;

// business logic
@Service
public class PaymentService {

    private final BankAccountRepository accountRepo;
    private final TransactionRepository transRepo;

    // Dependency Injection
    public PaymentService(BankAccountRepository accountRepo,
                          TransactionRepository transRepo) {
        this.accountRepo = accountRepo;
        this.transRepo = transRepo;
    }

    public void deposit(int accountNumber, double amount) {
        BankAccount acc = accountRepo.findById(accountNumber).orElseThrow();
        acc.setBalance(acc.getBalance() + amount);
        accountRepo.save(acc);

        saveTransaction(accountNumber, "deposit", amount, "Saving Money");
    }

    public void withdraw(int accountNumber, double amount) {
        BankAccount acc = accountRepo.findById(accountNumber).orElseThrow();

        if (acc.getBalance() < amount) {
            throw new RuntimeException(
                    "Dear " + acc.getName() + " (" + acc.getAcc() + "), " + "you don't have enough money.."
            );
        }

        acc.setBalance(acc.getBalance() - amount);
        accountRepo.save(acc);

        saveTransaction(accountNumber, "withdraw", amount, "Taking Money");
    }

    public void transfer(int sender, int receiver, double amount) {

        BankAccount acc1 = accountRepo.findById(sender).orElseThrow();
        if (acc1.getBalance() < amount) {
            throw new RuntimeException(
                    "Dear " + acc1.getName() + " you don't have enough money.."
            );
        }

        acc1.setBalance(acc1.getBalance() - amount);
        accountRepo.save(acc1);
        saveTransaction(sender, "transfer", amount, "sending money to " + receiver);

        BankAccount acc2 = accountRepo.findById(receiver).orElseThrow();
        acc2.setBalance(acc2.getBalance() + amount);
        accountRepo.save(acc2);
        saveTransaction(receiver, "transfer", amount, "receiving money from " + sender);
    }

    public void addAccount(int acc, String fullname, double balance) {
        BankAccount newAcc = new BankAccount();
        newAcc.setAcc(acc);
        newAcc.setFullname(fullname);
        newAcc.setBalance(balance);
        accountRepo.save(newAcc);
    }
    
    // for transactions_record table
    private void saveTransaction(int acc, String type, double amount, String note) {
        TransactionRecord tx = new TransactionRecord();
        tx.setAccountId(acc);
        tx.setType(type);
        tx.setAmount(amount);
        tx.setNote(note);
        transRepo.save(tx);
    }
}
