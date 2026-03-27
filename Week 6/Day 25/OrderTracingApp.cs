using System;
using System.Diagnostics;

class OrderTracingApp
{
    static void Main()
    {
        TextWriterTraceListener listener = new TextWriterTraceListener("traceLog.txt");
        Trace.Listeners.Add(listener);
        Trace.AutoFlush = true;

        try
        {
            Trace.TraceInformation("Order Processing Started");

            ValidateOrder();
            ProcessPayment();
            UpdateInventory();
            GenerateInvoice();

            Trace.TraceInformation("Order Processing Completed Successfully");
        }
        catch (Exception ex)
        {
            Trace.WriteLine("Error: " + ex.Message);
        }
        finally
        {
            Trace.Flush();
            Trace.Close();
        }
    }

    static void ValidateOrder()
    {
        Trace.WriteLine("Validating Order...");
        Console.WriteLine("Order Validated");
    }

    static void ProcessPayment()
    {
        Trace.WriteLine("Processing Payment...");
        Console.WriteLine("Payment Processed");
    }

    static void UpdateInventory()
    {
        Trace.WriteLine("Updating Inventory...");
        Console.WriteLine("Inventory Updated");
    }

    static void GenerateInvoice()
    {
        Trace.WriteLine("Generating Invoice...");
        Console.WriteLine("Invoice Generated");
    }
}
