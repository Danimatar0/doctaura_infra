<#import "template.ftl" as layout>

<#-- Build Doctaura frontend link with token -->
<#assign token = link?split("key=")?last?split("&")?first>
<#assign doctauraLink = msg("frontendVerifyEmailUrl") + "?token=" + token>

<@layout.emailLayout>
    <@layout.paragraph>
        ${kcSanitize(msg("emailVerificationIntro"))?no_esc}
    </@layout.paragraph>
    
    <@layout.paragraph>
        ${kcSanitize(msg("emailVerificationBody"))?no_esc}
    </@layout.paragraph>
    
    <@layout.button url=doctauraLink text=kcSanitize(msg("emailVerificationButton"))?no_esc />
    
    <@layout.infoBox>
        <@layout.sectionTitle>${kcSanitize(msg("emailVerificationBenefits"))?no_esc}</@layout.sectionTitle>
        <ul style="margin: 0; padding-left: 20px; color: #334155;">
            <li style="margin-bottom: 8px;">${kcSanitize(msg("emailVerificationBenefit1"))?no_esc}</li>
            <li style="margin-bottom: 8px;">${kcSanitize(msg("emailVerificationBenefit2"))?no_esc}</li>
            <li>${kcSanitize(msg("emailVerificationBenefit3"))?no_esc}</li>
        </ul>
    </@layout.infoBox>
    
    <@layout.expiryNotice expiration=linkExpiration />
    
    <@layout.linkFallback url=doctauraLink />
</@layout.emailLayout>