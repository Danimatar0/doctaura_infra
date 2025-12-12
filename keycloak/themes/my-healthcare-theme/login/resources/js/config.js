// Configuration for Doctaura Healthcare Theme
// Update this file for different environments (dev, staging, production)

window.DoctauraConfig = {
  // API Base URL - Update this for your environment
  apiBaseUrl: "https://your-dotnet-api.onrender.com/api/public",

  // Environment identifier (optional)
  environment: "development", // "development" | "staging" | "production"

  // Feature flags (optional)
  features: {
    useMockData: false, // Set to true to always use mock data
    enableDebugLogs: true, // Set to false in production
  }
};
