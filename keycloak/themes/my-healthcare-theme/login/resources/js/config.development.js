// Development Configuration
// This file is used during local development

window.DoctauraConfig = {
  apiBaseUrl: "http://localhost:5000/api/public",
  environment: "development",
  features: {
    useMockData: true,  // Always use mock data in development
    enableDebugLogs: true,
  }
};
