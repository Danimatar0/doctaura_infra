<#import "template.ftl" as layout>

<#-- Determine action type and build appropriate link -->
<#assign token = link?split("key=")?last?split("&")?first>
<#if requiredActions?? && requiredActions?seq_contains("UPDATE_PASSWORD")>
    <#assign doctauraLink = msg("frontendResetPasswordUrl") + "?token=" + token>
<#elseif requiredActions?? && requiredActions?seq_contains("VERIFY_EMAIL")>
    <#assign doctauraLink = msg("frontendVerifyEmailUrl") + "?token=" + token>
<#else>
    <#assign doctauraLink = msg("frontendCompleteActionUrl") + "?token=" + token>
</#if>

<@layout.emailLayout>
    <@layout.paragraph>
        ${kcSanitize(msg("executeActionsIntro"))?no_esc}
    </@layout.paragraph>
    
    <@layout.paragraph>
        ${kcSanitize(msg("executeActionsBody"))?no_esc}
    </@layout.paragraph>
    
    <@layout.infoBox>
        <ul style="margin: 0; padding-left: 20px; color: #334155;">
            <#if requiredActions??>
                <#list requiredActions as reqAction>
                    <li style="margin-bottom: 8px;">${kcSanitize(msg("requiredAction.${reqAction}"))?no_esc}</li>
                </#list>
            </#if>
        </ul>
    </@layout.infoBox>
    
    <@layout.button url=doctauraLink text=kcSanitize(msg("executeActionsButton"))?no_esc />
    
    <@layout.expiryNotice expiration=linkExpiration />
    
    <@layout.linkFallback url=doctauraLink />
</@layout.emailLayout>