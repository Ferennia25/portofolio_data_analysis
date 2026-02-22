package project_ferennia.digital_payment.repository;

import project_ferennia.digital_payment.model.BankAccount;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BankAccountRepository
        extends JpaRepository<BankAccount, Integer> {
}
