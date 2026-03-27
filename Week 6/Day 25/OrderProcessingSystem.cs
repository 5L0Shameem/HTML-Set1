using System;
using System.Threading.Tasks;

class OrderProcessingSystem
{
    static async Task VerifyPaymentAsync()
    {
        Console.WriteLine("Payment Verification Started");
        await Task.Delay(2000);
        Console.WriteLine("Payment Verified");
    }

    static async Task CheckInventoryAsync()
    {
        Console.WriteLine("Inventory Check Started");
        await Task.Delay(2000);
        Console.WriteLine("Inventory Available");
    }

    static async Task ConfirmOrderAsync()
    {
        Console.WriteLine("Order Confirmation Started");
        await Task.Delay(2000);
        Console.WriteLine("Order Confirmed");
    }

    static async Task Main()
    {
        Console.WriteLine("Order Processing Started\n");

        await VerifyPaymentAsync();
        await CheckInventoryAsync();
        await ConfirmOrderAsync();

        Console.WriteLine("\nOrder Processing Completed");
    }
}
