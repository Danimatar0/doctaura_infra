<#assign doctauraLink = msg("frontendResetPasswordUrl") + "?token=" + link?split("key=")?last?split("&")?first>

${msg("passwordResetGreeting")}

${msg("passwordResetIntro")}

${msg("passwordResetBody")}

${doctauraLink}

${msg("linkExpireNotice", linkExpiration)}

${msg("passwordResetSecurityTips")}
- ${msg("passwordResetTip1")}
- ${msg("passwordResetTip2")}
- ${msg("passwordResetTip3")}
- ${msg("passwordResetTip4")}

${msg("passwordResetNotRequested")}

---
${msg("closing")},
${msg("teamSignature")}

${msg("footerAddress")}
