using System;

class Vehicle
{
    private string brand;
    private double rentalRatePerDay;

    public string Brand
    {
        get { return brand; }
        set { brand = value; }
    }

    public double RentalRatePerDay
    {
        get { return rentalRatePerDay; }
        set
        {
            if (value >= 0)
                rentalRatePerDay = value;
            else
                Console.WriteLine("Invalid rental rate");
        }
    }

    public virtual double CalculateRental(int days)
    {
        return RentalRatePerDay * days;
    }
}

class Car : Vehicle
{
    public override double CalculateRental(int days)
    {
        if (days <= 0)
        {
            Console.WriteLine("Invalid rental days");
            return 0;
        }

        double total = RentalRatePerDay * days;
        return total + 500;
    }
}

class Bike : Vehicle
{
    public override double CalculateRental(int days)
    {
        if (days <= 0)
        {
            Console.WriteLine("Invalid rental days");
            return 0;
        }

        double total = RentalRatePerDay * days;
        return total - (total * 0.05);
    }
}

class Program
{
    static void Main()
    {
        Vehicle car = new Car();
        car.Brand = "Toyota";
        car.RentalRatePerDay = 2000;

        int days = 3;

        Console.WriteLine("Total Rental = " + car.CalculateRental(days));
    }
}
