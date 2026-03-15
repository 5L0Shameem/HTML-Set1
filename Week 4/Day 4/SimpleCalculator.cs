using System;

class Calculator
{
    public int Add(int a, int b)
    {
        return a + b;
    }

    public int Subtract(int a, int b)
    {
        return a - b;
    }
}

class SimpleCalculatorProgram
{
    static void Main()
    {
        Calculator calc = new Calculator();

        Console.Write("Enter First Number: ");
        int num1 = int.Parse(Console.ReadLine());

        Console.Write("Enter Second Number: ");
        int num2 = int.Parse(Console.ReadLine());

        int addition = calc.Add(num1, num2);
        int subtraction = calc.Subtract(num1, num2);

        Console.WriteLine("Addition = " + addition);
        Console.WriteLine("Subtraction = " + subtraction);
    }
}