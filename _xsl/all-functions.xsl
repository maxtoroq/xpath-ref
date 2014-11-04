<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" exclude-result-prefixes="#all"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:local="http://maxtoroq.github.io/xpath-ref"
   xmlns="http://www.w3.org/1999/xhtml">

   <xsl:import href="function.xsl"/>

   <xsl:param name="index-only" as="xs:boolean" select="false()"/>
   <xsl:param name="spec-v2" as="document-node()" required="yes"/>
   
   <xsl:output name="html" method="xhtml" indent="no" omit-xml-declaration="yes" use-character-maps="html"/>

   <xsl:character-map name="html">
      <xsl:output-character character="&#xa0;" string="&amp;nbsp;"/>
   </xsl:character-map>

   <xsl:variable name="functions" select=".//*[head[not(*) and (some $prefix in ('fn', 'math') satisfies starts-with(text(), concat($prefix, ':')))]]"/>
   <xsl:variable name="functions-20" select="$spec-v2//*[head/starts-with(string(), 'fn:') or example[@role='signature']/proto[@isOp='no' and not(@role='example')]]"/>

   <xsl:template match="/">

      <xsl:result-document href="{resolve-uri('../index.html')}" format="html">
         <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
         <html itemscope="itemscope" itemtype="http://schema.org/WebPage">
            <head>
               <meta name="viewport" content="width=device-width,initial-scale=1.0"/>
               <title>XPath Reference</title>
               <link rel="stylesheet" href="bootstrap/dist/css/bootstrap.min.css"/>
               <link rel="stylesheet" href="bootstrap-vertical-tabs/bootstrap.vertical-tabs.min.css"/>
               <link rel="stylesheet" href="site.css"/>
               <link rel="shortcut icon" href="favicon.ico"/>
               <meta name="description" content="XPath 3.0 Functions Reference"/>
            </head>
            <body class="index">
               <xsl:call-template name="navigation-header">
                  <xsl:with-param name="breadcrumb-items" as="element()+">
                     <li class="active">XPath Reference</li>
                  </xsl:with-param>
               </xsl:call-template>
               <div class="container">
                  <header>
                     <h1 class="page-header">
                        <xsl:text>XPath Functions</xsl:text>
                        <iframe src="github-buttons/github-btn.html?user=maxtoroq&amp;repo=xpath-ref&amp;type=watch&amp;size=large" allowtransparency="true" frameborder="0" scrolling="0" width="80" height="30" class="pull-right hidden-xs"></iframe>
                     </h1>
                  </header>
                  <xsl:call-template name="index"/>
               </div>
               <footer>
                  <div class="container">
                     <xsl:call-template name="copyright"/>
                  </div>
               </footer>
               <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
               <script src="bootstrap/dist/js/bootstrap.min.js"></script>
               <script>
                  <xsl:variable name="js" as="text()">
                     <![CDATA[
                     $(document).on('ready', function() { 
                        $('#function-filters :radio:checked').click();
                     });
                     
                     $(document).on('change', '#function-filters :radio', function() {
                        var version = parseFloat($(this).val());
                        $('.tab-pane a').each(function(){ 
                           $(this).toggleClass('disabled', $(this).data('xpath-version') > version); 
                        });
                     });
                     ]]>
                  </xsl:variable>
                  <xsl:value-of select="normalize-space($js)" disable-output-escaping="yes"/>
               </script>
            </body>
         </html>
      </xsl:result-document>

      <xsl:for-each select="$functions[not($index-only)]">
         <xsl:result-document href="{resolve-uri(concat('../', head/substring-before(., ':'), '/', local:file-name(.)))}" format="html">
            <xsl:call-template name="function">
               <xsl:with-param name="exists-in-v2" select="local:exists-in-v2(.)"/>
            </xsl:call-template>
         </xsl:result-document>
      </xsl:for-each>

   </xsl:template>

   <xsl:template name="index">

      <div class="col-xs-3 hidden-xs">
         <div id="function-filters">
            <div class="btn-group btn-group-xs" data-toggle="buttons">
               <label class="btn btn-default active">
                  <input type="radio" name="version" value="3.0" checked="checked"/>
                  <xsl:text>3.0</xsl:text>
               </label>
               <label class="btn btn-default">
                  <input type="radio" name="version" value="2.0"/>
                  <xsl:text>2.0</xsl:text>
              </label>
            </div>
         </div>
         <ul class="nav nav-tabs tabs-left" role="tablist">
            <li class="active">
               <a href="#all" role="tab" data-toggle="tab">All functions</a>
            </li>
            <xsl:for-each-group select="$functions" group-by="ancestor::div1[1]/head">
               <li>
                  <a href="#{local:title-to-id(current-grouping-key())}" role="tab" data-toggle="tab">
                     <xsl:value-of select="replace(ancestor::div1[1]/head, '\sand\soperators\s', ' ', 'i')"/>
                  </a>
               </li>
            </xsl:for-each-group>
         </ul>
      </div>

      <div class="col-xs-9">
         <div class="tab-content">
            <section class="tab-pane active" id="all">
               <div class="row">
                  <xsl:for-each-group select="$functions" group-by="head/substring(substring-after(., ':'), 1, 1)">
                     <xsl:sort select="current-grouping-key()" case-order="lower-first"/>

                     <section class="col-xs-12 col-sm-6 col-md-4">
                        <header>
                           <h3>
                              <xsl:value-of select="upper-case(substring(current-grouping-key(), 1, 1))"/>
                           </h3>
                        </header>
                        <xsl:for-each select="current-group()">
                           <xsl:sort select="substring-after(head, ':')" case-order="lower-first"/>
                           <xsl:call-template name="function-link"/>
                        </xsl:for-each>
                     </section>
                  </xsl:for-each-group>
               </div>
            </section>

            <xsl:for-each-group select="$functions" group-by="ancestor::div1[1]/head">
               <section class="tab-pane" id="{local:title-to-id(current-grouping-key())}">
                  <xsl:for-each select="current-group()">
                     <xsl:sort select="substring-after(head, ':')" case-order="lower-first"/>
                     <xsl:call-template name="function-link"/>
                  </xsl:for-each>
               </section>
            </xsl:for-each-group>
         </div>
      </div>
   </xsl:template>

   <xsl:template name="function-link">
      <a href="{head/substring-before(., ':')}/{local:file-name(.)}" data-xpath-version="{if (local:exists-in-v2(.)) then '2.0' else '3.0'}">
         <xsl:value-of select="head/substring-after(., ':')"/>
      </a>
   </xsl:template>

   <xsl:function name="local:exists-in-v2" as="xs:boolean">
      <xsl:param name="function" as="element()"/>

      <xsl:sequence select="exists($functions-20[example[1]/proto[1]/@name eq $function/head/substring-after(string(), ':')])"/>
   </xsl:function>
   
   <xsl:function name="local:file-name" as="xs:string">
      <xsl:param name="node" as="node()"/>

      <xsl:sequence select="concat($node/head/substring-after(., ':'), '.html')"/>
   </xsl:function>

   <xsl:function name="local:title-to-id" as="xs:string">
      <xsl:param name="title" as="item()"/>

      <xsl:sequence select="lower-case(replace($title, ' ', '-'))"/>
   </xsl:function>

</xsl:stylesheet>
