<?php


namespace StainlessPlugins\OxidCookieConsentBase\Core;

trait UtilsViewTrait
{
    /**
     * @inheritdoc
     */
    public function getTemplateDirs()
    {
        $dir = __DIR__ . "/../views/tpl";
        $this->setTemplateDir($dir);

        $res = parent::getTemplateDirs();
        $existingDirs = array_filter(
            $res,
            function ($piece) { return is_dir($piece); }
        );
        return array_values($existingDirs);
    }
}