<#-- Extract token from Keycloak link and build Doctaura URL -->
<#function buildDoctauraLink kcLink baseUrl>
    <#if kcLink?contains("key=")>
        <#local token = kcLink?split("key=")?last>
        <#-- Remove any trailing parameters -->
        <#if token?contains("&")>
            <#local token = token?split("&")?first>
        </#if>
        <#return baseUrl + "?token=" + token>
    <#else>
        <#return kcLink>
    </#if>
</#function>

<#macro emailLayout>
<!DOCTYPE html>
<html lang="${locale!'en'}" dir="${(locale?? && locale == 'ar')?then('rtl', 'ltr')}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>${kcSanitize(msg("realmName"))?no_esc}</title>
    <!--[if mso]>
    <style type="text/css">
        body, table, td {font-family: Arial, Helvetica, sans-serif !important;}
    </style>
    <![endif]-->
</head>
<body style="margin: 0; padding: 0; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif; background-color: #f8fafc; color: #334155; line-height: 1.6; -webkit-font-smoothing: antialiased;">
    
    <!-- Wrapper Table -->
    <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="background-color: #f8fafc;">
        <tr>
            <td align="center" style="padding: 40px 20px;">
                
                <!-- Main Card -->
                <table role="presentation" width="600" cellpadding="0" cellspacing="0" style="max-width: 600px; width: 100%; background: #ffffff; border-radius: 16px; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1); overflow: hidden;">
                    
                    <!-- Header -->
                    <tr>
                        <td align="center" style="background: linear-gradient(135deg, #14B8A6 0%, #0D9488 100%); padding: 32px 24px;">
                            <!-- Logo -->
                            <table role="presentation" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td align="center">
                                        <div style="width: 64px; height: 64px; background: #ffffff; border-radius: 16px; display: inline-block; text-align: center; line-height: 64px; margin-bottom: 16px;">
                                            <span style="font-size: 32px; font-weight: 700; color: #14B8A6; font-family: Arial, sans-serif;">D</span>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <h1 style="color: #ffffff; font-size: 24px; font-weight: 600; margin: 0; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Arial, sans-serif;">
                                            Doctaura
                                        </h1>
                                        <p style="color: rgba(255,255,255,0.8); font-size: 14px; margin: 4px 0 0 0;">
                                            ${kcSanitize(msg("brandTagline"))?no_esc}
                                        </p>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    
                    <!-- Content Area -->
                    <tr>
                        <td style="padding: 32px 32px 24px 32px;">
                            <#nested>
                        </td>
                    </tr>
                    
                    <!-- Footer -->
                    <tr>
                        <td style="background: #f8fafc; padding: 24px 32px; border-top: 1px solid #e2e8f0;">
                            <table role="presentation" width="100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td align="center">
                                        <p style="color: #64748b; font-size: 14px; margin: 0 0 8px 0; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Arial, sans-serif;">
                                            ${kcSanitize(msg("footerText"))?no_esc}
                                        </p>
                                        <p style="color: #64748b; font-size: 14px; margin: 0 0 8px 0;">
                                            <a href="mailto:${msg("supportEmail")}" style="color: #14B8A6; text-decoration: none;">${msg("supportEmail")}</a>
                                            &nbsp;|&nbsp;
                                            <span>${msg("supportPhone")}</span>
                                        </p>
                                        <p style="color: #94a3b8; font-size: 12px; margin: 16px 0 0 0;">
                                            ${kcSanitize(msg("footerAddress"))?no_esc}
                                        </p>
                                        <p style="color: #94a3b8; font-size: 12px; margin: 8px 0 0 0;">
                                            <a href="${msg("frontendPrivacyUrl")}" style="color: #14B8A6; text-decoration: none;">${kcSanitize(msg("footerPrivacy"))?no_esc}</a>
                                        </p>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    
                </table>
                <!-- End Main Card -->
                
            </td>
        </tr>
    </table>
    <!-- End Wrapper -->
    
</body>
</html>
</#macro>

<#-- 
================================================================================
REUSABLE COMPONENTS
================================================================================
--#>

<#-- Primary CTA Button -->
<#macro button url text>
<table role="presentation" cellpadding="0" cellspacing="0" style="margin: 24px auto;">
    <tr>
        <td align="center" style="background: linear-gradient(135deg, #14B8A6 0%, #0D9488 100%); border-radius: 8px; box-shadow: 0 4px 14px rgba(20, 184, 166, 0.4);">
            <a href="${url}" target="_blank" style="display: inline-block; padding: 14px 32px; color: #ffffff; text-decoration: none; font-weight: 600; font-size: 16px; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Arial, sans-serif;">
                ${text}
            </a>
        </td>
    </tr>
</table>
</#macro>

<#-- Info Box (Teal background) -->
<#macro infoBox>
<table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="margin: 24px 0;">
    <tr>
        <td style="background: #f0fdfa; border-radius: 8px; padding: 20px;">
            <#nested>
        </td>
    </tr>
</table>
</#macro>

<#-- Warning Box (Yellow background) -->
<#macro warningBox>
<table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="margin: 24px 0;">
    <tr>
        <td style="background: #fef3c7; border-left: 4px solid #f59e0b; border-radius: 0 8px 8px 0; padding: 16px 20px;">
            <#nested>
        </td>
    </tr>
</table>
</#macro>

<#-- Alert Box (Red background) -->
<#macro alertBox>
<table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="margin: 24px 0;">
    <tr>
        <td style="background: #fee2e2; border-left: 4px solid #ef4444; border-radius: 0 8px 8px 0; padding: 16px 20px;">
            <#nested>
        </td>
    </tr>
</table>
</#macro>

<#-- Link Fallback Box -->
<#macro linkFallback url>
<table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="margin: 24px 0;">
    <tr>
        <td style="background: #f1f5f9; border-radius: 8px; padding: 16px;">
            <p style="color: #64748b; font-size: 14px; margin: 0 0 8px 0; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Arial, sans-serif;">
                ${kcSanitize(msg("buttonClickIssue"))?no_esc}
            </p>
            <p style="color: #14B8A6; font-size: 12px; word-break: break-all; margin: 0; font-family: monospace;">
                ${url}
            </p>
        </td>
    </tr>
</table>
</#macro>

<#-- Expiry Notice -->
<#macro expiryNotice expiration>
<p style="color: #64748b; font-size: 14px; text-align: center; margin: 24px 0 0 0; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Arial, sans-serif;">
    ${kcSanitize(msg("linkExpireNotice", expiration))?no_esc}
</p>
</#macro>

<#-- Text Paragraph -->
<#macro paragraph>
<p style="color: #334155; font-size: 16px; line-height: 1.6; margin: 0 0 16px 0; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Arial, sans-serif;">
    <#nested>
</p>
</#macro>

<#-- Section Title -->
<#macro sectionTitle>
<p style="font-weight: 600; color: #0f172a; font-size: 16px; margin: 0 0 12px 0; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Arial, sans-serif;">
    <#nested>
</p>
</#macro>