<#macro emailLayout>
<!DOCTYPE html>
<html lang="${locale}" dir="${(locale == 'ar')?then('rtl', 'ltr')}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${msg("realmName")}</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            background-color: #f8fafc;
            color: #334155;
            line-height: 1.6;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 40px 20px;
        }
        .card {
            background: #ffffff;
            border-radius: 16px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        .header {
            background: linear-gradient(135deg, #14B8A6 0%, #0D9488 100%);
            padding: 32px;
            text-align: center;
        }
        .logo {
            width: 64px;
            height: 64px;
            background: #ffffff;
            border-radius: 16px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 16px;
        }
        .logo-text {
            font-size: 28px;
            font-weight: 700;
            color: #14B8A6;
        }
        .header h1 {
            color: #ffffff;
            font-size: 24px;
            font-weight: 600;
            margin: 0;
        }
        .content {
            padding: 32px;
        }
        .greeting {
            font-size: 18px;
            font-weight: 600;
            color: #0f172a;
            margin-bottom: 16px;
        }
        .button {
            display: inline-block;
            padding: 14px 32px;
            background: linear-gradient(135deg, #14B8A6 0%, #0D9488 100%);
            color: #ffffff !important;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            font-size: 16px;
            margin: 24px 0;
            box-shadow: 0 4px 14px rgba(20, 184, 166, 0.4);
        }
        .button:hover {
            background: linear-gradient(135deg, #0D9488 0%, #0F766E 100%);
        }
        .benefits {
            background: #f0fdfa;
            border-radius: 8px;
            padding: 20px;
            margin: 24px 0;
        }
        .benefits-title {
            font-weight: 600;
            color: #0f172a;
            margin-bottom: 12px;
        }
        .benefits ul {
            margin: 0;
            padding-left: 20px;
        }
        .benefits li {
            color: #334155;
            margin-bottom: 8px;
        }
        .security-tips {
            background: #fef3c7;
            border-left: 4px solid #f59e0b;
            padding: 16px;
            margin: 24px 0;
            border-radius: 0 8px 8px 0;
        }
        .warning {
            background: #fee2e2;
            border-left: 4px solid #ef4444;
            padding: 16px;
            margin: 24px 0;
            border-radius: 0 8px 8px 0;
        }
        .link-fallback {
            background: #f1f5f9;
            border-radius: 8px;
            padding: 16px;
            margin-top: 24px;
            word-break: break-all;
            font-size: 14px;
            color: #64748b;
        }
        .footer {
            background: #f8fafc;
            padding: 24px 32px;
            text-align: center;
            border-top: 1px solid #e2e8f0;
        }
        .footer p {
            color: #64748b;
            font-size: 14px;
            margin: 8px 0;
        }
        .footer a {
            color: #14B8A6;
            text-decoration: none;
        }
        .expiry-notice {
            display: inline-block;
            background: #e2e8f0;
            color: #64748b;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 14px;
            margin-top: 16px;
        }
        /* RTL Support */
        [dir="rtl"] .benefits {
            padding-right: 20px;
        }
        [dir="rtl"] .benefits ul {
            padding-left: 0;
            padding-right: 20px;
        }
        [dir="rtl"] .security-tips,
        [dir="rtl"] .warning {
            border-left: none;
            border-right: 4px solid;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="header">
                <div class="logo">
                    <span class="logo-text">D</span>
                </div>
                <h1>${msg("realmName")}</h1>
            </div>
            <div class="content">
                <#nested>
            </div>
            <div class="footer">
                <p>${msg("footerText")}</p>
                <p>${msg("footerSupport", msg("supportEmail"), msg("supportPhone"))}</p>
                <p>${msg("footerAddress")}</p>
            </div>
        </div>
    </div>
</body>
</html>
</#macro>