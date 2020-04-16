[{assign var="sGATrackingId" value=$oViewConf->getViewThemeParam('sGATrackingId')}]
[{if $sGATrackingId && $oViewConf->getTopActiveClassName() == 'thankyou'}]
    [{assign var="oOrder" value=$oView->getOrder()}]
[{/if}]
[{if $oOrder}]
    [{if !$oViewConf->getViewThemeParam('blUseGAPageTracker')}]
        [{include file="google_analytics.tpl"}]
    [{/if}]

    [{capture name="script" }]
        ga( 'require', 'ecommerce' );
        ga( 'ecommerce:addTransaction', {
        'id': '[{$oOrder->oxorder__oxordernr->value}]',
        'affiliation': '[{$oxcmp_shop->oxshops__oxname->value}]',
        'revenue': '[{$oOrder->oxorder__oxtotalordersum->value}]', // grand total.
        'shipping': '[{$oOrder->oxorder__oxdelcost->value}]',
        'tax': '[{math equation="x+y" x=$oOrder->oxorder__oxartvatprice1->value y=$oOrder->oxorder__oxartvatprice2->value}]'
        });

        [{foreach from=$oOrder->getOrderArticles() item="oOrderArticle"}]
            [{assign var="sArticleName" value=$oOrderArticle->oxorderarticles__oxtitle->value|cat:' '|cat:$oOrderArticle->oxorderarticles__oxselvariant->value}]
            [{assign var="categoryName" value=""}]
            [{assign var="oOrderArticlePrice" value=$oOrderArticle->getPrice()}]
            [{assign var="oArticle" value=$oOrderArticle->getArticle()}]
            [{if $oArticle}]
                [{assign var="oMainCategory" value=$oArticle->getCategory()}]
                [{if $oMainCategory}]
                    [{assign var="categoryName" value=$oMainCategory->oxcategories__oxtitle->value}]
                [{/if}]
            [{/if}]
            ga( 'ecommerce:addItem', {
            'id': '[{$oOrder->oxorder__oxordernr->value}]',
            'name': '[{$sArticleName|trim}]',
            'sku': '[{$oOrderArticle->oxorderarticles__oxartnum->value}]',
            'category': '[{$categoryName|trim}]',
            'price': '[{$oOrderArticlePrice->getBruttoPrice()}]',               // Unit price.
            'quantity': '[{$oOrderArticle->oxorderarticles__oxamount->value}]',
            'currency': '[{$oOrder->oxorder__oxcurrency->value}]'               // currency code.
            });
        [{/foreach}]

        ga('ecommerce:send' );
    [{/capture}]
    [{oxscript service="Google Analytics" add=$smarty.capture.script group="performance"}]
[{/if}]
