<#import "template.ftl" as layout>

<#-- Build Doctaura frontend link with token -->
<#assign token = link?split("key=")?last?split("&")?first>
<#assign doctauraLink = msg("frontendResetPasswordUrl") + "?token=" + token>

<@layout.emailLayout>
    <@layout.paragraph>
        ${kcSanitize(msg("passwordResetIntro"))?no_esc}
    </@layout.paragraph>
    
    <@layout.paragraph>
        ${kcSanitize(msg("passwordResetBody"))?no_esc}
    </@layout.paragraph>
    
    <@layout.button url=doctauraLink text=kcSanitize(msg("passwordResetButton"))?no_esc />
    
    <@layout.warningBox>
        <@layout.sectionTitle>${kcSanitize(msg("passwordResetSecurityTips"))?no_esc}</@layout.sectionTitle>
        <ul style="margin: 0; padding-left: 20px; color: #92400e; font-size: 14px;">
            <li style="margin-bottom: 6px;">${kcSanitize(msg("passwordResetTip1"))?no_esc}</li>
            <li style="margin-bottom: 6px;">${kcSanitize(msg("passwordResetTip2"))?no_esc}</li>
            <li style="margin-bottom: 6px;">${kcSanitize(msg("passwordResetTip3"))?no_esc}</li>
            <li>${kcSanitize(msg("passwordResetTip4"))?no_esc}</li>
        </ul>
    </@layout.warningBox>
    
    <@layout.expiryNotice expiration=linkExpiration />
    
    <@layout.paragraph>
        ${kcSanitize(msg("passwordResetNotRequested"))?no_esc}
    </@layout.paragraph>
    
    <@layout.linkFallback url=doctauraLink />
</@layout.emailLayout>