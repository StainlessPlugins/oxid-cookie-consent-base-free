[{assign var="oConfig" value=$oViewConf->getConfig()}]
<script type="text/javascript">
    var sBaseUrl = '[{$oViewConf->getSelfActionLink()}]';
    var sActCl = '[{$oViewConf->getTopActiveClassName()}]';
</script>

[{if $oViewConf->getViewThemeParam('blUseGAPageTracker')}]
    [{include file="widget/google_analytics.tpl" }]
[{/if}]
[{if $oViewConf->getViewThemeParam('blUseGAEcommerceTracking')}]
    [{include file="widget/google_ecommerce.tpl" }]
[{/if}]

[{if $oViewConf->getViewThemeParam('blUseGoogleTS')}]
    [{include file="widget/google_vendor.tpl" }]
[{/if}]

[{oxscript}]

[{if method_exists($oViewConf,"getCookieConsentScript") }]
[{assign var="cookieConsentScript" value=$oViewConf->getCookieConsentScript()}]
    [{$cookieConsentScript}]
[{else}]
    <p>We working hard to protect your privacy and to include a new cookie consent solution, some features will not work unless we finalized this</p>
[{/if}]
