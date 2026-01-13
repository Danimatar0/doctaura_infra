<#-- Determine action type and build appropriate link -->
<#assign token = link?split("key=")?last?split("&")?first>
<#if requiredActions?? && requiredActions?seq_contains("UPDATE_PASSWORD")>
    <#assign doctauraLink = msg("frontendResetPasswordUrl") + "?token=" + token>
<#elseif requiredActions?? && requiredActions?seq_contains("VERIFY_EMAIL")>
    <#assign doctauraLink = msg("frontendVerifyEmailUrl") + "?token=" + token>
<#else>
    <#assign doctauraLink = msg("frontendCompleteActionUrl") + "?token=" + token>
</#if>

${msg("executeActionsGreeting")}

${msg("executeActionsIntro")}

${msg("executeActionsBody")}

<#if requiredActions??>
<#list requiredActions as reqAction>
- ${msg("requiredAction.${reqAction}")}
</#list>
</#if>

${doctauraLink}

${msg("linkExpireNotice", linkExpiration)}

---
${msg("closing")},
${msg("teamSignature")}

${msg("footerAddress")}
