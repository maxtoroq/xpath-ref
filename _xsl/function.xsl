<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" exclude-result-prefixes="#all"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:html="http://www.w3.org/1999/xhtml"
   xmlns="http://www.w3.org/1999/xhtml">

   <xsl:import href="../xmlspectrum/app/xsl/xmlspectrum.xsl"/>

   <xsl:param name="new-line" select="'&#13;&#10;'"/>

   <xsl:key name="id" match="*[@id]" use="@id"/>

   <xsl:variable name="xspecs" xmlns="">
      <spec href="http://www.w3.org/TR/xpath-30/" specref="XP30" errorref="XP" bibref="xpath-30">
         <xml href="../_build/specs/xpath-30.xml"/>
      </spec>
      <spec href="http://www.w3.org/TR/xpath-datamodel-30/" specref="DM30" errorref="DM" bibref="xpath-datamodel-30">
         <xml href="../_build/specs/xpath-datamodel-30.xml"/>
      </spec>
      <spec href="http://www.w3.org/TR/xslt-xquery-serialization-30/" specref="SER30" errorref="SER" bibref="xslt-xquery-serialization-30">
         <xml href="../_build/specs/xslt-xquery-serialization-30.xml"/>
      </spec>
      <spec href="http://www.w3.org/TR/xquery-semantics/" bibref="xquery-semantics"/>
      <spec href="http://www.w3.org/TR/xml/" bibref="xml"/>
      <spec href="http://www.w3.org/TR/xinclude/" bibref="xinclude"/>
      <spec href="http://www.w3.org/TR/xquery/" bibref="xquery"/>
      <spec href="http://www.w3.org/TR/xslt20/" bibref="xslt20"/>
      <spec href="http://www.w3.org/TR/xslt-30/" bibref="xslt-30"/>
   </xsl:variable>

   <xsl:variable name="spec-loc" select="/*/header/latestloc/loc[1]"/>
   <xsl:variable name="spec-url" select="$spec-loc/@href"/>

   <xsl:variable name="spec-v2-loc" select="$spec-v2/*/header/latestloc/loc[1]"/>

   <xsl:template name="function">
      <xsl:param name="exists-in-v2" as="xs:boolean"/>
      
      <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
      <html itemscope="itemscope" itemtype="http://schema.org/WebPage">
         <head>
            <meta name="viewport" content="width=device-width,initial-scale=1.0"/>
            <title>
               <xsl:value-of select="head"/>
            </title>
            <link rel="stylesheet" href="../bootstrap/dist/css/bootstrap.min.css"/>
            <link rel="stylesheet" href="../site.css"/>
            <link rel="shortcut icon" href="../favicon.ico"/>
         </head>
         <body>
            <xsl:call-template name="navigation-header">
               <xsl:with-param name="breadcrumb-items" as="element()+">
                  <li>
                     <a href="../">XPath Reference</a>
                  </li>
                  <li class="active">
                     <xsl:value-of select="head"/>
                  </li>
               </xsl:with-param>
            </xsl:call-template>
            <article class="container" itemscope="itemscope" itemtype="http://schema.org/WebPageElement" itemprop="mainContentOfPage">
               <header>
                  <h1 class="page-header">
                     <xsl:value-of select="head"/>
                  </h1>
               </header>
               <xsl:apply-templates select="node()[not(self::head)]"/>
               <footer>
                  <h2>See Also</h2>
                  <ul>
                     <li>
                        <a href="{$spec-loc/@href}#func-{if (substring-before(head, ':') eq 'math') then 'math-' else ''}{substring-after(head, ':')}">
                           <xsl:value-of select="$spec-loc/ancestor::header[1]/title"/>
                        </a>
                     </li>
                     <xsl:if test="$exists-in-v2">
                        <li>
                           <a href="{$spec-v2-loc/@href}#func-{substring-after(head, ':')}">
                              <xsl:value-of select="$spec-v2-loc/ancestor::header[1]/title"/>
                           </a>
                        </li>
                     </xsl:if>
                     <li>
                        <a href="http://www.saxonica.com/html/documentation/functions/{substring-before(head, ':')}/{substring-after(head, ':')}.html">Saxon Function Library</a>
                     </li>
                  </ul>
               </footer>
            </article>
            <footer>
               <div class="container">
                  <xsl:call-template name="copyright"/>
               </div>
            </footer>
         </body>
      </html>
   </xsl:template>

   <xsl:template name="navigation-header">
      <xsl:param name="breadcrumb-items" as="element(html:li)+"/>
      
      <header role="navigation">
         <nav class="container">
            <div class="col-md-9 breadcrumb-col">
               <ol class="breadcrumb" itemprop="breadcrumb">
                  <xsl:sequence select="$breadcrumb-items"/>
               </ol>
            </div>
            <div class="col-md-3 search-col" xmlns:gcse="http://www.google.com/cse">
               <script>
                  <xsl:variable name="js" as="text()">
                     <![CDATA[
                     (function() {
                        var cx = '012329136009221431645:sv1eakamyny';
                        var gcse = document.createElement('script');
                        gcse.type = 'text/javascript';
                        gcse.async = true;
                        gcse.src = (document.location.protocol == 'https:' ? 'https:' : 'http:') + '//www.google.com/cse/cse.js?cx=' + cx;
                        var s = document.getElementsByTagName('script')[0];
                        s.parentNode.insertBefore(gcse, s);
                     })();
                     ]]>
                  </xsl:variable>
                  <xsl:value-of select="normalize-space($js)" disable-output-escaping="yes"/>
               </script>
               <gcse:searchbox-only></gcse:searchbox-only>
            </div>
         </nav>
      </header>
   </xsl:template>
   
   <xsl:template name="copyright">
      <small class="copyright">
         <xsl:text>Portions of this document were copied from </xsl:text>
         <a href="{/*/header/altlocs/loc[string()='XML']/@href}">
            <xsl:value-of select="$spec-loc/../@doc"/>
         </a>
         <xsl:text>, </xsl:text>
         <a href="http://www.w3.org/Consortium/Legal/ipr-notice#Copyright">Copyright</a>
         <xsl:text>&#xa0;©&#xa0;2014&#xa0;</xsl:text>
         <a href="http://www.w3.org/">
            <acronym title="World Wide Web Consortium">W3C</acronym>
         </a>
         <sup>®</sup>
         <xsl:text> (</xsl:text>
         <a href="http://www.csail.mit.edu/">
            <acronym title="Massachusetts Institute of Technology">MIT</acronym>
         </a>
         <xsl:text>, </xsl:text>
         <a href="http://www.ercim.eu/">
            <acronym title="European Research Consortium for Informatics and Mathematics">ERCIM</acronym>
         </a>
         <xsl:text>, </xsl:text>
         <a href="http://www.keio.ac.jp/">Keio</a>
         <xsl:text>, </xsl:text>
         <a href="http://ev.buaa.edu.cn/">Beihang</a>
         <xsl:text>), All Rights Reserved.</xsl:text>
      </small>
   </xsl:template>
   
   <xsl:template match="div1|div2|div3|div4|gitem[label[text() != 'Summary']]">
      <section>
         <xsl:apply-templates/>
      </section>
   </xsl:template>

   <xsl:template match="gitem/label">
      <header>
         <h2>
            <xsl:value-of select="."/>
         </h2>
      </header>
   </xsl:template>
   
   <xsl:template match="gitem/label[text() = 'Summary']" priority="1"/>

   <xsl:template match="p|code">
      <xsl:element name="{local-name()}" namespace="http://www.w3.org/1999/xhtml">
         <xsl:apply-templates select="node()" mode="#current"/>
      </xsl:element>
   </xsl:template>

   <xsl:template match="olist">
      <ol>
         <xsl:apply-templates select="node()" mode="#current"/>
      </ol>
   </xsl:template>

   <xsl:template match="ulist">
      <ul>
         <xsl:apply-templates select="node()" mode="#current"/>
      </ul>
   </xsl:template>

   <xsl:template match="item">
      <li>
         <xsl:apply-templates select="node()" mode="#current"/>
      </li>
   </xsl:template>

   <xsl:template match="note">
      <blockquote>
         <xsl:apply-templates select="node()" mode="#current"/>
      </blockquote>
   </xsl:template>

   <xsl:template match="example[head and not(@role='signature')]">
      <div class="panel panel-default">
        <div class="panel-heading">
          <h3 class="panel-title">
             <xsl:value-of select="'Example:', head"/>
          </h3>
        </div>
        <div class="panel-body">
           <xsl:apply-templates select="node()[not(self::head)]"/>
        </div>
      </div>
   </xsl:template>
   
   <xsl:template match="eg">
      <pre>
         <code>
            <xsl:variable name="code" select="replace(., '^\s', '')"/>
            <xsl:variable name="is-xml" select="starts-with($code, '&lt;')"/>
            <xsl:sequence select="if ($is-xml) then f:render($code, 'xslt', 'xsl') else loc:showXPath($code)" xmlns:f="internal" xmlns:loc="com.qutoric.sketchpath.functions"/>
         </code>
      </pre>
   </xsl:template>

   <xsl:template match="proto">
      <xsl:variable name="code" as="text()+">
         <xsl:value-of select="@prefix, ':', @name, '('" separator=""/>
         <xsl:for-each select="arg">
            <xsl:if test="position() gt 1">, </xsl:if>
            <xsl:if test="last() > 1">
               <xsl:value-of select="$new-line"/>
               <xsl:text>    </xsl:text>
            </xsl:if>
            <xsl:value-of select="'$', @name, ' as ', @type" separator=""/>
         </xsl:for-each>
         <xsl:if test="count(arg) > 1">
            <xsl:value-of select="$new-line"/>
         </xsl:if>
         <xsl:value-of select="') as ', @return-type" separator=""/>
      </xsl:variable>
      <pre>
         <code class="signature">
            <xsl:sequence select="loc:showXPath(string-join($code, ''))" xmlns:loc="com.qutoric.sketchpath.functions"/>
         </code>
      </pre>
   </xsl:template>

   <xsl:template match="var">
      <i>
         <xsl:apply-templates/>
      </i>
   </xsl:template>

   <xsl:template match="rfc2119">
      <b>
         <xsl:apply-templates/>
      </b>
   </xsl:template>
   
   <xsl:template match="loc[@href]">
      <a href="{resolve-uri(@href, $spec-url)}">
         <xsl:value-of select="."/>
      </a>
   </xsl:template>

   <xsl:template match="specref">
      <a href="{$spec-url}#{@ref}">
         <xsl:value-of select="key('id', @ref)/head"/>
      </a>
   </xsl:template>

   <xsl:template match="termref">
      <a href="{$spec-url}#{@def}">
         <xsl:value-of select="(text(), key('id', @def)/@term, @def)[1]"/>
      </a>
   </xsl:template>

   <xsl:template match="bibref">
      <xsl:variable name="spec" select="$xspecs/*[@bibref=current()/@ref]"/>
      <xsl:variable name="bibl" select="key('id', @ref)"/>
      <xsl:variable name="href" select="($bibl/loc[1]/@href, $spec/@href)[1]"/>
      
      <xsl:element name="{if ($href) then 'a' else 'span'}">
         <xsl:if test="$href">
            <xsl:attribute name="href" select="$href"/>
         </xsl:if>
         <xsl:text>[</xsl:text>
         <xsl:value-of select="$bibl/@key"/>
         <xsl:text>]</xsl:text>
      </xsl:element>
   </xsl:template>

   <xsl:template match="errorref">
      <xsl:text>[</xsl:text>
      <a href="{$spec-url}#ERRFO{@class}{@code}">
         <xsl:value-of select="'ERRFO', @class, @code" separator=""/>
      </a>
      <xsl:text>]</xsl:text>
   </xsl:template>

   <xsl:template match="xspecref">

      <xsl:variable name="spec" select="$xspecs/*[@specref=current()/@spec]"/>
      
      <a href="{$spec/@href}#{@ref}">
         <xsl:value-of select="$spec/xml/doc(@href)//*[@id=current()/@ref]/head/string()"/>
      </a>
   </xsl:template>

   <xsl:template match="xerrorref">

      <xsl:variable name="spec" select="$xspecs/*[@errorref=current()/@spec]"/>

      <xsl:text>[</xsl:text>
      <a href="{$spec/@href}#ERR{@spec}{@class}{@code}">
         <xsl:value-of select="'ERR', @spec, @class, @code" separator=""/>
      </a>
      <xsl:text>]</xsl:text>
   </xsl:template>

   <!-- Omit deleted section -->
   <xsl:template match="*[@diff='del']" priority="10"/>
   
</xsl:stylesheet>
