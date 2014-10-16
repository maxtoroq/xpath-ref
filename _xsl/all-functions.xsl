<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" exclude-result-prefixes="#all"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:local="http://maxtoroq.github.io/xpath-ref"
   xmlns="http://www.w3.org/1999/xhtml">

   <xsl:import href="function.xsl"/>

   <xsl:param name="index-only" select="false()"/>
   
   <xsl:output name="html" method="xhtml" indent="no" omit-xml-declaration="yes" use-character-maps="html"/>

   <xsl:character-map name="html">
      <xsl:output-character character="&#xa0;" string="&amp;nbsp;"/>
   </xsl:character-map>

   <xsl:template match="/">

      <xsl:variable name="functions" select=".//*[head[not(*) and (some $prefix in ('fn', 'math') satisfies starts-with(text(), concat($prefix, ':')))]]"/>

      <xsl:result-document href="{resolve-uri('../index.html')}" format="html">
         <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
         <html>
            <head>
               <meta name="viewport" content="width=device-width,initial-scale=1.0"/>
               <title>XPath Reference</title>
               <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css"/>
               <link rel="stylesheet" href="bootstrap-vertical-tabs/bootstrap.vertical-tabs.min.css"/>
               <link rel="stylesheet" href="css/site.css"/>
               <link rel="shortcut icon" href="favicon.ico"/>
            </head>
            <body class="index">
               <div class="container">
                  <ol class="breadcrumb">
                     <li class="active">XPath Reference</li>
                  </ol>
                  <h1 class="page-header">XPath Functions</h1>
                  <xsl:call-template name="index">
                     <xsl:with-param name="functions" select="$functions"/>
                  </xsl:call-template>
               </div>
               <footer>
                  <div class="container">
                     <xsl:call-template name="copyright"/>
                  </div>
               </footer>

               <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
               <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
            </body>
         </html>
      </xsl:result-document>

      <xsl:for-each select="$functions[not($index-only)]">
         <xsl:result-document href="{resolve-uri(concat('../functions/', local:file-name(.)))}" format="html">
            <xsl:call-template name="function"/>
         </xsl:result-document>
      </xsl:for-each>

   </xsl:template>

   <xsl:template name="index">
      <xsl:param name="functions" as="element()+"/>

      <div class="col-xs-3 hidden-xs">
         <ul class="nav nav-tabs tabs-left" role="tablist">
            <li class="active">
               <a href="#all" role="tab" data-toggle="tab">All functions</a>
            </li>
            <xsl:for-each-group select="$functions" group-by="ancestor::div1[1]">
               <li>
                  <a href="#{generate-id()}" role="tab" data-toggle="tab">
                     <xsl:value-of select="replace(ancestor::div1[1]/head, '\sand\soperators\s', ' ', 'i')"/>
                  </a>
               </li>
            </xsl:for-each-group>
         </ul>
      </div>

      <div class="col-xs-9">
         <div class="tab-content">
            <div class="tab-pane active" id="all">
               <div class="row">
                  <xsl:for-each-group select="$functions" group-by="head/substring(substring-after(., ':'), 1, 1)">
                     <xsl:sort select="current-grouping-key()" case-order="lower-first"/>

                     <div class="col-xs-12 col-sm-6 col-md-4">
                        <h3>
                           <xsl:value-of select="upper-case(substring(current-grouping-key(), 1, 1))"/>
                        </h3>
                        <xsl:for-each select="current-group()">
                           <a href="functions/{local:file-name(.)}">
                              <xsl:value-of select="head/substring-after(., ':')"/>
                           </a>
                        </xsl:for-each>
                     </div>
                  </xsl:for-each-group>
               </div>
            </div>

            <xsl:for-each-group select="$functions" group-by="ancestor::div1[1]">
               <div class="tab-pane" id="{generate-id()}">
                  <xsl:for-each select="current-group()">
                     <xsl:sort select="head" case-order="lower-first"/>
                     <a href="functions/{local:file-name(.)}">
                        <xsl:value-of select="head/substring-after(., ':')"/>
                     </a>
                  </xsl:for-each>
               </div>
            </xsl:for-each-group>
         </div>
      </div>
   </xsl:template>

   <xsl:function name="local:file-name" as="xs:string">
      <xsl:param name="node" as="node()"/>

      <xsl:sequence select="concat($node/head/substring-after(., ':'), '.html')"/>
   </xsl:function>

</xsl:stylesheet>
