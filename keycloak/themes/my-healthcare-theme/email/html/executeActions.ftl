<#import "template.ftl" as layout>
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
    
    <@layout.button url=link text=kcSanitize(msg("executeActionsButton"))?no_esc />
    
    <@layout.expiryNotice expiration=linkExpiration />
    
    <@layout.linkFallback url=link />
    
</@layout.emailLayout>