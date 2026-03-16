using System;

class BankAccount
{
    private int accountNumber;
    private double balance;

    public int AccountNumber
    {
        get { return accountNumber; }
        set { accountNumber = value; }
    }

    public double Balance
    {
        get { return balance; }
        private set { balance = value; }
    }

    public void Deposit(double amount)
    {
        if (amount > 0)
        {
            Balance += amount;
            Console.WriteLine("Balance after deposit: " + Balance);
        }
        else
        {
            Console.WriteLine("Invalid deposit amount");
        }
    }

    public void Withdraw(double amount)
    {
        if (amount <= 0)
        {
            Console.WriteLine("Invalid withdrawal amount");
        }
        else if (amount > Balance)
        {
            Console.WriteLine("Insufficient balance");
        }
        else
        {
            Balance -= amount;
            Console.WriteLine("Current Balance = " + Balance);
        }
    }
}

class Program
{
    static void Main()
    {
        BankAccount acc = new BankAccount();
        acc.AccountNumber = 12345;

        acc.Deposit(5000);
        acc.Withdraw(2000);
    }
}