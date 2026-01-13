${msg("executeActionsGreeting")}

${msg("executeActionsIntro")}

${msg("executeActionsBody")}

<#if requiredActions??>
<#list requiredActions as reqAction>
- ${msg("requiredAction.${reqAction}")}
</#list>
</#if>

${link}

${msg("linkExpireNotice", linkExpiration)}

---
${msg("closing")},
${msg("teamSignature")}

${msg("footerAddress")}