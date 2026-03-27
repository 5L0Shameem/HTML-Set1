using System;
using System.IO;

class DriveMonitor
{
    static void Main()
    {
        try
        {
            DriveInfo[] drives = DriveInfo.GetDrives();

            foreach (DriveInfo drive in drives)
            {
                if (!drive.IsReady)
                    continue;

                Console.WriteLine("Drive Name: " + drive.Name);
                Console.WriteLine("Drive Type: " + drive.DriveType);
                Console.WriteLine("Total Size: " + drive.TotalSize + " bytes");
                Console.WriteLine("Free Space: " + drive.AvailableFreeSpace + " bytes");

                double freePercent = (double)drive.AvailableFreeSpace / drive.TotalSize * 100;

                if (freePercent < 15)
                {
                    Console.WriteLine("Warning: Low disk space!");
                }

                Console.WriteLine();
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine("Error: " + ex.Message);
        }
    }
}
