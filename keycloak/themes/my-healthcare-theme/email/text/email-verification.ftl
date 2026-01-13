<#assign doctauraLink = msg("frontendVerifyEmailUrl") + "?token=" + link?split("key=")?last?split("&")?first>

${msg("emailVerificationGreeting")}

${msg("emailVerificationIntro")}

${msg("emailVerificationBody")}

${doctauraLink}

${msg("linkExpireNotice", linkExpiration)}

${msg("ignoreNotice")}

---
${msg("closing")},
${msg("teamSignature")}

${msg("footerAddress")}
