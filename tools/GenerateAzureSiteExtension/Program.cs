using GenerateAzureSiteExtension;

namespace PrepareRelease
{
    public class Program
    {
        public static void Main(string[] args)
        {
            SyncAzureAppServicesPackage.Run();
        }
    }
}
