package project_ferennia.digital_payment.repository;

import project_ferennia.digital_payment.model.TransactionRecord;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TransactionRepository
        extends JpaRepository<TransactionRecord, Integer> {
}
