using System;

class Q2
{
    static void Main()
    {
        Console.Write("Enter First Number: ");
        double num1 = double.Parse(Console.ReadLine());

        Console.Write("Enter Second Number: ");
        double num2 = double.Parse(Console.ReadLine());

        Console.Write("Enter Operator (+, -, *, /): ");
        char op = Console.ReadLine()[0];

        double result = 0;
        bool valid = true;

        switch (op)
        {
            case '+':
                result = num1 + num2;
                break;
            case '-':
                result = num1 - num2;
                break;
            case '*':
                result = num1 * num2;
                break;
            case '/':
                if (num2 != 0)
                    result = num1 / num2;
                else
                {
                    Console.WriteLine("Error: Division by zero");
                    valid = false;
                }
                break;
            default:
                Console.WriteLine("Invalid Operator");
                valid = false;
                break;
        }

        if (valid)
            Console.WriteLine("Result: " + result);
    }
}
