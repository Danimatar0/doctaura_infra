// Production Configuration
// This file is used in production environment

window.DoctauraConfig = {
  apiBaseUrl: "https://api.doctaura.com/api/public",
  environment: "production",
  features: {
    useMockData: false,
    enableDebugLogs: false,  // Disable debug logs in production
  }
};
