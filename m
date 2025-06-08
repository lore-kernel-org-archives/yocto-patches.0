Return-Path: <michael@amarulasolutions.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92C6C5AD49
	for <webhook@archiver.kernel.org>; Sun,  8 Jun 2025 10:20:07 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
 by mx.groups.io with SMTP id smtpd.web11.34955.1749378001602796597
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 08 Jun 2025 03:20:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amarulasolutions.com header.s=google header.b=r58acp86;
 spf=pass (domain: amarulasolutions.com, ip: 209.85.215.170, mailfrom: michael@amarulasolutions.com)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b2f645eba5dso1082871a12.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 08 Jun 2025 03:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1749378000; x=1749982800; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+MtoWFpIkrOAExwPHJ4S5PRmbkNvkquVQJ402IOlE4=;
        b=r58acp86DRdKitqJ+0qLnQqstrDZauZnk8FVGz+wyPz6xzI2En+BE7rshgQtUNla6I
         IRjY+pEB/A/ZcdmNKX8LtG4K3vEfWrUHo901pkX/VuIcbiXFJA6Yo67hxIRGwH84q5Vw
         cia2bNUFrurvUOmWtRa9kPrky7po+0UQOm1jM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749378000; x=1749982800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+MtoWFpIkrOAExwPHJ4S5PRmbkNvkquVQJ402IOlE4=;
        b=cS46ZEua/3l4qU1+f/aAyQooW2hy5A/U/04f9zwh4OzQBtip0yvjx+S+aWkhbZsVq+
         4xA6UGno2ArN6Go8FeKty+VbjJu8TcgBZ1XPd2/9NZ+umyhc+aF7yswabNUJwW8jkbnc
         7PxE0GybK57t7VyZ34+7OvUN3Ym5sium9DoHJGAXh2NX1+vAnR4eUUH2cSs17RZINpsH
         RvnnjTVvpQoLIUghECtUB+5WNg/6Jpy0UHFEq9VWv3G9GebbvalMjwjsf5M22J7JQR2Q
         CEvIGdjgg30KZ+8pwcWqUn60MpIrVr/6cGT1gyO4Hhb4/aTWRULJ0e3MCwr5BNaK9L5h
         Dvbw==
X-Gm-Message-State: AOJu0Yw7d2IjSccjEsQQs4+KKruGrWJhd1RnpgIJBH7pCK6wpke2MoKb
	sJcjOB9uqXdISEHBXngBJbdGiB6tmW5JkH+m7lEgFhGNlgYOTjetSu8mA6ZFitHLzxjx9B0EmYB
	VNma/qV5/REIv8lMFO/5+M4hMWM82QQpuDPC6sAbx6ak9wnzHpnRf
X-Gm-Gg: ASbGnct71z1Lb/x9BmqXrynOoaxz8KA72GhUH0pKKezKt9hhcKxMCPH44h36yCD4oAn
	EurrDNtnPIitjjwtyJhK20KqvDEXcQFV4yyXrN9OK+Pp82iXfDky3yE3HgSLMppwH5mz4Rn1U0W
	X99BTnR7CkGag9lx8sdFXaHMDSMcTffw==
X-Google-Smtp-Source: AGHT+IGiDwF7rP/1MUFP4BgPFSQa8Vc/ftzILd/FAv7Ha6PFoSyYtH0v2T55zTTX+QbxnTkYb8gEritq9tD0yV48Cok=
X-Received: by 2002:a17:90b:48d0:b0:312:e751:8213 with SMTP id
 98e67ed59e1d1-31349fb548cmr13872198a91.13.1749377999857; Sun, 08 Jun 2025
 03:19:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250605051442.11141-1-michael@amarulasolutions.com>
In-Reply-To: <20250605051442.11141-1-michael@amarulasolutions.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sun, 8 Jun 2025 12:19:48 +0200
X-Gm-Features: AX0GCFtg7YxAmL0dyTGsvm6T9ifCbC6Z6W7gcF7uJ6sY5uUJFjQpY1Lt5h4E2B8
Message-ID: <CAOf5uw=nmwSR=aHrVAW+vhXT7DBcphO+o49rH3wYk5G-W4mP8Q@mail.gmail.com>
Subject: Re: [meta-java][RFC PATCH] recipes-core: Fix download url for java package
To: yocto-patches@lists.yoctoproject.org
Cc: Henning Heinold <henning@itconsulting-heinold.de>, 
	Otavio Salvador <otavio@ossystems.com.br>, Richard Leitner <richard.leitner@skidata.com>, 
	linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 08 Jun 2025 10:20:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1623

Hi all

Anyone can provide some feedback?

On Thu, Jun 5, 2025 at 7:14=E2=80=AFAM Michael Trimarchi
<michael@amarulasolutions.com> wrote:
>
> According to https://archive.apache.org/dist/
>
> The directories and files linked below are a historical archive of
> software released by Apache Software Foundation projects.
>
> THEY MAY BE UNSUPPORTED AND UNSAFE TO USE
> Current releases can be found on our download server.
>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>  recipes-core/ant/ant-native_1.8.1.bb                      | 2 +-
>  recipes-core/bcel/bcel_5.2.bb                             | 2 +-
>  recipes-core/jakarta-commons/commons-cli_1.1.bb           | 2 +-
>  recipes-core/jakarta-commons/commons-codec_1.3.bb         | 2 +-
>  recipes-core/jakarta-commons/commons-collections_2.1.1.bb | 2 +-
>  recipes-core/jakarta-commons/commons-digester_1.8.bb      | 2 +-
>  recipes-core/jakarta-commons/commons-discovery_0.4.bb     | 2 +-
>  recipes-core/jakarta-commons/commons-el_1.0.bb            | 2 +-
>  recipes-core/jakarta-commons/commons-fileupload_1.2.1.bb  | 2 +-
>  recipes-core/jakarta-commons/commons-httpclient_3.1.bb    | 2 +-
>  recipes-core/jakarta-commons/commons-io_1.4.bb            | 2 +-
>  recipes-core/jakarta-commons/commons-lang_2.4.bb          | 2 +-
>  recipes-core/jakarta-commons/commons-logging_1.1.1.bb     | 2 +-
>  recipes-core/jakarta-commons/commons-net_1.4.1.bb         | 2 +-
>  recipes-core/jakarta-commons/commons-pool_1.4.bb          | 2 +-
>  recipes-core/jakarta-libs/avalon-framework-api_4.3.bb     | 4 ++--
>  recipes-core/jakarta-libs/log4j1.2_1.2.17.bb              | 2 +-
>  recipes-core/jakarta-libs/logkit_1.2.2.bb                 | 2 +-
>  recipes-core/jakarta-libs/oro_2.0.8.bb                    | 2 +-
>  recipes-core/jakarta-libs/poi_3.0.bb                      | 2 +-
>  recipes-core/jakarta-libs/regexp_1.5.bb                   | 2 +-
>  recipes-core/servlet-api/jsp2.0_5.5.26.bb                 | 2 +-
>  recipes-core/servlet-api/servlet2.3_4.1.37.bb             | 2 +-
>  recipes-core/servlet-api/servlet2.4_5.5.26.bb             | 2 +-
>  recipes-core/xalan-j/xalan-j_2.7.1.bb                     | 2 +-
>  recipes-core/xerces-j/xerces-j_2.11.0.bb                  | 2 +-
>  recipes-core/xml-commons/dom4j_1.6.1.bb                   | 2 +-
>  recipes-core/xml-commons/jaxp1.3_1.4.01.bb                | 2 +-
>  recipes-core/xml-commons/xml-commons-resolver1.1_1.2.bb   | 2 +-
>  29 files changed, 30 insertions(+), 30 deletions(-)
>
> diff --git a/recipes-core/ant/ant-native_1.8.1.bb b/recipes-core/ant/ant-=
native_1.8.1.bb
> index b81f71d..75bfbdf 100644
> --- a/recipes-core/ant/ant-native_1.8.1.bb
> +++ b/recipes-core/ant/ant-native_1.8.1.bb
> @@ -5,7 +5,7 @@ LICENSE =3D "Apache-2.0"
>  LIC_FILES_CHKSUM =3D "file://LICENSE;md5=3D503bb72c4dd62dd216d6820d5b869=
442"
>  PR =3D "r1"
>
> -SRC_URI =3D "http://archive.apache.org/dist/ant/source/apache-ant-${PV}-=
src.tar.gz \
> +SRC_URI =3D "https://downloads.apache.org/ant/source/apache-ant-${PV}-sr=
c.tar.gz \
>            file://ant \
>           "
>
> diff --git a/recipes-core/bcel/bcel_5.2.bb b/recipes-core/bcel/bcel_5.2.b=
b
> index 7a8f46f..a525add 100644
> --- a/recipes-core/bcel/bcel_5.2.bb
> +++ b/recipes-core/bcel/bcel_5.2.bb
> @@ -3,7 +3,7 @@ AUTHOR =3D "Apache Software Foundation"
>  LICENSE =3D "Apache-2.0"
>  LIC_FILES_CHKSUM =3D "file://LICENSE.txt;md5=3D44030f19e8bad73725f39d16f=
d05ff12"
>  PR =3D "r1"
> -SRC_URI =3D "http://archive.apache.org/dist/jakarta/bcel/source/${BP}-sr=
c.tar.gz"
> +SRC_URI =3D "https://downloads.apache.org/jakarta/bcel/source/${BP}-src.=
tar.gz"
>
>  inherit java-library
>
> diff --git a/recipes-core/jakarta-commons/commons-cli_1.1.bb b/recipes-co=
re/jakarta-commons/commons-cli_1.1.bb
> index 2b83a03..3e73cab 100644
> --- a/recipes-core/jakarta-commons/commons-cli_1.1.bb
> +++ b/recipes-core/jakarta-commons/commons-cli_1.1.bb
> @@ -5,7 +5,7 @@ PR =3D "${INC_PR}.1"
>
>  SUMMARY =3D "Java argument parsing helper classes"
>
> -SRC_URI =3D "http://archive.apache.org/dist/commons/cli/source/${BP}-src=
.tar.gz"
> +SRC_URI =3D "https://downloads.apache.org/commons/cli/source/${BP}-src.t=
ar.gz"
>
>  SRC_URI[sha256sum] =3D "929eb140c136673e7f5029cd206c81b3c1f5e66bba0dfdcd=
021b9dd5596356d2"
>
> diff --git a/recipes-core/jakarta-commons/commons-codec_1.3.bb b/recipes-=
core/jakarta-commons/commons-codec_1.3.bb
> index cfaada5..e638d54 100644
> --- a/recipes-core/jakarta-commons/commons-codec_1.3.bb
> +++ b/recipes-core/jakarta-commons/commons-codec_1.3.bb
> @@ -5,7 +5,7 @@ PR =3D "${INC_PR}.1"
>
>  DESCRIPTION =3D "Java library with simple encoder and decoders for vario=
us formats such as Base64 and Hexadecimal"
>
> -SRC_URI =3D "http://archive.apache.org/dist/commons/codec/source/${BP}-s=
rc.tar.gz"
> +SRC_URI =3D "https://downloads.apache.org/commons/codec/source/${BP}-src=
.tar.gz"
>
>  S =3D "${WORKDIR}/${BP}"
>
> diff --git a/recipes-core/jakarta-commons/commons-collections_2.1.1.bb b/=
recipes-core/jakarta-commons/commons-collections_2.1.1.bb
> index 898a7df..566835d 100644
> --- a/recipes-core/jakarta-commons/commons-collections_2.1.1.bb
> +++ b/recipes-core/jakarta-commons/commons-collections_2.1.1.bb
> @@ -4,7 +4,7 @@ PR =3D "${INC_PR}.1"
>
>  DESCRIPTION =3D "A set of abstract data type interfaces and implementati=
ons that offer a wealth of useful functionality and a solid foundation for =
extending that functionality"
>
> -SRC_URI =3D "http://archive.apache.org/dist/commons/collections/source/$=
{BP}-src.tar.gz"
> +SRC_URI =3D "https://downloads.apache.org/commons/collections/source/${B=
P}-src.tar.gz"
>
>
>  SRC_URI[sha256sum] =3D "73eb5907a31c8770480c70f6a6a8d9a9a2ffe602e1b461c0=
45cff51ace4cab2a"
> diff --git a/recipes-core/jakarta-commons/commons-digester_1.8.bb b/recip=
es-core/jakarta-commons/commons-digester_1.8.bb
> index 7e595ee..9c80860 100644
> --- a/recipes-core/jakarta-commons/commons-digester_1.8.bb
> +++ b/recipes-core/jakarta-commons/commons-digester_1.8.bb
> @@ -4,7 +4,7 @@ PR =3D "${INC_PR}.1"
>
>  SUMMARY =3D "Converts XML to a Java object by a set of mapping rules."
>
> -SRC_URI =3D "http://archive.apache.org/dist/commons/digester/source/${BP=
}-src.tar.gz"
> +SRC_URI =3D "https://downloads.apache.org/commons/digester/source/${BP}-=
src.tar.gz"
>
>  DEPENDS +=3D "commons-logging commons-beanutils"
>  RDEPENDS:${PN} =3D "libcommons-logging-java libcommons-beanutils-java"
> diff --git a/recipes-core/jakarta-commons/commons-discovery_0.4.bb b/reci=
pes-core/jakarta-commons/commons-discovery_0.4.bb
> index 60cf683..8a64bb9 100644
> --- a/recipes-core/jakarta-commons/commons-discovery_0.4.bb
> +++ b/recipes-core/jakarta-commons/commons-discovery_0.4.bb
> @@ -5,7 +5,7 @@ PR =3D "${INC_PR}.1"
>
>  SUMMARY =3D "discovering, or finding, implementations for pluggable inte=
rfaces"
>
> -SRC_URI =3D "http://archive.apache.org/dist/commons/discovery/source/${B=
P}-src.tar.gz"
> +SRC_URI =3D "https://downloads.apache.org/commons/discovery/source/${BP}=
-src.tar.gz"
>
>  DEPENDS +=3D "commons-logging"
>  RDEPENDS:${PN} =3D "libcommons-logging-java"
> diff --git a/recipes-core/jakarta-commons/commons-el_1.0.bb b/recipes-cor=
e/jakarta-commons/commons-el_1.0.bb
> index b93b68f..94ca635 100644
> --- a/recipes-core/jakarta-commons/commons-el_1.0.bb
> +++ b/recipes-core/jakarta-commons/commons-el_1.0.bb
> @@ -5,7 +5,7 @@ PR =3D "${INC_PR}.1"
>
>  SUMMARY =3D "Implementation of the JSP2.0 Expression Language API"
>
> -SRC_URI =3D "http://archive.apache.org/dist/commons/el/source/${BP}-src.=
tar.gz"
> +SRC_URI =3D "https://downloads.apache.org/commons/el/source/${BP}-src.ta=
r.gz"
>
>  DEPENDS +=3D "jsp2.0 servlet2.4"
>  RDEPENDS:${PN} =3D "libjsp2.0-java libservlet2.4-java"
> diff --git a/recipes-core/jakarta-commons/commons-fileupload_1.2.1.bb b/r=
ecipes-core/jakarta-commons/commons-fileupload_1.2.1.bb
> index 71a866b..36d2dde 100644
> --- a/recipes-core/jakarta-commons/commons-fileupload_1.2.1.bb
> +++ b/recipes-core/jakarta-commons/commons-fileupload_1.2.1.bb
> @@ -5,7 +5,7 @@ PR =3D "${INC_PR}.1"
>
>  DESCRIPTION =3D "Robust, high-performance, file upload capability for Ja=
va servlets and web applications"
>
> -SRC_URI =3D "http://archive.apache.org/dist/commons/fileupload/source/${=
BP}-src.tar.gz"
> +SRC_URI =3D "https://downloads.apache.org/commons/fileupload/source/${BP=
}-src.tar.gz"
>
>  DEPENDS +=3D "commons-beanutils commons-io servlet2.3"
>  RDEPENDS:${PN} =3D "libcommons-beanutils-java libcommons-io-java libserv=
let2.3-java"
> diff --git a/recipes-core/jakarta-commons/commons-httpclient_3.1.bb b/rec=
ipes-core/jakarta-commons/commons-httpclient_3.1.bb
> index b4e5e2a..89a2fce 100644
> --- a/recipes-core/jakarta-commons/commons-httpclient_3.1.bb
> +++ b/recipes-core/jakarta-commons/commons-httpclient_3.1.bb
> @@ -5,7 +5,7 @@ PR =3D "${INC_PR}.1"
>
>  DESCRIPTION =3D "Efficient, up-to-date, and feature-rich package impleme=
nting the client side of the most recent HTTP standards and recommendations=
"
>
> -SRC_URI =3D "http://archive.apache.org/dist/httpcomponents/commons-httpc=
lient/source/${BP}-src.tar.gz"
> +SRC_URI =3D "https://downloads.apache.org/httpcomponents/commons-httpcli=
ent/source/${BP}-src.tar.gz"
>
>  S =3D "${WORKDIR}/${BP}"
>
> diff --git a/recipes-core/jakarta-commons/commons-io_1.4.bb b/recipes-cor=
e/jakarta-commons/commons-io_1.4.bb
> index 799a9d4..bc92a24 100644
> --- a/recipes-core/jakarta-commons/commons-io_1.4.bb
> +++ b/recipes-core/jakarta-commons/commons-io_1.4.bb
> @@ -5,6 +5,6 @@ PR =3D "${INC_PR}.1"
>
>  DESCRIPTION =3D "Java library with utility classes, stream implementatio=
ns, file filters and endian classes"
>
> -SRC_URI =3D "http://archive.apache.org/dist/commons/io/source/${BP}-src.=
tar.gz"
> +SRC_URI =3D "https://downloads.apache.org/commons/io/source/${BP}-src.ta=
r.gz"
>
>  SRC_URI[sha256sum] =3D "eca986497f7b4d1b1ec41821b1b5df827bb31fc14833e444=
9cfa8bcd5d7f29bb"
> diff --git a/recipes-core/jakarta-commons/commons-lang_2.4.bb b/recipes-c=
ore/jakarta-commons/commons-lang_2.4.bb
> index e0c3736..bbb10e9 100644
> --- a/recipes-core/jakarta-commons/commons-lang_2.4.bb
> +++ b/recipes-core/jakarta-commons/commons-lang_2.4.bb
> @@ -5,7 +5,7 @@ PR =3D "${INC_PR}.1"
>
>  DESCRIPTION =3D "Set of Java classes that provide helper methods for the=
 standard java.lang classes"
>
> -SRC_URI =3D "http://archive.apache.org/dist/commons/lang/source/${BP}-sr=
c.tar.gz"
> +SRC_URI =3D "https://downloads.apache.org/commons/lang/source/${BP}-src.=
tar.gz"
>
>
>  SRC_URI[sha256sum] =3D "2445238cd0eb167e99a1147394f61325490559f3df7e7e8f=
628043fb70cbf2f4"
> diff --git a/recipes-core/jakarta-commons/commons-logging_1.1.1.bb b/reci=
pes-core/jakarta-commons/commons-logging_1.1.1.bb
> index 6de3228..7045e9e 100644
> --- a/recipes-core/jakarta-commons/commons-logging_1.1.1.bb
> +++ b/recipes-core/jakarta-commons/commons-logging_1.1.1.bb
> @@ -4,7 +4,7 @@ PR =3D "${INC_PR}.1"
>
>  SUMMARY =3D "Java Internet protocol suite library"
>
> -SRC_URI =3D "http://archive.apache.org/dist/commons/logging/source/${BP}=
-src.tar.gz"
> +SRC_URI =3D "https://downloads.apache.org/commons/logging/source/${BP}-s=
rc.tar.gz"
>
>  DEPENDS +=3D "log4j1.2 servlet2.3 logkit"
>
> diff --git a/recipes-core/jakarta-commons/commons-net_1.4.1.bb b/recipes-=
core/jakarta-commons/commons-net_1.4.1.bb
> index bffbbae..a62d55b 100644
> --- a/recipes-core/jakarta-commons/commons-net_1.4.1.bb
> +++ b/recipes-core/jakarta-commons/commons-net_1.4.1.bb
> @@ -5,7 +5,7 @@ PR =3D "${INC_PR}.1"
>  SUMMARY =3D "Java Internet protocol suite library"
>  LIC_FILES_CHKSUM =3D "file://LICENSE.txt;md5=3D3b83ef96387f14655fc854ddc=
3c6bd57"
>
> -SRC_URI =3D "http://archive.apache.org/dist/commons/net/source/${BP}-src=
.tar.gz"
> +SRC_URI =3D "https://downloads.apache.org/commons/net/source/${BP}-src.t=
ar.gz"
>
>  S =3D "${WORKDIR}/${BP}"
>
> diff --git a/recipes-core/jakarta-commons/commons-pool_1.4.bb b/recipes-c=
ore/jakarta-commons/commons-pool_1.4.bb
> index 824b772..9ca7171 100644
> --- a/recipes-core/jakarta-commons/commons-pool_1.4.bb
> +++ b/recipes-core/jakarta-commons/commons-pool_1.4.bb
> @@ -5,6 +5,6 @@ PR =3D "${INC_PR}.1"
>
>  SUMMARY =3D "Java Object-pooling API"
>
> -SRC_URI =3D "http://archive.apache.org/dist/commons/pool/source/${BP}-sr=
c.tar.gz"
> +SRC_URI =3D "https://downloads.apache.org/commons/pool/source/${BP}-src.=
tar.gz"
>
>  SRC_URI[sha256sum] =3D "ca4452f2a2ce2daf6eaa1743ded2d3b36013200c48e3f211=
7b65584ca5cc1d9b"
> diff --git a/recipes-core/jakarta-libs/avalon-framework-api_4.3.bb b/reci=
pes-core/jakarta-libs/avalon-framework-api_4.3.bb
> index 081cfe7..d2bf3d7 100644
> --- a/recipes-core/jakarta-libs/avalon-framework-api_4.3.bb
> +++ b/recipes-core/jakarta-libs/avalon-framework-api_4.3.bb
> @@ -5,8 +5,8 @@ LIC_FILES_CHKSUM =3D "file://LICENSE.txt;md5=3D1dece7821b=
f3fd70fe1309eaa37d52a2"
>  PR =3D "r1"
>
>  SRC_URI =3D " \
> -          http://archive.apache.org/dist/excalibur/avalon-framework/sour=
ce/${BP}-src.tar.gz;name=3Darchive \
> -          http://archive.apache.org/dist/avalon/logkit/source/logkit-1.2=
.2-src.tar.gz;name=3Dlogkit \
> +          https://downloads.apache.org/excalibur/avalon-framework/source=
/${BP}-src.tar.gz;name=3Darchive \
> +          https://downloads.apache.org/avalon/logkit/source/logkit-1.2.2=
-src.tar.gz;name=3Dlogkit \
>           "
>
>  inherit java-library
> diff --git a/recipes-core/jakarta-libs/log4j1.2_1.2.17.bb b/recipes-core/=
jakarta-libs/log4j1.2_1.2.17.bb
> index bd8c9d8..9f52671 100644
> --- a/recipes-core/jakarta-libs/log4j1.2_1.2.17.bb
> +++ b/recipes-core/jakarta-libs/log4j1.2_1.2.17.bb
> @@ -5,7 +5,7 @@ LIC_FILES_CHKSUM =3D "file://LICENSE;md5=3Df4ce41a6d10284=
98fcacde12f589bce7"
>
>  PR =3D "r2"
>
> -SRC_URI =3D "http://archive.apache.org/dist/logging/log4j/${PV}/log4j-${=
PV}.tar.gz"
> +SRC_URI =3D "https://downloads.apache.org/logging/log4j/${PV}/log4j-${PV=
}.tar.gz"
>
>  inherit java-library
>
> diff --git a/recipes-core/jakarta-libs/logkit_1.2.2.bb b/recipes-core/jak=
arta-libs/logkit_1.2.2.bb
> index c3d83a5..154d982 100644
> --- a/recipes-core/jakarta-libs/logkit_1.2.2.bb
> +++ b/recipes-core/jakarta-libs/logkit_1.2.2.bb
> @@ -4,7 +4,7 @@ LICENSE =3D "Apache-2.0"
>  LIC_FILES_CHKSUM =3D "file://LICENSE.txt;md5=3Df1a1c8e1996e51c4dbc73e592=
a2ecf05"
>  PR =3D "r1"
>
> -SRC_URI =3D "http://archive.apache.org/dist/avalon/logkit/source/${BP}-s=
rc.tar.gz"
> +SRC_URI =3D "https://downloads.apache.org/avalon/logkit/source/${BP}-src=
.tar.gz"
>
>  inherit java-library
>
> diff --git a/recipes-core/jakarta-libs/oro_2.0.8.bb b/recipes-core/jakart=
a-libs/oro_2.0.8.bb
> index 80efd49..8e3a249 100644
> --- a/recipes-core/jakarta-libs/oro_2.0.8.bb
> +++ b/recipes-core/jakarta-libs/oro_2.0.8.bb
> @@ -4,7 +4,7 @@ LICENSE =3D "Apache-2.0"
>  LIC_FILES_CHKSUM =3D "file://LICENSE;md5=3D372b1e91335021ca74173b2ab4dc9=
7dd"
>  PR =3D "r1"
>
> -SRC_URI =3D "http://archive.apache.org/dist/jakarta/oro/source/jakarta-$=
{BP}.tar.gz"
> +SRC_URI =3D "https://downloads.apache.org/jakarta/oro/source/jakarta-${B=
P}.tar.gz"
>
>  inherit java-library
>
> diff --git a/recipes-core/jakarta-libs/poi_3.0.bb b/recipes-core/jakarta-=
libs/poi_3.0.bb
> index 3733c3c..f67314b 100644
> --- a/recipes-core/jakarta-libs/poi_3.0.bb
> +++ b/recipes-core/jakarta-libs/poi_3.0.bb
> @@ -3,7 +3,7 @@ LICENSE =3D "Apache-2.0"
>  LIC_FILES_CHKSUM =3D "file://LICENSE;md5=3D3b83ef96387f14655fc854ddc3c6b=
d57"
>  AUTHOR =3D "Apache Software Foundation"
>
> -SRC_URI =3D "http://archive.apache.org/dist/jakarta/poi/release/src/${BP=
N}-src-${PV}-FINAL-20070503.tar.gz"
> +SRC_URI =3D "https://downloads.apache.org/jakarta/poi/release/src/${BPN}=
-src-${PV}-FINAL-20070503.tar.gz"
>
>  S =3D "${WORKDIR}/${BPN}-3.0-rc4"
>
> diff --git a/recipes-core/jakarta-libs/regexp_1.5.bb b/recipes-core/jakar=
ta-libs/regexp_1.5.bb
> index 40dec0a..60635b4 100644
> --- a/recipes-core/jakarta-libs/regexp_1.5.bb
> +++ b/recipes-core/jakarta-libs/regexp_1.5.bb
> @@ -4,7 +4,7 @@ LICENSE =3D "Apache-2.0"
>  LIC_FILES_CHKSUM =3D "file://LICENSE;md5=3D86d3f3a95c324c9479bd8986968f4=
327"
>  PR =3D "r1"
>
> -SRC_URI =3D "http://archive.apache.org/dist/jakarta/regexp/source/jakart=
a-${BP}.tar.gz"
> +SRC_URI =3D "https://downloads.apache.org/jakarta/regexp/source/jakarta-=
${BP}.tar.gz"
>
>  inherit java-library
>
> diff --git a/recipes-core/servlet-api/jsp2.0_5.5.26.bb b/recipes-core/ser=
vlet-api/jsp2.0_5.5.26.bb
> index 3d9f4da..5f84249 100644
> --- a/recipes-core/servlet-api/jsp2.0_5.5.26.bb
> +++ b/recipes-core/servlet-api/jsp2.0_5.5.26.bb
> @@ -3,7 +3,7 @@ LICENSE =3D "Apache-2.0"
>  LIC_FILES_CHKSUM =3D "file://LICENSE;md5=3D3b83ef96387f14655fc854ddc3c6b=
d57"
>  AUTHOR =3D "Apache Software Foundation"
>
> -SRC_URI =3D "http://archive.apache.org/dist/tomcat/tomcat-5/v${PV}/src/a=
pache-tomcat-${PV}-src.tar.gz"
> +SRC_URI =3D "https://downloads.apache.org/tomcat/tomcat-5/v${PV}/src/apa=
che-tomcat-${PV}-src.tar.gz"
>
>  S =3D "${WORKDIR}/apache-tomcat-${PV}-src/servletapi/jsr152"
>
> diff --git a/recipes-core/servlet-api/servlet2.3_4.1.37.bb b/recipes-core=
/servlet-api/servlet2.3_4.1.37.bb
> index dceece6..0bf8552 100644
> --- a/recipes-core/servlet-api/servlet2.3_4.1.37.bb
> +++ b/recipes-core/servlet-api/servlet2.3_4.1.37.bb
> @@ -4,7 +4,7 @@ LICENSE =3D "Apache-2.0"
>  LIC_FILES_CHKSUM =3D "file://LICENSE;md5=3D3b83ef96387f14655fc854ddc3c6b=
d57"
>  PR =3D "r1"
>
> -SRC_URI =3D "http://archive.apache.org/dist/tomcat/tomcat-4/v${PV}/src/a=
pache-tomcat-${PV}-src.tar.gz"
> +SRC_URI =3D "https://downloads.apache.org/tomcat/tomcat-4/v${PV}/src/apa=
che-tomcat-${PV}-src.tar.gz"
>
>  inherit java-library
>
> diff --git a/recipes-core/servlet-api/servlet2.4_5.5.26.bb b/recipes-core=
/servlet-api/servlet2.4_5.5.26.bb
> index eb2f769..1cc8d6e 100644
> --- a/recipes-core/servlet-api/servlet2.4_5.5.26.bb
> +++ b/recipes-core/servlet-api/servlet2.4_5.5.26.bb
> @@ -3,7 +3,7 @@ LICENSE =3D "Apache-2.0"
>  LIC_FILES_CHKSUM =3D "file://LICENSE;md5=3D3b83ef96387f14655fc854ddc3c6b=
d57"
>  AUTHOR =3D "Apache Software Foundation"
>
> -SRC_URI =3D "http://archive.apache.org/dist/tomcat/tomcat-5/v${PV}/src/a=
pache-tomcat-${PV}-src.tar.gz"
> +SRC_URI =3D "https://downloads.apache.org/tomcat/tomcat-5/v${PV}/src/apa=
che-tomcat-${PV}-src.tar.gz"
>
>  S =3D "${WORKDIR}/apache-tomcat-${PV}-src/servletapi/jsr154"
>
> diff --git a/recipes-core/xalan-j/xalan-j_2.7.1.bb b/recipes-core/xalan-j=
/xalan-j_2.7.1.bb
> index 5e72a34..b697da2 100644
> --- a/recipes-core/xalan-j/xalan-j_2.7.1.bb
> +++ b/recipes-core/xalan-j/xalan-j_2.7.1.bb
> @@ -12,7 +12,7 @@ PR =3D "r2"
>  DEPENDS =3D "xerces-j regexp jlex cup jaxp1.3 bcel"
>
>  SRC_URI =3D "\
> -       http://archive.apache.org/dist/xml/${BPN}/${BPN}_2_7_1-src.tar.gz=
;name=3Darchive \
> +       https://downloads.apache.org/xml/${BPN}/${BPN}_2_7_1-src.tar.gz;n=
ame=3Darchive \
>         https://dlcdn.apache.org/commons/bsf/source/bsf-src-2.4.0.tar.gz;=
name=3Dbsf \
>         "
>
> diff --git a/recipes-core/xerces-j/xerces-j_2.11.0.bb b/recipes-core/xerc=
es-j/xerces-j_2.11.0.bb
> index 56ffe97..3b2a64d 100644
> --- a/recipes-core/xerces-j/xerces-j_2.11.0.bb
> +++ b/recipes-core/xerces-j/xerces-j_2.11.0.bb
> @@ -12,7 +12,7 @@ LIC_FILES_CHKSUM =3D " \
>                      file://LICENSE.serializer.txt;md5=3Dd229da563da18fe5=
d58cd95a6467d584 \
>                     "
>
> -SRC_URI =3D "http://archive.apache.org/dist/xerces/j/source/Xerces-J-src=
.${PV}.tar.gz"
> +SRC_URI =3D "https://downloads.apache.org/xerces/j/source/Xerces-J-src.$=
{PV}.tar.gz"
>
>  # CVE only applies to some Oracle Java SE and Red Hat Enterprise Linux v=
ersions.
>  # Already fixed with updates and closed.
> diff --git a/recipes-core/xml-commons/dom4j_1.6.1.bb b/recipes-core/xml-c=
ommons/dom4j_1.6.1.bb
> index 0ba3f0e..ac8d02e 100644
> --- a/recipes-core/xml-commons/dom4j_1.6.1.bb
> +++ b/recipes-core/xml-commons/dom4j_1.6.1.bb
> @@ -10,7 +10,7 @@ DEPENDS =3D "fastjar-native virtual/javac-native \
>
>  SRC_URI =3D "\
>          ${SOURCEFORGE_MIRROR}/dom4j/${P}.tar.gz;name=3Darchive \
> -        http://archive.apache.org/dist/ws/jaxme/source/ws-jaxme-0.5.2-sr=
c.tar.gz;name=3Djaxme \
> +        https://downloads.apache.org/ws/jaxme/source/ws-jaxme-0.5.2-src.=
tar.gz;name=3Djaxme \
>          file://debian.patch \
>  "
>  SRC_URI[archive.md5sum] =3D "1e7ef6d20939315714de4a8502f27b2d"
> diff --git a/recipes-core/xml-commons/jaxp1.3_1.4.01.bb b/recipes-core/xm=
l-commons/jaxp1.3_1.4.01.bb
> index 7965bb8..558f2c2 100644
> --- a/recipes-core/xml-commons/jaxp1.3_1.4.01.bb
> +++ b/recipes-core/xml-commons/jaxp1.3_1.4.01.bb
> @@ -9,7 +9,7 @@ LIC_FILES_CHKSUM =3D " \
>                      file://LICENSE.sax.txt;md5=3D3534555610af53d4b5a8a0d=
2fb017d35 \
>                     "
>
> -SRC_URI =3D "http://archive.apache.org/dist/xml/commons/source/xml-commo=
ns-external-${PV}-src.tar.gz;subdir=3D${BPN}-${PV}"
> +SRC_URI =3D "https://downloads.apache.org/xml/commons/source/xml-commons=
-external-${PV}-src.tar.gz;subdir=3D${BPN}-${PV}"
>
>  inherit java-library
>
> diff --git a/recipes-core/xml-commons/xml-commons-resolver1.1_1.2.bb b/re=
cipes-core/xml-commons/xml-commons-resolver1.1_1.2.bb
> index 0fafcea..0174aeb 100644
> --- a/recipes-core/xml-commons/xml-commons-resolver1.1_1.2.bb
> +++ b/recipes-core/xml-commons/xml-commons-resolver1.1_1.2.bb
> @@ -4,7 +4,7 @@ LICENSE =3D "Apache-2.0"
>  PR =3D "r1"
>  LIC_FILES_CHKSUM =3D "file://LICENSE.resolver.txt;md5=3Dd229da563da18fe5=
d58cd95a6467d584"
>
> -SRC_URI =3D "http://archive.apache.org/dist/xml/commons/xml-commons-reso=
lver-${PV}.tar.gz"
> +SRC_URI =3D "https://downloads.apache.org/xerces/xml-commons/xml-commons=
-resolver-${PV}.tar.gz"
>
>  inherit java-library
>
> --
> 2.43.0
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com

