package project_ferennia.digital_payment.controller;

import project_ferennia.digital_payment.service.PaymentService;
import org.springframework.web.bind.annotation.*;

// since we need body response HTTP, we use RestController
@RestController

@RequestMapping("/payment") // prefix URL

public class PaymentController {
    private final PaymentService service;

    // Dependency Injection
    public PaymentController(PaymentService service) {
        this.service = service;
    }

    // HTTP Method: POST
    @PostMapping("/deposit")
    public String deposit(@RequestParam int acc,
                          @RequestParam double amount) {
        service.deposit(acc, amount); // logic
        return "Deposit success";
    }

    @PostMapping("/withdraw")
    public String withdraw(@RequestParam int acc,
                           @RequestParam double amount) {
        service.withdraw(acc, amount);
        return "Withdraw success";
    }

    @PostMapping("/transfer")
    public String transfer(@RequestParam int from,
                           @RequestParam int to,
                           @RequestParam double amount) {
        service.transfer(from, to, amount);
        return "Transfer success";
    }
}

