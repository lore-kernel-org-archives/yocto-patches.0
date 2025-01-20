Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01622C02187
	for <webhook@archiver.kernel.org>; Mon, 20 Jan 2025 01:11:58 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
 by mx.groups.io with SMTP id smtpd.web11.27838.1737335512710385003
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 19 Jan 2025 17:11:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=nJLzg0Ot;
 spf=pass (domain: gmail.com, ip: 209.85.167.54, mailfrom: ticotimo@gmail.com)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54026562221so4007377e87.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 19 Jan 2025 17:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737335510; x=1737940310; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bq0kpLr+vviCj73wSRJma2D9SB4fLFtj08Qv0ksfIXY=;
        b=nJLzg0OtOCKoBhsC1IpbuHd9NN9O2ag1kKfCJFKvPfPjeFBMerW9enLJcSeAq858rE
         rpkHHcE0LpYz1OLi4dNGA3uOTErE5WDF214OYZwTgTN1Nkr/64U5Yar/2bBP79Nm6v1+
         cuzOCiFXgyIJlMH7kszCekO07i8grZ6PRUXsnpPOC/H4BIW7sT/NVtl/YHKxSLVTbG6H
         akV9DHpoTiJGpKxuOFD4BmRvERkDMBTbTf/NpInYjrG32D4zjyXj2Z0Oc8SK7iEXwpIr
         DW31bS4DRNo1H9CqRpLlKPrjcXxc9WG8IvMdvTbxA9bzYmzX/Tx8gWAWY1UdfFy1rD7m
         biWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737335510; x=1737940310;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bq0kpLr+vviCj73wSRJma2D9SB4fLFtj08Qv0ksfIXY=;
        b=Bj2T6ruebSbXjNJ0S6mIzVTVBg80odlI/aHQQxXtcN/+Ti8gSo3sfhcPb5Pn8afJ+y
         EH4VUMDaywJFmW7ZuXHBHV1OLHka8eqhc1fVRaaF6G9wPs3CkN692kYBqSatBuxb7yvU
         bNqNgTb8HH4PWxWfIdfXOM60nWcb/s9OjotAPj6FoRi/fjOGQCPAEzohDa+uGQNM4g3Q
         nyebGrxqghyxdFB6HdI/My2k9N+TI7MjyrZVQ5/PQT3JRMUmVxHMcPSVitifbVjtRB5E
         4H1iOL1+JmkilWwnjQ7DPNEdmxj8ISdaI3EBwJ6WY2Cfba2n8XksYXgt6IexqGRsY5wa
         XKGQ==
X-Gm-Message-State: AOJu0Yy7zDSXEKg6b7LqYloXbFZhX20R3LyvotnbxVu1XeQQ73wICN6x
	Ac+NeHfZUbxZG9ULZmYc42iCR+qQ0gzkON20soJYfjtCZi5yTw81I/Ykgtsyc0Z/vFMrPj6sNQp
	kUrhE27ODSlKlVmeLnFGmEfDhBbagCw==
X-Gm-Gg: ASbGncvfTCmOCqizcb2X9iUutl+zaeoMnckedIIYCiFM3lnHSOS1nqwXTU+voR2ggBL
	CzpGRMi+zR1K7J4XixLcpKgqoYgi24PWJ9EwPqqIoPw+sL0kV1JM=
X-Google-Smtp-Source: AGHT+IFQjzVSkYSVH8+X3Y4BFbjntfpCtL8Dk/r2eT0hXjgspXoD0vpO7vgJXQKapNO2Ykkx0m4WglJTCj8+bFAPSD0=
X-Received: by 2002:a05:6512:3405:b0:542:232c:d3eb with SMTP id
 2adb3069b0e04-5439c241275mr3632485e87.19.1737335509271; Sun, 19 Jan 2025
 17:11:49 -0800 (PST)
MIME-Version: 1.0
References: <20250119130359.4149-1-schonm@gmail.com>
In-Reply-To: <20250119130359.4149-1-schonm@gmail.com>
From: Tim Orling <ticotimo@gmail.com>
Date: Sun, 19 Jan 2025 17:11:36 -0800
X-Gm-Features: AbW1kvYvH1kB7SbTKFKMF9ITLMwkC4J1IyGkGd3oi_m5VKUXJNz-qQOPgicRxK4
Message-ID: <CANx9H-CazLispmrvvum8iKR=BdCCnLa8Hq9j6DB04OkuyE+oMQ@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-java][PATCH] Drop the use of
 SRC_URI[md5sum] where SRC_URI[sha256sum] is already in use.
To: yocto-patches@lists.yoctoproject.org
Cc: Jason Schonberg <schonm@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000e2cc25062c18f1c7"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Jan 2025 01:11:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/985

--000000000000e2cc25062c18f1c7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied to master and scarthgap.
Thank you for the contribution and responding to my request to resend.

On Sun, Jan 19, 2025 at 5:04=E2=80=AFAM J. S. via lists.yoctoproject.org <s=
chonm=3D
gmail.com@lists.yoctoproject.org> wrote:

> Signed-off-by: Jason Schonberg <schonm@gmail.com>
> ---
>  recipes-core/ant-contrib/ant-contrib-native_1.0b3.bb       | 1 -
>  recipes-core/ant/ant-native_1.8.1.bb                       | 1 -
>  recipes-core/antlr/antlr_2.7.7.bb                          | 1 -
>  recipes-core/bcel/bcel_5.2.bb                              | 1 -
>  recipes-core/cacao/cacao-initial-native_0.98.bb            | 1 -
>  recipes-core/classpath/classpath-initial-native_0.93.bb    | 1 -
>  recipes-core/classpath/classpath-native_0.99.bb            | 1 -
>  recipes-core/classpath/classpath_0.99.bb                   | 1 -
>  recipes-core/classpathx/gnujaf_1.1.1.bb                    | 1 -
>  recipes-core/classpathx/gnumail_1.1.2.bb                   | 1 -
>  recipes-core/classpathx/inetlib_1.1.1.bb                   | 1 -
>  recipes-core/cup/cup_0.10k.bb                              | 1 -
>  recipes-core/ecj/libecj-bootstrap-native_3.6.2.bb          | 1 -
>  recipes-core/fastjar/fastjar_0.98.bb                       | 1 -
>  recipes-core/jacl/jacl_1.4.1.bb                            | 1 -
>  recipes-core/jakarta-commons/commons-beanutils_1.8.0.bb    | 1 -
>  recipes-core/jakarta-commons/commons-cli_1.1.bb            | 1 -
>  recipes-core/jakarta-commons/commons-codec_1.3.bb          | 1 -
>  recipes-core/jakarta-commons/commons-collections3_3.2.2.bb | 1 -
>  recipes-core/jakarta-commons/commons-collections_2.1.1.bb  | 1 -
>  recipes-core/jakarta-commons/commons-digester_1.8.bb       | 1 -
>  recipes-core/jakarta-commons/commons-discovery_0.4.bb      | 1 -
>  recipes-core/jakarta-commons/commons-el_1.0.bb             | 1 -
>  recipes-core/jakarta-commons/commons-fileupload_1.2.1.bb   | 1 -
>  recipes-core/jakarta-commons/commons-httpclient_3.1.bb     | 1 -
>  recipes-core/jakarta-commons/commons-io_1.4.bb             | 1 -
>  recipes-core/jakarta-commons/commons-lang_2.4.bb           | 1 -
>  recipes-core/jakarta-commons/commons-logging_1.1.1.bb      | 1 -
>  recipes-core/jakarta-commons/commons-net_1.4.1.bb          | 1 -
>  recipes-core/jakarta-commons/commons-pool_1.4.bb           | 1 -
>  recipes-core/jakarta-libs/bsf_2.4.0.bb                     | 1 -
>  recipes-core/jakarta-libs/log4j1.2_1.2.17.bb               | 1 -
>  recipes-core/jakarta-libs/logkit_1.2.2.bb                  | 1 -
>  recipes-core/jakarta-libs/oro_2.0.8.bb                     | 1 -
>  recipes-core/jakarta-libs/poi_3.0.bb                       | 1 -
>  recipes-core/jakarta-libs/regexp_1.5.bb                    | 1 -
>  recipes-core/jamvm/jamvm-initial-native_1.4.5.bb           | 1 -
>  recipes-core/javasqlite/javasqlite_20150419.bb             | 1 -
>  recipes-core/jcraft/jsch_0.1.40.bb                         | 1 -
>  recipes-core/jcraft/jzlib_1.0.7.bb                         | 1 -
>  recipes-core/jikes/jikes_1.22.bb                           | 1 -
>  recipes-core/jlex/jlex_1.2.6.bb                            | 1 -
>  recipes-core/junit/junit4_4.3.1.bb                         | 1 -
>  recipes-core/junit/junit_3.8.2.bb                          | 1 -
>  recipes-core/libmatthew/libmatthew_0.8.bb                  | 1 -
>  recipes-core/servlet-api/jsp2.0_5.5.26.bb                  | 1 -
>  recipes-core/servlet-api/servlet2.3_4.1.37.bb              | 1 -
>  recipes-core/servlet-api/servlet2.4_5.5.26.bb              | 1 -
>  recipes-core/xerces-j/xerces-j_2.11.0.bb                   | 1 -
>  recipes-core/xml-commons/jaxp1.3_1.4.01.bb                 | 1 -
>  recipes-core/xml-commons/jdom_1.1.3.bb                     | 1 -
>  recipes-core/xml-commons/xml-commons-resolver1.1_1.2.bb    | 1 -
>  recipes-core/xml-commons/xpp2_2.1.10.bb                    | 1 -
>  recipes-core/xml-commons/xpp3_1.1.3.4.O.bb                 | 1 -
>  recipes-extended/dbus/dbus-java_2.7.bb                     | 1 -
>  recipes-extended/hsqldb/hsqldb_1.8.0.10.bb                 | 1 -
>  recipes-extended/rxtx/rxtx_2.2.0.bb                        | 1 -
>  recipes-extended/xmlpull/xmlpull_1.1.3.4c.bb               | 1 -
>  58 files changed, 58 deletions(-)
>
> diff --git a/recipes-core/ant-contrib/ant-contrib-native_1.0b3.bb
> b/recipes-core/ant-contrib/ant-contrib-native_1.0b3.bb
> index db79626..e92f28a 100644
> --- a/recipes-core/ant-contrib/ant-contrib-native_1.0b3.bb
> +++ b/recipes-core/ant-contrib/ant-contrib-native_1.0b3.bb
> @@ -16,7 +16,6 @@ inherit java-library native
>
>  SRC_URI =3D "${SOURCEFORGE_MIRROR}/ant-contrib/ant-contrib-${PV}-src.zip=
"
>
> -SRC_URI[md5sum] =3D "07b23539bef04ec56970c876a33f7665"
>  SRC_URI[sha256sum] =3D
> "ba3621f397af14d5a19375f391ec9bf2908c46c5558ca0df8365e04fe3ac3633"
>
>  S =3D "${WORKDIR}/ant-contrib"
> diff --git a/recipes-core/ant/ant-native_1.8.1.bb b/recipes-core/ant/
> ant-native_1.8.1.bb
> index 8814039..b81f71d 100644
> --- a/recipes-core/ant/ant-native_1.8.1.bb
> +++ b/recipes-core/ant/ant-native_1.8.1.bb
> @@ -62,6 +62,5 @@ do_install:append() {
>         install -m 0755 ${WORKDIR}/ant ${D}${bindir}
>  }
>
> -SRC_URI[md5sum] =3D "9e5960bd586d9425c46199cdd20a6fbc"
>  SRC_URI[sha256sum] =3D
> "4f39057af228663c3cfb6dcfbee603a071a7e3cf48c95c30869ed81c5fcf21c8"
>
> diff --git a/recipes-core/antlr/antlr_2.7.7.bb b/recipes-core/antlr/
> antlr_2.7.7.bb
> index d744201..31769c9 100644
> --- a/recipes-core/antlr/antlr_2.7.7.bb
> +++ b/recipes-core/antlr/antlr_2.7.7.bb
> @@ -26,7 +26,6 @@ do_install:class-native() {
>      install -m 0755 ${WORKDIR}/runantlr ${D}${bindir}/
>  }
>
> -SRC_URI[md5sum] =3D "01cc9a2a454dd33dcd8c856ec89af090"
>  SRC_URI[sha256sum] =3D
> "853aeb021aef7586bda29e74a6b03006bcb565a755c86b66032d8ec31b67dbb9"
>
>  BBCLASSEXTEND =3D "native"
> diff --git a/recipes-core/bcel/bcel_5.2.bb b/recipes-core/bcel/bcel_5.2.b=
b
> index 1fa6d59..7a8f46f 100644
> --- a/recipes-core/bcel/bcel_5.2.bb
> +++ b/recipes-core/bcel/bcel_5.2.bb
> @@ -19,7 +19,6 @@ do_compile() {
>    fastjar cf ${JARFILENAME} -C build .
>  }
>
> -SRC_URI[md5sum] =3D "905b7e718e30e7ca726530ecf106e532"
>  SRC_URI[sha256sum] =3D
> "68039d59a38379d7b65ea3fc72276c43ba234776460e14361af35771bcaab295"
>
>  BBCLASSEXTEND =3D "native"
> diff --git a/recipes-core/cacao/cacao-initial-native_0.98.bb
> b/recipes-core/cacao/cacao-initial-native_0.98.bb
> index 8432456..60c4d4f 100644
> --- a/recipes-core/cacao/cacao-initial-native_0.98.bb
> +++ b/recipes-core/cacao/cacao-initial-native_0.98.bb
> @@ -40,5 +40,4 @@ do_configure:append() {
>    sed -i -e "s|exec cacao \\$|exec cacao-initial \\$|" src/scripts/
> java.in
>  }
>
> -SRC_URI[md5sum] =3D "8b8907c8b925761c9410bcadb9705346"
>  SRC_URI[sha256sum] =3D
> "cb9363add825cedf77764fc49a223aaf43f0a9f485b711ba8c92f16b13fff188"
> diff --git a/recipes-core/classpath/classpath-initial-native_0.93.bb
> b/recipes-core/classpath/classpath-initial-native_0.93.bb
> index 7bb1ca1..6963ef7 100644
> --- a/recipes-core/classpath/classpath-initial-native_0.93.bb
> +++ b/recipes-core/classpath/classpath-initial-native_0.93.bb
> @@ -12,7 +12,6 @@ SRC_URI +=3D " \
>             file://autotools.patch \
>             file://miscompilation.patch \
>            "
> -SRC_URI[md5sum] =3D "ffa9e9cac31c5acbf0ea9eff9efa923d"
>  SRC_URI[sha256sum] =3D
> "df2d093612abd23fe67e9409d89bb2a8e79b1664fe2b2da40e1c8ed693e32945"
>
>  EXTRA_OECONF +=3D "\
> diff --git a/recipes-core/classpath/classpath-native_0.99.bb
> b/recipes-core/classpath/classpath-native_0.99.bb
> index ecf8c0a..6f37357 100644
> --- a/recipes-core/classpath/classpath-native_0.99.bb
> +++ b/recipes-core/classpath/classpath-native_0.99.bb
> @@ -13,7 +13,6 @@ SRC_URI +=3D " \
>
> file://0001-Fix-bad-implementation-of-compareTo-in-BigDecimal.patch \
>
> file://0002-Fix-BigDecimal.stripTrailingZeros-s-handling-of-0.patch \
>             "
> -SRC_URI[md5sum] =3D "0ae1571249172acd82488724a3b8acb4"
>  SRC_URI[sha256sum] =3D
> "f929297f8ae9b613a1a167e231566861893260651d913ad9b6c11933895fecc8"
>
>  EXTRA_OECONF +=3D "\
> diff --git a/recipes-core/classpath/classpath_0.99.bb
> b/recipes-core/classpath/classpath_0.99.bb
> index f18ad1d..0f805b8 100644
> --- a/recipes-core/classpath/classpath_0.99.bb
> +++ b/recipes-core/classpath/classpath_0.99.bb
> @@ -15,5 +15,4 @@ SRC_URI +=3D " \
>              file://aarch64.patch \
>             "
>
> -SRC_URI[md5sum] =3D "0ae1571249172acd82488724a3b8acb4"
>  SRC_URI[sha256sum] =3D
> "f929297f8ae9b613a1a167e231566861893260651d913ad9b6c11933895fecc8"
> diff --git a/recipes-core/classpathx/gnujaf_1.1.1.bb
> b/recipes-core/classpathx/gnujaf_1.1.1.bb
> index 0bd8b57..0eacd01 100644
> --- a/recipes-core/classpathx/gnujaf_1.1.1.bb
> +++ b/recipes-core/classpathx/gnujaf_1.1.1.bb
> @@ -30,7 +30,6 @@ do_compile() {
>    fastjar cf ${JARFILENAME} -C build .
>  }
>
> -SRC_URI[md5sum] =3D "de50d7728e8140eb404f2b4554321f8c"
>  SRC_URI[sha256sum] =3D
> "b1b5ef560d30fcb11fbf537246857d14110ce4eb2b200d4c54690472305d87b7"
>
>  BBCLASSEXTEND =3D "native"
> diff --git a/recipes-core/classpathx/gnumail_1.1.2.bb
> b/recipes-core/classpathx/gnumail_1.1.2.bb
> index 22d0405..86a02b4 100644
> --- a/recipes-core/classpathx/gnumail_1.1.2.bb
> +++ b/recipes-core/classpathx/gnumail_1.1.2.bb
> @@ -33,7 +33,6 @@ do_compile() {
>      providers_jar=3D${P}-providers.jar
>  }
>
> -SRC_URI[md5sum] =3D "0a94ff4328ceb6a4131be96946976a33"
>  SRC_URI[sha256sum] =3D
> "5eb09597a8f81bfc943206e3e0f45b963ba605a646051c353374f1b475bb9f04"
>
>  BBCLASSEXTEND =3D "native"
> diff --git a/recipes-core/classpathx/inetlib_1.1.1.bb
> b/recipes-core/classpathx/inetlib_1.1.1.bb
> index 9146c9e..121559f 100644
> --- a/recipes-core/classpathx/inetlib_1.1.1.bb
> +++ b/recipes-core/classpathx/inetlib_1.1.1.bb
> @@ -13,7 +13,6 @@ SRC_URI =3D "http://ftp.gnu.org/gnu/classpath/${BP}.tar=
.gz
> \
>             file://datadir_java.patch \
>             file://inetlib-missing-dependency-for-util_classes.patch \
>            "
> -SRC_URI[md5sum] =3D "aaa24be4bc8d172ac675be8bdfa636ee"
>  SRC_URI[sha256sum] =3D
> "1b078a39e022f86e4e2c8189b4d2789a5da414e8f1cb285587b7800b950a44de"
>
>  DEPENDS =3D "classpath-initial-native \
> diff --git a/recipes-core/cup/cup_0.10k.bb b/recipes-core/cup/cup_0.10k.b=
b
> index ce81453..fcd4ad2 100644
> --- a/recipes-core/cup/cup_0.10k.bb
> +++ b/recipes-core/cup/cup_0.10k.bb
> @@ -41,7 +41,6 @@ PACKAGES =3D "${PN}"
>
>  FILES:${PN} +=3D "${datadir_java}"
>
> -SRC_URI[md5sum] =3D "8b11edfec13c590ea443d0f0ae0da479"
>  SRC_URI[sha256sum] =3D
> "7e6dc5be74ae56c7e86e69ad0ad88dae3b2847afa9e73a76635918a6b1eb75cd"
>
>  BBCLASSEXTEND =3D "native"
> diff --git a/recipes-core/ecj/libecj-bootstrap-native_3.6.2.bb
> b/recipes-core/ecj/libecj-bootstrap-native_3.6.2.bb
> index 51dbca0..b9325f8 100644
> --- a/recipes-core/ecj/libecj-bootstrap-native_3.6.2.bb
> +++ b/recipes-core/ecj/libecj-bootstrap-native_3.6.2.bb
> @@ -4,6 +4,5 @@ PR =3D "${INC_PR}.0"
>
>  SRC_URI =3D "
> http://archive.eclipse.org/eclipse/downloads/drops/R-3.6.2-201102101200/e=
cjsrc-${PV}.zip
> "
>
> -SRC_URI[md5sum] =3D "3f3ca1973dd7a21780525c9ffba7a263"
>  SRC_URI[sha256sum] =3D
> "94f2095d38d71b414a593ec56847008bec267a926ec935959fecdde44f98467f"
>
> diff --git a/recipes-core/fastjar/fastjar_0.98.bb b/recipes-core/fastjar/
> fastjar_0.98.bb
> index 5b5a403..b4491f7 100644
> --- a/recipes-core/fastjar/fastjar_0.98.bb
> +++ b/recipes-core/fastjar/fastjar_0.98.bb
> @@ -4,6 +4,5 @@ LIC_FILES_CHKSUM =3D
> "file://COPYING;md5=3D59530bdf33659b29e73d4adb9f9f6552"
>
>  SRC_URI +=3D "file://jartool.patch"
>
> -SRC_URI[md5sum] =3D "d2d264d343d4d0e1575832cc1023c3bf"
>  SRC_URI[sha256sum] =3D
> "f156abc5de8658f22ee8f08d7a72c88f9409ebd8c7933e9466b0842afeb2f145"
>
> diff --git a/recipes-core/jacl/jacl_1.4.1.bb b/recipes-core/jacl/
> jacl_1.4.1.bb
> index d510cc8..b15991e 100644
> --- a/recipes-core/jacl/jacl_1.4.1.bb
> +++ b/recipes-core/jacl/jacl_1.4.1.bb
> @@ -23,7 +23,6 @@ do_compile() {
>    fastjar cf ${JARFILENAME} -C build .
>  }
>
> -SRC_URI[md5sum] =3D "a7ec8300e8933164e854460c73ac6269"
>  SRC_URI[sha256sum] =3D
> "0edac0a7d2253c29c44ccc92427fa9ad4ee81b6c82142e417f72399a8584b749"
>
>  BBCLASSEXTEND =3D "native"
> diff --git a/recipes-core/jakarta-commons/commons-beanutils_1.8.0.bb
> b/recipes-core/jakarta-commons/commons-beanutils_1.8.0.bb
> index 2c5ecc2..4521ed8 100644
> --- a/recipes-core/jakarta-commons/commons-beanutils_1.8.0.bb
> +++ b/recipes-core/jakarta-commons/commons-beanutils_1.8.0.bb
> @@ -11,5 +11,4 @@ RDEPENDS:${PN} =3D "libcommons-collections3-java
> libcommons-logging-java"
>
>  CP =3D "commons-collections3 commons-logging"
>
> -SRC_URI[md5sum] =3D "1bce3cfa4ae33c94686422e78abc0792"
>  SRC_URI[sha256sum] =3D
> "aff3c8c772e4ff32f2d9a37a727a488583372e45535a3d5aad09662691851dcf"
> diff --git a/recipes-core/jakarta-commons/commons-cli_1.1.bb
> b/recipes-core/jakarta-commons/commons-cli_1.1.bb
> index a87097b..2b83a03 100644
> --- a/recipes-core/jakarta-commons/commons-cli_1.1.bb
> +++ b/recipes-core/jakarta-commons/commons-cli_1.1.bb
> @@ -7,7 +7,6 @@ SUMMARY =3D "Java argument parsing helper classes"
>
>  SRC_URI =3D "
> http://archive.apache.org/dist/commons/cli/source/${BP}-src.tar.gz"
>
> -SRC_URI[md5sum] =3D "ccc1aa194132e2387557bbb7f65391f4"
>  SRC_URI[sha256sum] =3D
> "929eb140c136673e7f5029cd206c81b3c1f5e66bba0dfdcd021b9dd5596356d2"
>
>  BBCLASSEXTEND =3D "native"
> diff --git a/recipes-core/jakarta-commons/commons-codec_1.3.bb
> b/recipes-core/jakarta-commons/commons-codec_1.3.bb
> index fa74f6c..cfaada5 100644
> --- a/recipes-core/jakarta-commons/commons-codec_1.3.bb
> +++ b/recipes-core/jakarta-commons/commons-codec_1.3.bb
> @@ -9,7 +9,6 @@ SRC_URI =3D "
> http://archive.apache.org/dist/commons/codec/source/${BP}-src.tar.gz"
>
>  S =3D "${WORKDIR}/${BP}"
>
> -SRC_URI[md5sum] =3D "af3c3acf618de6108d65fcdc92b492e1"
>  SRC_URI[sha256sum] =3D
> "12effcf3fea025bd34edbfec60a6216ca453fb27e781d8e5783caf75fd33d90e"
>
>  BBCLASSEXTEND =3D "native"
> diff --git a/recipes-core/jakarta-commons/commons-collections3_3.2.2.bb
> b/recipes-core/jakarta-commons/commons-collections3_3.2.2.bb
> index 0a53d09..2f23490 100644
> --- a/recipes-core/jakarta-commons/commons-collections3_3.2.2.bb
> +++ b/recipes-core/jakarta-commons/commons-collections3_3.2.2.bb
> @@ -10,5 +10,4 @@ SRC_URI =3D "
> http://www.apache.org/dist/commons/collections/source/commons-collect
>  S =3D "${WORKDIR}/commons-collections-${PV}-src"
>
>
> -SRC_URI[md5sum] =3D "776b51a51312c1854ad8f6d344a47cda"
>  SRC_URI[sha256sum] =3D
> "070d94fe77969d8949bd129a618e6a7bee6b83b5b5db3ef3f983395a5428b914"
> diff --git a/recipes-core/jakarta-commons/commons-collections_2.1.1.bb
> b/recipes-core/jakarta-commons/commons-collections_2.1.1.bb
> index 4d100a7..898a7df 100644
> --- a/recipes-core/jakarta-commons/commons-collections_2.1.1.bb
> +++ b/recipes-core/jakarta-commons/commons-collections_2.1.1.bb
> @@ -7,5 +7,4 @@ DESCRIPTION =3D "A set of abstract data type interfaces a=
nd
> implementations that o
>  SRC_URI =3D "
> http://archive.apache.org/dist/commons/collections/source/${BP}-src.tar.g=
z
> "
>
>
> -SRC_URI[md5sum] =3D "3fc2e8f9d0647074cba992b534ecf6df"
>  SRC_URI[sha256sum] =3D
> "73eb5907a31c8770480c70f6a6a8d9a9a2ffe602e1b461c045cff51ace4cab2a"
> diff --git a/recipes-core/jakarta-commons/commons-digester_1.8.bb
> b/recipes-core/jakarta-commons/commons-digester_1.8.bb
> index de264b8..7e595ee 100644
> --- a/recipes-core/jakarta-commons/commons-digester_1.8.bb
> +++ b/recipes-core/jakarta-commons/commons-digester_1.8.bb
> @@ -13,5 +13,4 @@ CP =3D "commons-logging commons-beanutils"
>
>  FINDARGS =3D "-name '*.dtd'"
>
> -SRC_URI[md5sum] =3D "689f41905a68c67f7231f9afbb3e2147"
>  SRC_URI[sha256sum] =3D
> "d9a965c82828a881d2ab6256fba7076f62815a9545b3af9d553dc5271577182b"
> diff --git a/recipes-core/jakarta-commons/commons-discovery_0.4.bb
> b/recipes-core/jakarta-commons/commons-discovery_0.4.bb
> index aa87349..60cf683 100644
> --- a/recipes-core/jakarta-commons/commons-discovery_0.4.bb
> +++ b/recipes-core/jakarta-commons/commons-discovery_0.4.bb
> @@ -12,5 +12,4 @@ RDEPENDS:${PN} =3D "libcommons-logging-java"
>
>  CP =3D "commons-logging"
>
> -SRC_URI[md5sum] =3D "1275ad4c6ce54b9323269e30dc42dd0e"
>  SRC_URI[sha256sum] =3D
> "596242302be4f0502073f5a934c608289bba6221591e7dbea53ce629f67498a3"
> diff --git a/recipes-core/jakarta-commons/commons-el_1.0.bb
> b/recipes-core/jakarta-commons/commons-el_1.0.bb
> index bb4c35b..b93b68f 100644
> --- a/recipes-core/jakarta-commons/commons-el_1.0.bb
> +++ b/recipes-core/jakarta-commons/commons-el_1.0.bb
> @@ -16,5 +16,4 @@ FINDARGS =3D "\( -name '*.properties' -or -name '*.jj' =
\)"
>
>
>
> -SRC_URI[md5sum] =3D "25038283a0b5f638db5e891295d20020"
>  SRC_URI[sha256sum] =3D
> "3c9bdded6073563aaaddc9ad7c7387b242dc03cc385381503026b665a366c2c6"
> diff --git a/recipes-core/jakarta-commons/commons-fileupload_1.2.1.bb
> b/recipes-core/jakarta-commons/commons-fileupload_1.2.1.bb
> index 395fa15..71a866b 100644
> --- a/recipes-core/jakarta-commons/commons-fileupload_1.2.1.bb
> +++ b/recipes-core/jakarta-commons/commons-fileupload_1.2.1.bb
> @@ -16,5 +16,4 @@ CP =3D "commons-beanutils commons-io servlet-2.3"
>  COMPILE_FINDARGS =3D "-name '*.java' -not -wholename '*portlet*'"
>
>
> -SRC_URI[md5sum] =3D "c2bdb9264aec564e3f4fbbdf4344a844"
>  SRC_URI[sha256sum] =3D
> "08905cb3a0db4f7fa67f3b579b2c481060334d50d7f913c6974c7513243152f5"
> diff --git a/recipes-core/jakarta-commons/commons-httpclient_3.1.bb
> b/recipes-core/jakarta-commons/commons-httpclient_3.1.bb
> index a6fb53b..b4e5e2a 100644
> --- a/recipes-core/jakarta-commons/commons-httpclient_3.1.bb
> +++ b/recipes-core/jakarta-commons/commons-httpclient_3.1.bb
> @@ -15,7 +15,6 @@ RDEPENDS:${PN}:class-native =3D ""
>
>  CP =3D "commons-logging commons-codec"
>
> -SRC_URI[md5sum] =3D "2c9b0f83ed5890af02c0df1c1776f39b"
>  SRC_URI[sha256sum] =3D
> "f9a496d3418b0e15894fb351652cd4fa5ca434ebfc3ce3bb8da40defd8b097f2"
>
>  BBCLASSEXTEND =3D "native"
> diff --git a/recipes-core/jakarta-commons/commons-io_1.4.bb
> b/recipes-core/jakarta-commons/commons-io_1.4.bb
> index f1dbc88..799a9d4 100644
> --- a/recipes-core/jakarta-commons/commons-io_1.4.bb
> +++ b/recipes-core/jakarta-commons/commons-io_1.4.bb
> @@ -7,5 +7,4 @@ DESCRIPTION =3D "Java library with utility classes, strea=
m
> implementations, file f
>
>  SRC_URI =3D "
> http://archive.apache.org/dist/commons/io/source/${BP}-src.tar.gz"
>
> -SRC_URI[md5sum] =3D "24b228f2d0c40ffed9204cdab015bccf"
>  SRC_URI[sha256sum] =3D
> "eca986497f7b4d1b1ec41821b1b5df827bb31fc14833e4449cfa8bcd5d7f29bb"
> diff --git a/recipes-core/jakarta-commons/commons-lang_2.4.bb
> b/recipes-core/jakarta-commons/commons-lang_2.4.bb
> index 48cc291..e0c3736 100644
> --- a/recipes-core/jakarta-commons/commons-lang_2.4.bb
> +++ b/recipes-core/jakarta-commons/commons-lang_2.4.bb
> @@ -8,5 +8,4 @@ DESCRIPTION =3D "Set of Java classes that provide helper
> methods for the standard
>  SRC_URI =3D "
> http://archive.apache.org/dist/commons/lang/source/${BP}-src.tar.gz"
>
>
> -SRC_URI[md5sum] =3D "625ff5f2f968dd908bca43c9469d6e6b"
>  SRC_URI[sha256sum] =3D
> "2445238cd0eb167e99a1147394f61325490559f3df7e7e8f628043fb70cbf2f4"
> diff --git a/recipes-core/jakarta-commons/commons-logging_1.1.1.bb
> b/recipes-core/jakarta-commons/commons-logging_1.1.1.bb
> index 7aa2372..6de3228 100644
> --- a/recipes-core/jakarta-commons/commons-logging_1.1.1.bb
> +++ b/recipes-core/jakarta-commons/commons-logging_1.1.1.bb
> @@ -12,7 +12,6 @@ CP =3D "log4j-1.2 servlet-2.3 logkit"
>
>  COMPILE_FINDARGS =3D "-name '*.java' -and -not -name '*Avalon*'"
>
> -SRC_URI[md5sum] =3D "e5cfa8cca13152d7545fde6b1783c60a"
>  SRC_URI[sha256sum] =3D
> "b49a79fa78ebfae15dc46ae6f0144fee6b94ab608a25518c54609d3419909eb2"
>
>  BBCLASSEXTEND =3D "native"
> diff --git a/recipes-core/jakarta-commons/commons-net_1.4.1.bb
> b/recipes-core/jakarta-commons/commons-net_1.4.1.bb
> index ba62ebc..bffbbae 100644
> --- a/recipes-core/jakarta-commons/commons-net_1.4.1.bb
> +++ b/recipes-core/jakarta-commons/commons-net_1.4.1.bb
> @@ -18,7 +18,6 @@ CP =3D "oro"
>
>  MAINSOURCES =3D "src/java/org"
>
> -SRC_URI[md5sum] =3D "ccbb3f67b55e8a7a676499db4386673c"
>  SRC_URI[sha256sum] =3D
> "fdea779f261f70b9bbec40121c830b11e3e63b6188f662f95505045ff8d44add"
>
>  BBCLASSEXTEND =3D "native"
> diff --git a/recipes-core/jakarta-commons/commons-pool_1.4.bb
> b/recipes-core/jakarta-commons/commons-pool_1.4.bb
> index 95c8cf1..824b772 100644
> --- a/recipes-core/jakarta-commons/commons-pool_1.4.bb
> +++ b/recipes-core/jakarta-commons/commons-pool_1.4.bb
> @@ -7,5 +7,4 @@ SUMMARY =3D "Java Object-pooling API"
>
>  SRC_URI =3D "
> http://archive.apache.org/dist/commons/pool/source/${BP}-src.tar.gz"
>
> -SRC_URI[md5sum] =3D "4dc988ee16e1471799af97763297b41b"
>  SRC_URI[sha256sum] =3D
> "ca4452f2a2ce2daf6eaa1743ded2d3b36013200c48e3f2117b65584ca5cc1d9b"
> diff --git a/recipes-core/jakarta-libs/bsf_2.4.0.bb
> b/recipes-core/jakarta-libs/bsf_2.4.0.bb
> index 22d9320..a38c335 100644
> --- a/recipes-core/jakarta-libs/bsf_2.4.0.bb
> +++ b/recipes-core/jakarta-libs/bsf_2.4.0.bb
> @@ -27,7 +27,6 @@ do_compile() {
>  }
>
>
> -SRC_URI[md5sum] =3D "7e58b2a009c0f70ab36bbef420b25c07"
>  SRC_URI[sha256sum] =3D
> "5ab58cf5738c144f4d85a4a442c2f33be2c4c502dca6e29e0c570c2a51ae6ae9"
>
>  BBCLASSEXTEND =3D "native"
> diff --git a/recipes-core/jakarta-libs/log4j1.2_1.2.17.bb
> b/recipes-core/jakarta-libs/log4j1.2_1.2.17.bb
> index 2f04e96..bd8c9d8 100644
> --- a/recipes-core/jakarta-libs/log4j1.2_1.2.17.bb
> +++ b/recipes-core/jakarta-libs/log4j1.2_1.2.17.bb
> @@ -29,7 +29,6 @@ do_compile() {
>    fastjar cf ${JARFILENAME} -C build .
>  }
>
> -SRC_URI[md5sum] =3D "8218714e41ee0c6509dcfeafa2e1f53f"
>  SRC_URI[sha256sum] =3D
> "a528e3771ee6234661b5eb0fa02e14faee89dfec38de94088c163ddf2a0a8663"
>
>  BBCLASSEXTEND =3D "native"
> diff --git a/recipes-core/jakarta-libs/logkit_1.2.2.bb
> b/recipes-core/jakarta-libs/logkit_1.2.2.bb
> index 8b4de11..c3d83a5 100644
> --- a/recipes-core/jakarta-libs/logkit_1.2.2.bb
> +++ b/recipes-core/jakarta-libs/logkit_1.2.2.bb
> @@ -26,7 +26,6 @@ do_compile() {
>    fastjar cf ${JARFILENAME} -C build .
>  }
>
> -SRC_URI[md5sum] =3D "996ee20d6b5785ab71f4692f64d10f9c"
>  SRC_URI[sha256sum] =3D
> "2c81edc87571fbd05797da7f65515e089c62cbb735bdbd10f93e29bd3aa3ddb8"
>
>  BBCLASSEXTEND =3D "native"
> diff --git a/recipes-core/jakarta-libs/oro_2.0.8.bb
> b/recipes-core/jakarta-libs/oro_2.0.8.bb
> index 97e29d0..80efd49 100644
> --- a/recipes-core/jakarta-libs/oro_2.0.8.bb
> +++ b/recipes-core/jakarta-libs/oro_2.0.8.bb
> @@ -18,7 +18,6 @@ do_compile() {
>    fastjar cf ${JARFILENAME} -C build org
>  }
>
> -SRC_URI[md5sum] =3D "6f7690c6ba9750e3cbb8ebd10078a79a"
>  SRC_URI[sha256sum] =3D
> "4c4f3c7c479994c3ce09f542d4fbdc03eed58a2d7f320d32f2baf238b5b6f566"
>
>  BBCLASSEXTEND =3D "native"
> diff --git a/recipes-core/jakarta-libs/poi_3.0.bb
> b/recipes-core/jakarta-libs/poi_3.0.bb
> index e33f2f2..3733c3c 100644
> --- a/recipes-core/jakarta-libs/poi_3.0.bb
> +++ b/recipes-core/jakarta-libs/poi_3.0.bb
> @@ -26,5 +26,4 @@ do_compile() {
>    fastjar -C build -c -f ${JARFILENAME} .
>  }
>
> -SRC_URI[md5sum] =3D "1fb488c4061256197a667f1c480ffc33"
>  SRC_URI[sha256sum] =3D
> "48a5aabb873d4cc654c95acf6576868d7a8a3ee97e1c6418e1d716698b6efa76"
> diff --git a/recipes-core/jakarta-libs/regexp_1.5.bb
> b/recipes-core/jakarta-libs/regexp_1.5.bb
> index 614da2a..40dec0a 100644
> --- a/recipes-core/jakarta-libs/regexp_1.5.bb
> +++ b/recipes-core/jakarta-libs/regexp_1.5.bb
> @@ -18,7 +18,6 @@ do_compile() {
>    fastjar cf ${JARFILENAME} -C build .
>  }
>
> -SRC_URI[md5sum] =3D "b941b8f4de297827f3211c2cb34af199"
>  SRC_URI[sha256sum] =3D
> "79e80af8cbeb68ddad75a1aa6244d7acd62176bfd69bcdc0640d11177dcde97d"
>
>  BBCLASSEXTEND =3D "native"
> diff --git a/recipes-core/jamvm/jamvm-initial-native_1.4.5.bb
> b/recipes-core/jamvm/jamvm-initial-native_1.4.5.bb
> index 7773409..6a34f31 100644
> --- a/recipes-core/jamvm/jamvm-initial-native_1.4.5.bb
> +++ b/recipes-core/jamvm/jamvm-initial-native_1.4.5.bb
> @@ -43,7 +43,6 @@ do_install:append() {
>    install -m 0755 ${WORKDIR}/java-initial ${D}${bindir}/
>  }
>
> -SRC_URI[md5sum] =3D "3f538bab6e1c77aed331e5e71f754f5b"
>  SRC_URI[sha256sum] =3D
> "f329d1c8f42c06b53a3e82763d33900b100b8e9acd7afe02f7583c51253fd6e5"
>  # shared state for jamvm-native does not work
>  # since the paths are hardcoded
> diff --git a/recipes-core/javasqlite/javasqlite_20150419.bb
> b/recipes-core/javasqlite/javasqlite_20150419.bb
> index 45262e2..9a6518d 100644
> --- a/recipes-core/javasqlite/javasqlite_20150419.bb
> +++ b/recipes-core/javasqlite/javasqlite_20150419.bb
> @@ -23,7 +23,6 @@ FILES:${PN} +=3D"/usr/share"
>
>  PARALLEL_MAKE =3D "-j 1"
>
> -SRC_URI[md5sum] =3D "242e384c1cd863d6996a35cf8c1c1e97"
>  SRC_URI[sha256sum] =3D
> "b6b26e2c1a2174f5525d904eb3ff698c3f7089f0d4b4c84cf6121da08c8d801f"
>
>  EXTRA_OECONF =3D " \
> diff --git a/recipes-core/jcraft/jsch_0.1.40.bb b/recipes-core/jcraft/
> jsch_0.1.40.bb
> index aeb04b4..7fa8571 100644
> --- a/recipes-core/jcraft/jsch_0.1.40.bb
> +++ b/recipes-core/jcraft/jsch_0.1.40.bb
> @@ -22,7 +22,6 @@ do_compile() {
>    fastjar cf ${JARFILENAME} -C build .
>  }
>
> -SRC_URI[md5sum] =3D "b59cec19a487e95aed68378976b4b566"
>  SRC_URI[sha256sum] =3D
> "ca9d2ae08fd7a8983fb00d04f0f0c216a985218a5eb364ff9bee73870f28e097"
>
>  CVE_STATUS[CVE-2016-5725] =3D "not-applicable-platform: Issue only appli=
es
> on Windows"
> diff --git a/recipes-core/jcraft/jzlib_1.0.7.bb b/recipes-core/jcraft/
> jzlib_1.0.7.bb
> index 1e34d2c..65cced8 100644
> --- a/recipes-core/jcraft/jzlib_1.0.7.bb
> +++ b/recipes-core/jcraft/jzlib_1.0.7.bb
> @@ -16,7 +16,6 @@ do_compile() {
>    fastjar cf ${JARFILENAME} -C build .
>  }
>
> -SRC_URI[md5sum] =3D "3c52a0afb970e8a1fb2d34f30d330a83"
>  SRC_URI[sha256sum] =3D
> "20923a3f771a14c58c8cddfff2b589d568aff09f8a931919dc63ddaabb32407a"
>
>  BBCLASSEXTEND =3D "native"
> diff --git a/recipes-core/jikes/jikes_1.22.bb b/recipes-core/jikes/
> jikes_1.22.bb
> index 3e83ff8..b7fa7fa 100644
> --- a/recipes-core/jikes/jikes_1.22.bb
> +++ b/recipes-core/jikes/jikes_1.22.bb
> @@ -32,5 +32,4 @@ ALTERNATIVE:${PN} =3D "javac"
>  ALTERNATIVE_LINK =3D "/usr/bin/javac"
>  ALTERNATIVE_TARGET =3D "${bindir}/javac.jikes"
>
> -SRC_URI[md5sum] =3D "cda958c7fef6b43b803e1d1ef9afcb85"
>  SRC_URI[sha256sum] =3D
> "0cb02c763bc441349f6d38cacd52adf762302cce3a08e269f1f75f726e6e14e3"
> diff --git a/recipes-core/jlex/jlex_1.2.6.bb b/recipes-core/jlex/
> jlex_1.2.6.bb
> index 48ec357..5c8d9ee 100644
> --- a/recipes-core/jlex/jlex_1.2.6.bb
> +++ b/recipes-core/jlex/jlex_1.2.6.bb
> @@ -44,7 +44,6 @@ PACKAGES =3D "${PN}"
>
>  FILES:${PN} +=3D "${datadir_java}"
>
> -SRC_URI[md5sum] =3D "fe0cff5db3e2f0f5d67a153cf6c783af"
>  SRC_URI[sha256sum] =3D
> "aeebaece3b3a53972bb0ba0f810540386c267070ee9dca6ffa43c6ff74a54bd7"
>
>  BBCLASSEXTEND =3D "native"
> diff --git a/recipes-core/junit/junit4_4.3.1.bb b/recipes-core/junit/
> junit4_4.3.1.bb
> index b2cd4d9..89517cb 100644
> --- a/recipes-core/junit/junit4_4.3.1.bb
> +++ b/recipes-core/junit/junit4_4.3.1.bb
> @@ -23,7 +23,6 @@ do_compile() {
>    fastjar -C build -c -f ${JARFILENAME} .
>  }
>
> -SRC_URI[md5sum] =3D "170f9645a41398388e8553b32ff5f630"
>  SRC_URI[sha256sum] =3D
> "57d1e49ee3fd0dbdc0a68a852925c973af5c30b1725b6aa63bfb42df6f7c3349"
>
>  BBCLASSEXTEND =3D "native"
> diff --git a/recipes-core/junit/junit_3.8.2.bb b/recipes-core/junit/
> junit_3.8.2.bb
> index 57dd459..988101f 100644
> --- a/recipes-core/junit/junit_3.8.2.bb
> +++ b/recipes-core/junit/junit_3.8.2.bb
> @@ -36,7 +36,6 @@ do_compile() {
>    fastjar cf ${JARFILENAME} -C build .
>  }
>
> -SRC_URI[md5sum] =3D "9b8963ba2147a64bd5f1574b6fd289cb"
>  SRC_URI[sha256sum] =3D
> "aae23d20e6f4dc45b4bf0b10fedcbd209c100342a0cafce1aa07d2da6da1f24a"
>
>  BBCLASSEXTEND =3D "native"
> diff --git a/recipes-core/libmatthew/libmatthew_0.8.bb
> b/recipes-core/libmatthew/libmatthew_0.8.bb
> index c4ace08..1cf50c7 100644
> --- a/recipes-core/libmatthew/libmatthew_0.8.bb
> +++ b/recipes-core/libmatthew/libmatthew_0.8.bb
> @@ -7,6 +7,5 @@ LIC_FILES_CHKSUM =3D
> "file://COPYING;md5=3D48a42f2f9747f02bf40a0bce2655b509"
>  SRC_URI =3D "
> http://pkgs.fedoraproject.org/repo/pkgs/libmatthew-java/libmatthew-java-0=
.8.tar.gz/8455b8751083ce25c99c2840609271f5/libmatthew-java-${PV}.tar.gz
> \
>            "
>  #           file://Makefile-0.7.patch"
> -SRC_URI[md5sum] =3D "8455b8751083ce25c99c2840609271f5"
>  SRC_URI[sha256sum] =3D
> "05d1d3d9b5e33bd3642102aae10bba904e296c5c01a10854200ad4df349c8dfa"
>
> diff --git a/recipes-core/servlet-api/jsp2.0_5.5.26.bb
> b/recipes-core/servlet-api/jsp2.0_5.5.26.bb
> index ac8617c..3d9f4da 100644
> --- a/recipes-core/servlet-api/jsp2.0_5.5.26.bb
> +++ b/recipes-core/servlet-api/jsp2.0_5.5.26.bb
> @@ -43,5 +43,4 @@ do_compile() {
>    fastjar -C build -c -m src/etc/manifest -f ${JARFILENAME} .
>  }
>
> -SRC_URI[md5sum] =3D "642b6526354cb18c5b5d77ebef8109ae"
>  SRC_URI[sha256sum] =3D
> "ddc677d7391c438e6102d0b3e9653eaca661344ef74b0260c1f488340d660395"
> diff --git a/recipes-core/servlet-api/servlet2.3_4.1.37.bb
> b/recipes-core/servlet-api/servlet2.3_4.1.37.bb
> index 996f93b..dceece6 100644
> --- a/recipes-core/servlet-api/servlet2.3_4.1.37.bb
> +++ b/recipes-core/servlet-api/servlet2.3_4.1.37.bb
> @@ -43,7 +43,6 @@ do_compile() {
>    fastjar cfm ${JARFILENAME} src/etc/manifest -C build .
>  }
>
> -SRC_URI[md5sum] =3D "fe50177a25a084ad1abf4a201d08c2a6"
>  SRC_URI[sha256sum] =3D
> "65e4cc9d3ea4a7f30044bfd6c660c772adb75ac152d775342deb6049a0d19d74"
>
>  BBCLASSEXTEND =3D "native"
> diff --git a/recipes-core/servlet-api/servlet2.4_5.5.26.bb
> b/recipes-core/servlet-api/servlet2.4_5.5.26.bb
> index 7424673..eb2f769 100644
> --- a/recipes-core/servlet-api/servlet2.4_5.5.26.bb
> +++ b/recipes-core/servlet-api/servlet2.4_5.5.26.bb
> @@ -39,5 +39,4 @@ do_compile() {
>    fastjar -C build -c -m src/etc/manifest -f ${JARFILENAME} .
>  }
>
> -SRC_URI[md5sum] =3D "642b6526354cb18c5b5d77ebef8109ae"
>  SRC_URI[sha256sum] =3D
> "ddc677d7391c438e6102d0b3e9653eaca661344ef74b0260c1f488340d660395"
> diff --git a/recipes-core/xerces-j/xerces-j_2.11.0.bb
> b/recipes-core/xerces-j/xerces-j_2.11.0.bb
> index 45d3c43..56ffe97 100644
> --- a/recipes-core/xerces-j/xerces-j_2.11.0.bb
> +++ b/recipes-core/xerces-j/xerces-j_2.11.0.bb
> @@ -63,7 +63,6 @@ do_compile() {
>
>  }
>
> -SRC_URI[md5sum] =3D "d01fc11eacbe43b45681cb85ac112ebf"
>  SRC_URI[sha256sum] =3D
> "f59a5ef7b51bd883f2e9bda37a9360692e6c5e439b98d9b6ac1953e1f98b0680"
>
>  BBCLASSEXTEND =3D "native"
> diff --git a/recipes-core/xml-commons/jaxp1.3_1.4.01.bb
> b/recipes-core/xml-commons/jaxp1.3_1.4.01.bb
> index 98cb077..7965bb8 100644
> --- a/recipes-core/xml-commons/jaxp1.3_1.4.01.bb
> +++ b/recipes-core/xml-commons/jaxp1.3_1.4.01.bb
> @@ -27,7 +27,6 @@ do_compile() {
>    fastjar cfm ${JARFILENAME} manifest.commons -C build .
>  }
>
> -SRC_URI[md5sum] =3D "2fea8e97a5d4d1a24bd05f5f62f3e04e"
>  SRC_URI[sha256sum] =3D
> "d34bd88dc89c5c1ed2545ec5c61e4606fc28beb200a6fecf8c3ed17694181866"
>
>  BBCLASSEXTEND =3D "native"
> diff --git a/recipes-core/xml-commons/jdom_1.1.3.bb
> b/recipes-core/xml-commons/jdom_1.1.3.bb
> index acd2ae1..c7b42f1 100644
> --- a/recipes-core/xml-commons/jdom_1.1.3.bb
> +++ b/recipes-core/xml-commons/jdom_1.1.3.bb
> @@ -9,7 +9,6 @@ HOMEPAGE =3D "http://jdom.org/"
>  DEPENDS =3D "fastjar-native virtual/javac-native jaxen"
>
>  SRC_URI =3D "http://www.jdom.org/dist/source/archive/jdom-${PV}.tar.gz"
> -SRC_URI[md5sum] =3D "dc8391e84cfdb170fcd8279aa370019f"
>  SRC_URI[sha256sum] =3D
> "d471718c4ac7a1a2f10715b93cb3fcd2ecbab60384b73ad1c089712e47bd8d1f"
>
>  PACKAGE_ARCH =3D "${TUNE_PKGARCH}"
> diff --git a/recipes-core/xml-commons/xml-commons-resolver1.1_1.2.bb
> b/recipes-core/xml-commons/xml-commons-resolver1.1_1.2.bb
> index 42ce703..0fafcea 100644
> --- a/recipes-core/xml-commons/xml-commons-resolver1.1_1.2.bb
> +++ b/recipes-core/xml-commons/xml-commons-resolver1.1_1.2.bb
> @@ -36,7 +36,6 @@ do_compile() {
>    fastjar cfm ${JARFILENAME} src/manifest.resolver -C build  org
>  }
>
> -SRC_URI[md5sum] =3D "46d52acdb67ba60f0156043f30108766"
>  SRC_URI[sha256sum] =3D
> "55dbe7bd56452c175320ce9a97b752252c5537427221323c72e9b9c1ac221efe"
>
>  BBCLASSEXTEND =3D "native"
> diff --git a/recipes-core/xml-commons/xpp2_2.1.10.bb
> b/recipes-core/xml-commons/xpp2_2.1.10.bb
> index a76cc4e..170f4ff 100644
> --- a/recipes-core/xml-commons/xpp2_2.1.10.bb
> +++ b/recipes-core/xml-commons/xpp2_2.1.10.bb
> @@ -30,5 +30,4 @@ do_compile() {
>      fastjar -C build-oe -c -f ${JARFILENAME} .
>  }
>
> -SRC_URI[md5sum] =3D "865ca4e2496c215d301b57450137626f"
>  SRC_URI[sha256sum] =3D
> "ad82569b809e29c19b8223feaa12923f97bb4bbc942ff985857f9d853db489cf"
> diff --git a/recipes-core/xml-commons/xpp3_1.1.3.4.O.bb
> b/recipes-core/xml-commons/xpp3_1.1.3.4.O.bb
> index 09ef1f1..ce344c4 100644
> --- a/recipes-core/xml-commons/xpp3_1.1.3.4.O.bb
> +++ b/recipes-core/xml-commons/xpp3_1.1.3.4.O.bb
> @@ -46,5 +46,4 @@ do_install:append() {
>  FILES:libxpp3-xpath-java =3D "${datadir}/java/xpp3-xpath*"
>
>
> -SRC_URI[md5sum] =3D "e1b6aeaad1cd06e64568aae1a507d5c6"
>  SRC_URI[sha256sum] =3D
> "404c0cd332f54ecf9807dc86d365c17dcffab669994c9dcbbad31fbc4b59f811"
> diff --git a/recipes-extended/dbus/dbus-java_2.7.bb
> b/recipes-extended/dbus/dbus-java_2.7.bb
> index 0e5ae92..fc42bcd 100644
> --- a/recipes-extended/dbus/dbus-java_2.7.bb
> +++ b/recipes-extended/dbus/dbus-java_2.7.bb
> @@ -18,7 +18,6 @@ PACKAGE_ARCH =3D "${TUNE_PKGARCH}"
>  LIC_FILES_CHKSUM =3D "file://COPYING;md5=3D72cc739fb93ae32741edbae802490=
e92"
>  SRC_URI =3D "
> http://dbus.freedesktop.org/releases/dbus-java/dbus-java-${PV}.tar.gz"
>
> -SRC_URI[md5sum] =3D "8b8470db5cd657591bac245e3b6e18e4"
>  SRC_URI[sha256sum] =3D
> "be404ea36284d938646192d0ee42e146853064217d4e3aaf89b56bd351ebca33"
>
>  S =3D "${WORKDIR}/dbus-java-${PV}"
> diff --git a/recipes-extended/hsqldb/hsqldb_1.8.0.10.bb
> b/recipes-extended/hsqldb/hsqldb_1.8.0.10.bb
> index 6c34106..b1769f8 100644
> --- a/recipes-extended/hsqldb/hsqldb_1.8.0.10.bb
> +++ b/recipes-extended/hsqldb/hsqldb_1.8.0.10.bb
> @@ -36,6 +36,5 @@ do_compile() {
>      fastjar -C classes -c -f ${JARFILENAME} .
>  }
>
> -SRC_URI[md5sum] =3D "17410483b5b5f267aa18b7e00b65e6e0"
>  SRC_URI[sha256sum] =3D
> "d30b13f4ba2e3b6a2d4f020c0dee0a9fb9fc6fbcc2d561f36b78da4bf3802370"
>
> diff --git a/recipes-extended/rxtx/rxtx_2.2.0.bb b/recipes-extended/rxtx/
> rxtx_2.2.0.bb
> index 27935bc..ade4b96 100644
> --- a/recipes-extended/rxtx/rxtx_2.2.0.bb
> +++ b/recipes-extended/rxtx/rxtx_2.2.0.bb
> @@ -22,7 +22,6 @@ SRC_URI =3D "
> http://rxtx.qbang.org/pub/rxtx/rxtx-2.2pre2.zip \
>             file://0001-Support-Freescale-i.MX-serial-ports.patch \
>             file://javapath.patch"
>
> -SRC_URI[md5sum] =3D "7eedb18e3f33a427e2b0e9be8ce3f94c"
>  SRC_URI[sha256sum] =3D
> "3c30373e760f444def3650c76c5a00ae12fb1d860ec008750d084f4880495b03"
>
>  S =3D "${WORKDIR}/rxtx-2.2pre2"
> diff --git a/recipes-extended/xmlpull/xmlpull_1.1.3.4c.bb
> b/recipes-extended/xmlpull/xmlpull_1.1.3.4c.bb
> index 4f8c9f8..85e970c 100644
> --- a/recipes-extended/xmlpull/xmlpull_1.1.3.4c.bb
> +++ b/recipes-extended/xmlpull/xmlpull_1.1.3.4c.bb
> @@ -25,6 +25,5 @@ do_install() {
>      cp build/lib/${PN}_1_1_3_4c.jar ${JAR}
>  }
>
> -SRC_URI[md5sum] =3D "34c8a093e5678dd633411dfea88f8558"
>  SRC_URI[sha256sum] =3D
> "e17aa1a26119966258a3656a262bbba0f0b036eecb6d9bf192cf4b497686f4c3"
>
> --
> 2.43.0
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#984):
> https://lists.yoctoproject.org/g/yocto-patches/message/984
> Mute This Topic: https://lists.yoctoproject.org/mt/110697255/924729
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://lists.yoctoproject.org/g/yocto-patches/leave/13169857/924729/1023=
951714/xyzzy
> [ticotimo@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--000000000000e2cc25062c18f1c7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Applied to master and scarthgap.<div>Thank you for the con=
tribution and responding to my request to resend.</div></div><br><div class=
=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr=
">On Sun, Jan 19, 2025 at 5:04=E2=80=AFAM J. S. via <a href=3D"http://lists=
.yoctoproject.org">lists.yoctoproject.org</a> &lt;schonm=3D<a href=3D"mailt=
o:gmail.com@lists.yoctoproject.org">gmail.com@lists.yoctoproject.org</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Signed-=
off-by: Jason Schonberg &lt;<a href=3D"mailto:schonm@gmail.com" target=3D"_=
blank">schonm@gmail.com</a>&gt;<br>
---<br>
=C2=A0recipes-core/ant-contrib/<a href=3D"http://ant-contrib-native_1.0b3.b=
b" rel=3D"noreferrer" target=3D"_blank">ant-contrib-native_1.0b3.bb</a>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0| 1 -<br>
=C2=A0recipes-core/ant/<a href=3D"http://ant-native_1.8.1.bb" rel=3D"norefe=
rrer" target=3D"_blank">ant-native_1.8.1.bb</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 -<br>
=C2=A0recipes-core/antlr/<a href=3D"http://antlr_2.7.7.bb" rel=3D"noreferre=
r" target=3D"_blank">antlr_2.7.7.bb</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 -<br>
=C2=A0recipes-core/bcel/<a href=3D"http://bcel_5.2.bb" rel=3D"noreferrer" t=
arget=3D"_blank">bcel_5.2.bb</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 -<br>
=C2=A0recipes-core/cacao/<a href=3D"http://cacao-initial-native_0.98.bb" re=
l=3D"noreferrer" target=3D"_blank">cacao-initial-native_0.98.bb</a>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 -<br>
=C2=A0recipes-core/classpath/<a href=3D"http://classpath-initial-native_0.9=
3.bb" rel=3D"noreferrer" target=3D"_blank">classpath-initial-native_0.93.bb=
</a>=C2=A0 =C2=A0 | 1 -<br>
=C2=A0recipes-core/classpath/<a href=3D"http://classpath-native_0.99.bb" re=
l=3D"noreferrer" target=3D"_blank">classpath-native_0.99.bb</a>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 -<br>
=C2=A0recipes-core/classpath/<a href=3D"http://classpath_0.99.bb" rel=3D"no=
referrer" target=3D"_blank">classpath_0.99.bb</a>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 -<br>
=C2=A0recipes-core/classpathx/<a href=3D"http://gnujaf_1.1.1.bb" rel=3D"nor=
eferrer" target=3D"_blank">gnujaf_1.1.1.bb</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 -<br>
=C2=A0recipes-core/classpathx/<a href=3D"http://gnumail_1.1.2.bb" rel=3D"no=
referrer" target=3D"_blank">gnumail_1.1.2.bb</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 -<br>
=C2=A0recipes-core/classpathx/<a href=3D"http://inetlib_1.1.1.bb" rel=3D"no=
referrer" target=3D"_blank">inetlib_1.1.1.bb</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 -<br>
=C2=A0recipes-core/cup/<a href=3D"http://cup_0.10k.bb" rel=3D"noreferrer" t=
arget=3D"_blank">cup_0.10k.bb</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 -<br>
=C2=A0recipes-core/ecj/<a href=3D"http://libecj-bootstrap-native_3.6.2.bb" =
rel=3D"noreferrer" target=3D"_blank">libecj-bootstrap-native_3.6.2.bb</a>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 -<br>
=C2=A0recipes-core/fastjar/<a href=3D"http://fastjar_0.98.bb" rel=3D"norefe=
rrer" target=3D"_blank">fastjar_0.98.bb</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 -<br>
=C2=A0recipes-core/jacl/<a href=3D"http://jacl_1.4.1.bb" rel=3D"noreferrer"=
 target=3D"_blank">jacl_1.4.1.bb</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 -<br>
=C2=A0recipes-core/jakarta-commons/<a href=3D"http://commons-beanutils_1.8.=
0.bb" rel=3D"noreferrer" target=3D"_blank">commons-beanutils_1.8.0.bb</a>=
=C2=A0 =C2=A0 | 1 -<br>
=C2=A0recipes-core/jakarta-commons/<a href=3D"http://commons-cli_1.1.bb" re=
l=3D"noreferrer" target=3D"_blank">commons-cli_1.1.bb</a>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | 1 -<br>
=C2=A0recipes-core/jakarta-commons/<a href=3D"http://commons-codec_1.3.bb" =
rel=3D"noreferrer" target=3D"_blank">commons-codec_1.3.bb</a>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 | 1 -<br>
=C2=A0recipes-core/jakarta-commons/<a href=3D"http://commons-collections3_3=
.2.2.bb" rel=3D"noreferrer" target=3D"_blank">commons-collections3_3.2.2.bb=
</a> | 1 -<br>
=C2=A0recipes-core/jakarta-commons/<a href=3D"http://commons-collections_2.=
1.1.bb" rel=3D"noreferrer" target=3D"_blank">commons-collections_2.1.1.bb</=
a>=C2=A0 | 1 -<br>
=C2=A0recipes-core/jakarta-commons/<a href=3D"http://commons-digester_1.8.b=
b" rel=3D"noreferrer" target=3D"_blank">commons-digester_1.8.bb</a>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0| 1 -<br>
=C2=A0recipes-core/jakarta-commons/<a href=3D"http://commons-discovery_0.4.=
bb" rel=3D"noreferrer" target=3D"_blank">commons-discovery_0.4.bb</a>=C2=A0=
 =C2=A0 =C2=A0 | 1 -<br>
=C2=A0recipes-core/jakarta-commons/<a href=3D"http://commons-el_1.0.bb" rel=
=3D"noreferrer" target=3D"_blank">commons-el_1.0.bb</a>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 -<br>
=C2=A0recipes-core/jakarta-commons/<a href=3D"http://commons-fileupload_1.2=
.1.bb" rel=3D"noreferrer" target=3D"_blank">commons-fileupload_1.2.1.bb</a>=
=C2=A0 =C2=A0| 1 -<br>
=C2=A0recipes-core/jakarta-commons/<a href=3D"http://commons-httpclient_3.1=
.bb" rel=3D"noreferrer" target=3D"_blank">commons-httpclient_3.1.bb</a>=C2=
=A0 =C2=A0 =C2=A0| 1 -<br>
=C2=A0recipes-core/jakarta-commons/<a href=3D"http://commons-io_1.4.bb" rel=
=3D"noreferrer" target=3D"_blank">commons-io_1.4.bb</a>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 -<br>
=C2=A0recipes-core/jakarta-commons/<a href=3D"http://commons-lang_2.4.bb" r=
el=3D"noreferrer" target=3D"_blank">commons-lang_2.4.bb</a>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 -<br>
=C2=A0recipes-core/jakarta-commons/<a href=3D"http://commons-logging_1.1.1.=
bb" rel=3D"noreferrer" target=3D"_blank">commons-logging_1.1.1.bb</a>=C2=A0=
 =C2=A0 =C2=A0 | 1 -<br>
=C2=A0recipes-core/jakarta-commons/<a href=3D"http://commons-net_1.4.1.bb" =
rel=3D"noreferrer" target=3D"_blank">commons-net_1.4.1.bb</a>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 | 1 -<br>
=C2=A0recipes-core/jakarta-commons/<a href=3D"http://commons-pool_1.4.bb" r=
el=3D"noreferrer" target=3D"_blank">commons-pool_1.4.bb</a>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 -<br>
=C2=A0recipes-core/jakarta-libs/<a href=3D"http://bsf_2.4.0.bb" rel=3D"nore=
ferrer" target=3D"_blank">bsf_2.4.0.bb</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 -<br>
=C2=A0recipes-core/jakarta-libs/<a href=3D"http://log4j1.2_1.2.17.bb" rel=
=3D"noreferrer" target=3D"_blank">log4j1.2_1.2.17.bb</a>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 -<br>
=C2=A0recipes-core/jakarta-libs/<a href=3D"http://logkit_1.2.2.bb" rel=3D"n=
oreferrer" target=3D"_blank">logkit_1.2.2.bb</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 -<br>
=C2=A0recipes-core/jakarta-libs/<a href=3D"http://oro_2.0.8.bb" rel=3D"nore=
ferrer" target=3D"_blank">oro_2.0.8.bb</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 -<br>
=C2=A0recipes-core/jakarta-libs/<a href=3D"http://poi_3.0.bb" rel=3D"norefe=
rrer" target=3D"_blank">poi_3.0.bb</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 -<br>
=C2=A0recipes-core/jakarta-libs/<a href=3D"http://regexp_1.5.bb" rel=3D"nor=
eferrer" target=3D"_blank">regexp_1.5.bb</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 -<br>
=C2=A0recipes-core/jamvm/<a href=3D"http://jamvm-initial-native_1.4.5.bb" r=
el=3D"noreferrer" target=3D"_blank">jamvm-initial-native_1.4.5.bb</a>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 -<br>
=C2=A0recipes-core/javasqlite/<a href=3D"http://javasqlite_20150419.bb" rel=
=3D"noreferrer" target=3D"_blank">javasqlite_20150419.bb</a>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 -<br>
=C2=A0recipes-core/jcraft/<a href=3D"http://jsch_0.1.40.bb" rel=3D"noreferr=
er" target=3D"_blank">jsch_0.1.40.bb</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 -<br>
=C2=A0recipes-core/jcraft/<a href=3D"http://jzlib_1.0.7.bb" rel=3D"noreferr=
er" target=3D"_blank">jzlib_1.0.7.bb</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 -<br>
=C2=A0recipes-core/jikes/<a href=3D"http://jikes_1.22.bb" rel=3D"noreferrer=
" target=3D"_blank">jikes_1.22.bb</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 -<br>
=C2=A0recipes-core/jlex/<a href=3D"http://jlex_1.2.6.bb" rel=3D"noreferrer"=
 target=3D"_blank">jlex_1.2.6.bb</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 -<br>
=C2=A0recipes-core/junit/<a href=3D"http://junit4_4.3.1.bb" rel=3D"noreferr=
er" target=3D"_blank">junit4_4.3.1.bb</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 -<br>
=C2=A0recipes-core/junit/<a href=3D"http://junit_3.8.2.bb" rel=3D"noreferre=
r" target=3D"_blank">junit_3.8.2.bb</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 -<br>
=C2=A0recipes-core/libmatthew/<a href=3D"http://libmatthew_0.8.bb" rel=3D"n=
oreferrer" target=3D"_blank">libmatthew_0.8.bb</a>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 -<br>
=C2=A0recipes-core/servlet-api/<a href=3D"http://jsp2.0_5.5.26.bb" rel=3D"n=
oreferrer" target=3D"_blank">jsp2.0_5.5.26.bb</a>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 -<br>
=C2=A0recipes-core/servlet-api/<a href=3D"http://servlet2.3_4.1.37.bb" rel=
=3D"noreferrer" target=3D"_blank">servlet2.3_4.1.37.bb</a>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 -<br>
=C2=A0recipes-core/servlet-api/<a href=3D"http://servlet2.4_5.5.26.bb" rel=
=3D"noreferrer" target=3D"_blank">servlet2.4_5.5.26.bb</a>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 -<br>
=C2=A0recipes-core/xerces-j/<a href=3D"http://xerces-j_2.11.0.bb" rel=3D"no=
referrer" target=3D"_blank">xerces-j_2.11.0.bb</a>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 -<br>
=C2=A0recipes-core/xml-commons/<a href=3D"http://jaxp1.3_1.4.01.bb" rel=3D"=
noreferrer" target=3D"_blank">jaxp1.3_1.4.01.bb</a>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 -<br>
=C2=A0recipes-core/xml-commons/<a href=3D"http://jdom_1.1.3.bb" rel=3D"nore=
ferrer" target=3D"_blank">jdom_1.1.3.bb</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 -<br>
=C2=A0recipes-core/xml-commons/<a href=3D"http://xml-commons-resolver1.1_1.=
2.bb" rel=3D"noreferrer" target=3D"_blank">xml-commons-resolver1.1_1.2.bb</=
a>=C2=A0 =C2=A0 | 1 -<br>
=C2=A0recipes-core/xml-commons/<a href=3D"http://xpp2_2.1.10.bb" rel=3D"nor=
eferrer" target=3D"_blank">xpp2_2.1.10.bb</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 -<br>
=C2=A0recipes-core/xml-commons/<a href=3D"http://xpp3_1.1.3.4.O.bb" rel=3D"=
noreferrer" target=3D"_blank">xpp3_1.1.3.4.O.bb</a>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 -<br>
=C2=A0recipes-extended/dbus/<a href=3D"http://dbus-java_2.7.bb" rel=3D"nore=
ferrer" target=3D"_blank">dbus-java_2.7.bb</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 -<br>
=C2=A0recipes-extended/hsqldb/<a href=3D"http://hsqldb_1.8.0.10.bb" rel=3D"=
noreferrer" target=3D"_blank">hsqldb_1.8.0.10.bb</a>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 -<br>
=C2=A0recipes-extended/rxtx/<a href=3D"http://rxtx_2.2.0.bb" rel=3D"norefer=
rer" target=3D"_blank">rxtx_2.2.0.bb</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 -<br>
=C2=A0recipes-extended/xmlpull/<a href=3D"http://xmlpull_1.1.3.4c.bb" rel=
=3D"noreferrer" target=3D"_blank">xmlpull_1.1.3.4c.bb</a>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 -<br>
=C2=A058 files changed, 58 deletions(-)<br>
<br>
diff --git a/recipes-core/ant-contrib/<a href=3D"http://ant-contrib-native_=
1.0b3.bb" rel=3D"noreferrer" target=3D"_blank">ant-contrib-native_1.0b3.bb<=
/a> b/recipes-core/ant-contrib/<a href=3D"http://ant-contrib-native_1.0b3.b=
b" rel=3D"noreferrer" target=3D"_blank">ant-contrib-native_1.0b3.bb</a><br>
index db79626..e92f28a 100644<br>
--- a/recipes-core/ant-contrib/<a href=3D"http://ant-contrib-native_1.0b3.b=
b" rel=3D"noreferrer" target=3D"_blank">ant-contrib-native_1.0b3.bb</a><br>
+++ b/recipes-core/ant-contrib/<a href=3D"http://ant-contrib-native_1.0b3.b=
b" rel=3D"noreferrer" target=3D"_blank">ant-contrib-native_1.0b3.bb</a><br>
@@ -16,7 +16,6 @@ inherit java-library native<br>
<br>
=C2=A0SRC_URI =3D &quot;${SOURCEFORGE_MIRROR}/ant-contrib/ant-contrib-${PV}=
-src.zip&quot;<br>
<br>
-SRC_URI[md5sum] =3D &quot;07b23539bef04ec56970c876a33f7665&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;ba3621f397af14d5a19375f391ec9bf2908c46c5=
558ca0df8365e04fe3ac3633&quot;<br>
<br>
=C2=A0S =3D &quot;${WORKDIR}/ant-contrib&quot;<br>
diff --git a/recipes-core/ant/<a href=3D"http://ant-native_1.8.1.bb" rel=3D=
"noreferrer" target=3D"_blank">ant-native_1.8.1.bb</a> b/recipes-core/ant/<=
a href=3D"http://ant-native_1.8.1.bb" rel=3D"noreferrer" target=3D"_blank">=
ant-native_1.8.1.bb</a><br>
index 8814039..b81f71d 100644<br>
--- a/recipes-core/ant/<a href=3D"http://ant-native_1.8.1.bb" rel=3D"norefe=
rrer" target=3D"_blank">ant-native_1.8.1.bb</a><br>
+++ b/recipes-core/ant/<a href=3D"http://ant-native_1.8.1.bb" rel=3D"norefe=
rrer" target=3D"_blank">ant-native_1.8.1.bb</a><br>
@@ -62,6 +62,5 @@ do_install:append() {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 install -m 0755 ${WORKDIR}/ant ${D}${bindir}<br=
>
=C2=A0}<br>
<br>
-SRC_URI[md5sum] =3D &quot;9e5960bd586d9425c46199cdd20a6fbc&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;4f39057af228663c3cfb6dcfbee603a071a7e3cf=
48c95c30869ed81c5fcf21c8&quot;<br>
<br>
diff --git a/recipes-core/antlr/<a href=3D"http://antlr_2.7.7.bb" rel=3D"no=
referrer" target=3D"_blank">antlr_2.7.7.bb</a> b/recipes-core/antlr/<a href=
=3D"http://antlr_2.7.7.bb" rel=3D"noreferrer" target=3D"_blank">antlr_2.7.7=
.bb</a><br>
index d744201..31769c9 100644<br>
--- a/recipes-core/antlr/<a href=3D"http://antlr_2.7.7.bb" rel=3D"noreferre=
r" target=3D"_blank">antlr_2.7.7.bb</a><br>
+++ b/recipes-core/antlr/<a href=3D"http://antlr_2.7.7.bb" rel=3D"noreferre=
r" target=3D"_blank">antlr_2.7.7.bb</a><br>
@@ -26,7 +26,6 @@ do_install:class-native() {<br>
=C2=A0 =C2=A0 =C2=A0install -m 0755 ${WORKDIR}/runantlr ${D}${bindir}/<br>
=C2=A0}<br>
<br>
-SRC_URI[md5sum] =3D &quot;01cc9a2a454dd33dcd8c856ec89af090&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;853aeb021aef7586bda29e74a6b03006bcb565a7=
55c86b66032d8ec31b67dbb9&quot;<br>
<br>
=C2=A0BBCLASSEXTEND =3D &quot;native&quot;<br>
diff --git a/recipes-core/bcel/<a href=3D"http://bcel_5.2.bb" rel=3D"norefe=
rrer" target=3D"_blank">bcel_5.2.bb</a> b/recipes-core/bcel/<a href=3D"http=
://bcel_5.2.bb" rel=3D"noreferrer" target=3D"_blank">bcel_5.2.bb</a><br>
index 1fa6d59..7a8f46f 100644<br>
--- a/recipes-core/bcel/<a href=3D"http://bcel_5.2.bb" rel=3D"noreferrer" t=
arget=3D"_blank">bcel_5.2.bb</a><br>
+++ b/recipes-core/bcel/<a href=3D"http://bcel_5.2.bb" rel=3D"noreferrer" t=
arget=3D"_blank">bcel_5.2.bb</a><br>
@@ -19,7 +19,6 @@ do_compile() {<br>
=C2=A0 =C2=A0fastjar cf ${JARFILENAME} -C build .<br>
=C2=A0}<br>
<br>
-SRC_URI[md5sum] =3D &quot;905b7e718e30e7ca726530ecf106e532&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;68039d59a38379d7b65ea3fc72276c43ba234776=
460e14361af35771bcaab295&quot;<br>
<br>
=C2=A0BBCLASSEXTEND =3D &quot;native&quot;<br>
diff --git a/recipes-core/cacao/<a href=3D"http://cacao-initial-native_0.98=
.bb" rel=3D"noreferrer" target=3D"_blank">cacao-initial-native_0.98.bb</a> =
b/recipes-core/cacao/<a href=3D"http://cacao-initial-native_0.98.bb" rel=3D=
"noreferrer" target=3D"_blank">cacao-initial-native_0.98.bb</a><br>
index 8432456..60c4d4f 100644<br>
--- a/recipes-core/cacao/<a href=3D"http://cacao-initial-native_0.98.bb" re=
l=3D"noreferrer" target=3D"_blank">cacao-initial-native_0.98.bb</a><br>
+++ b/recipes-core/cacao/<a href=3D"http://cacao-initial-native_0.98.bb" re=
l=3D"noreferrer" target=3D"_blank">cacao-initial-native_0.98.bb</a><br>
@@ -40,5 +40,4 @@ do_configure:append() {<br>
=C2=A0 =C2=A0sed -i -e &quot;s|exec cacao \\$|exec cacao-initial \\$|&quot;=
 src/scripts/<a href=3D"http://java.in" rel=3D"noreferrer" target=3D"_blank=
">java.in</a><br>
=C2=A0}<br>
<br>
-SRC_URI[md5sum] =3D &quot;8b8907c8b925761c9410bcadb9705346&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;cb9363add825cedf77764fc49a223aaf43f0a9f4=
85b711ba8c92f16b13fff188&quot;<br>
diff --git a/recipes-core/classpath/<a href=3D"http://classpath-initial-nat=
ive_0.93.bb" rel=3D"noreferrer" target=3D"_blank">classpath-initial-native_=
0.93.bb</a> b/recipes-core/classpath/<a href=3D"http://classpath-initial-na=
tive_0.93.bb" rel=3D"noreferrer" target=3D"_blank">classpath-initial-native=
_0.93.bb</a><br>
index 7bb1ca1..6963ef7 100644<br>
--- a/recipes-core/classpath/<a href=3D"http://classpath-initial-native_0.9=
3.bb" rel=3D"noreferrer" target=3D"_blank">classpath-initial-native_0.93.bb=
</a><br>
+++ b/recipes-core/classpath/<a href=3D"http://classpath-initial-native_0.9=
3.bb" rel=3D"noreferrer" target=3D"_blank">classpath-initial-native_0.93.bb=
</a><br>
@@ -12,7 +12,6 @@ SRC_URI +=3D &quot; \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 file://autotools.patch \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 file://miscompilation.patch \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;<br>
-SRC_URI[md5sum] =3D &quot;ffa9e9cac31c5acbf0ea9eff9efa923d&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;df2d093612abd23fe67e9409d89bb2a8e79b1664=
fe2b2da40e1c8ed693e32945&quot;<br>
<br>
=C2=A0EXTRA_OECONF +=3D &quot;\<br>
diff --git a/recipes-core/classpath/<a href=3D"http://classpath-native_0.99=
.bb" rel=3D"noreferrer" target=3D"_blank">classpath-native_0.99.bb</a> b/re=
cipes-core/classpath/<a href=3D"http://classpath-native_0.99.bb" rel=3D"nor=
eferrer" target=3D"_blank">classpath-native_0.99.bb</a><br>
index ecf8c0a..6f37357 100644<br>
--- a/recipes-core/classpath/<a href=3D"http://classpath-native_0.99.bb" re=
l=3D"noreferrer" target=3D"_blank">classpath-native_0.99.bb</a><br>
+++ b/recipes-core/classpath/<a href=3D"http://classpath-native_0.99.bb" re=
l=3D"noreferrer" target=3D"_blank">classpath-native_0.99.bb</a><br>
@@ -13,7 +13,6 @@ SRC_URI +=3D &quot; \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 file://0001-Fix-bad-implementatio=
n-of-compareTo-in-BigDecimal.patch \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 file://0002-Fix-BigDecimal.stripT=
railingZeros-s-handling-of-0.patch \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;<br>
-SRC_URI[md5sum] =3D &quot;0ae1571249172acd82488724a3b8acb4&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;f929297f8ae9b613a1a167e23156686189326065=
1d913ad9b6c11933895fecc8&quot;<br>
<br>
=C2=A0EXTRA_OECONF +=3D &quot;\<br>
diff --git a/recipes-core/classpath/<a href=3D"http://classpath_0.99.bb" re=
l=3D"noreferrer" target=3D"_blank">classpath_0.99.bb</a> b/recipes-core/cla=
sspath/<a href=3D"http://classpath_0.99.bb" rel=3D"noreferrer" target=3D"_b=
lank">classpath_0.99.bb</a><br>
index f18ad1d..0f805b8 100644<br>
--- a/recipes-core/classpath/<a href=3D"http://classpath_0.99.bb" rel=3D"no=
referrer" target=3D"_blank">classpath_0.99.bb</a><br>
+++ b/recipes-core/classpath/<a href=3D"http://classpath_0.99.bb" rel=3D"no=
referrer" target=3D"_blank">classpath_0.99.bb</a><br>
@@ -15,5 +15,4 @@ SRC_URI +=3D &quot; \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0file://aarch64.patch \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;<br>
<br>
-SRC_URI[md5sum] =3D &quot;0ae1571249172acd82488724a3b8acb4&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;f929297f8ae9b613a1a167e23156686189326065=
1d913ad9b6c11933895fecc8&quot;<br>
diff --git a/recipes-core/classpathx/<a href=3D"http://gnujaf_1.1.1.bb" rel=
=3D"noreferrer" target=3D"_blank">gnujaf_1.1.1.bb</a> b/recipes-core/classp=
athx/<a href=3D"http://gnujaf_1.1.1.bb" rel=3D"noreferrer" target=3D"_blank=
">gnujaf_1.1.1.bb</a><br>
index 0bd8b57..0eacd01 100644<br>
--- a/recipes-core/classpathx/<a href=3D"http://gnujaf_1.1.1.bb" rel=3D"nor=
eferrer" target=3D"_blank">gnujaf_1.1.1.bb</a><br>
+++ b/recipes-core/classpathx/<a href=3D"http://gnujaf_1.1.1.bb" rel=3D"nor=
eferrer" target=3D"_blank">gnujaf_1.1.1.bb</a><br>
@@ -30,7 +30,6 @@ do_compile() {<br>
=C2=A0 =C2=A0fastjar cf ${JARFILENAME} -C build .<br>
=C2=A0}<br>
<br>
-SRC_URI[md5sum] =3D &quot;de50d7728e8140eb404f2b4554321f8c&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;b1b5ef560d30fcb11fbf537246857d14110ce4eb=
2b200d4c54690472305d87b7&quot;<br>
<br>
=C2=A0BBCLASSEXTEND =3D &quot;native&quot;<br>
diff --git a/recipes-core/classpathx/<a href=3D"http://gnumail_1.1.2.bb" re=
l=3D"noreferrer" target=3D"_blank">gnumail_1.1.2.bb</a> b/recipes-core/clas=
spathx/<a href=3D"http://gnumail_1.1.2.bb" rel=3D"noreferrer" target=3D"_bl=
ank">gnumail_1.1.2.bb</a><br>
index 22d0405..86a02b4 100644<br>
--- a/recipes-core/classpathx/<a href=3D"http://gnumail_1.1.2.bb" rel=3D"no=
referrer" target=3D"_blank">gnumail_1.1.2.bb</a><br>
+++ b/recipes-core/classpathx/<a href=3D"http://gnumail_1.1.2.bb" rel=3D"no=
referrer" target=3D"_blank">gnumail_1.1.2.bb</a><br>
@@ -33,7 +33,6 @@ do_compile() {<br>
=C2=A0 =C2=A0 =C2=A0providers_jar=3D${P}-providers.jar<br>
=C2=A0}<br>
<br>
-SRC_URI[md5sum] =3D &quot;0a94ff4328ceb6a4131be96946976a33&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;5eb09597a8f81bfc943206e3e0f45b963ba605a6=
46051c353374f1b475bb9f04&quot;<br>
<br>
=C2=A0BBCLASSEXTEND =3D &quot;native&quot;<br>
diff --git a/recipes-core/classpathx/<a href=3D"http://inetlib_1.1.1.bb" re=
l=3D"noreferrer" target=3D"_blank">inetlib_1.1.1.bb</a> b/recipes-core/clas=
spathx/<a href=3D"http://inetlib_1.1.1.bb" rel=3D"noreferrer" target=3D"_bl=
ank">inetlib_1.1.1.bb</a><br>
index 9146c9e..121559f 100644<br>
--- a/recipes-core/classpathx/<a href=3D"http://inetlib_1.1.1.bb" rel=3D"no=
referrer" target=3D"_blank">inetlib_1.1.1.bb</a><br>
+++ b/recipes-core/classpathx/<a href=3D"http://inetlib_1.1.1.bb" rel=3D"no=
referrer" target=3D"_blank">inetlib_1.1.1.bb</a><br>
@@ -13,7 +13,6 @@ SRC_URI =3D &quot;<a href=3D"http://ftp.gnu.org/gnu/class=
path/$%7BBP%7D.tar.gz" rel=3D"noreferrer" target=3D"_blank">http://ftp.gnu.=
org/gnu/classpath/${BP}.tar.gz</a> \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 file://datadir_java.patch \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 file://inetlib-missing-dependency=
-for-util_classes.patch \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;<br>
-SRC_URI[md5sum] =3D &quot;aaa24be4bc8d172ac675be8bdfa636ee&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;1b078a39e022f86e4e2c8189b4d2789a5da414e8=
f1cb285587b7800b950a44de&quot;<br>
<br>
=C2=A0DEPENDS =3D &quot;classpath-initial-native \<br>
diff --git a/recipes-core/cup/<a href=3D"http://cup_0.10k.bb" rel=3D"norefe=
rrer" target=3D"_blank">cup_0.10k.bb</a> b/recipes-core/cup/<a href=3D"http=
://cup_0.10k.bb" rel=3D"noreferrer" target=3D"_blank">cup_0.10k.bb</a><br>
index ce81453..fcd4ad2 100644<br>
--- a/recipes-core/cup/<a href=3D"http://cup_0.10k.bb" rel=3D"noreferrer" t=
arget=3D"_blank">cup_0.10k.bb</a><br>
+++ b/recipes-core/cup/<a href=3D"http://cup_0.10k.bb" rel=3D"noreferrer" t=
arget=3D"_blank">cup_0.10k.bb</a><br>
@@ -41,7 +41,6 @@ PACKAGES =3D &quot;${PN}&quot;<br>
<br>
=C2=A0FILES:${PN} +=3D &quot;${datadir_java}&quot;<br>
<br>
-SRC_URI[md5sum] =3D &quot;8b11edfec13c590ea443d0f0ae0da479&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;7e6dc5be74ae56c7e86e69ad0ad88dae3b2847af=
a9e73a76635918a6b1eb75cd&quot;<br>
<br>
=C2=A0BBCLASSEXTEND =3D &quot;native&quot;<br>
diff --git a/recipes-core/ecj/<a href=3D"http://libecj-bootstrap-native_3.6=
.2.bb" rel=3D"noreferrer" target=3D"_blank">libecj-bootstrap-native_3.6.2.b=
b</a> b/recipes-core/ecj/<a href=3D"http://libecj-bootstrap-native_3.6.2.bb=
" rel=3D"noreferrer" target=3D"_blank">libecj-bootstrap-native_3.6.2.bb</a>=
<br>
index 51dbca0..b9325f8 100644<br>
--- a/recipes-core/ecj/<a href=3D"http://libecj-bootstrap-native_3.6.2.bb" =
rel=3D"noreferrer" target=3D"_blank">libecj-bootstrap-native_3.6.2.bb</a><b=
r>
+++ b/recipes-core/ecj/<a href=3D"http://libecj-bootstrap-native_3.6.2.bb" =
rel=3D"noreferrer" target=3D"_blank">libecj-bootstrap-native_3.6.2.bb</a><b=
r>
@@ -4,6 +4,5 @@ PR =3D &quot;${INC_PR}.0&quot;<br>
<br>
=C2=A0SRC_URI =3D &quot;<a href=3D"http://archive.eclipse.org/eclipse/downl=
oads/drops/R-3.6.2-201102101200/ecjsrc-$%7BPV%7D.zip" rel=3D"noreferrer" ta=
rget=3D"_blank">http://archive.eclipse.org/eclipse/downloads/drops/R-3.6.2-=
201102101200/ecjsrc-${PV}.zip</a>&quot;<br>
<br>
-SRC_URI[md5sum] =3D &quot;3f3ca1973dd7a21780525c9ffba7a263&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;94f2095d38d71b414a593ec56847008bec267a92=
6ec935959fecdde44f98467f&quot;<br>
<br>
diff --git a/recipes-core/fastjar/<a href=3D"http://fastjar_0.98.bb" rel=3D=
"noreferrer" target=3D"_blank">fastjar_0.98.bb</a> b/recipes-core/fastjar/<=
a href=3D"http://fastjar_0.98.bb" rel=3D"noreferrer" target=3D"_blank">fast=
jar_0.98.bb</a><br>
index 5b5a403..b4491f7 100644<br>
--- a/recipes-core/fastjar/<a href=3D"http://fastjar_0.98.bb" rel=3D"norefe=
rrer" target=3D"_blank">fastjar_0.98.bb</a><br>
+++ b/recipes-core/fastjar/<a href=3D"http://fastjar_0.98.bb" rel=3D"norefe=
rrer" target=3D"_blank">fastjar_0.98.bb</a><br>
@@ -4,6 +4,5 @@ LIC_FILES_CHKSUM =3D &quot;file://COPYING;md5=3D59530bdf336=
59b29e73d4adb9f9f6552&quot;<br>
<br>
=C2=A0SRC_URI +=3D &quot;file://jartool.patch&quot;<br>
<br>
-SRC_URI[md5sum] =3D &quot;d2d264d343d4d0e1575832cc1023c3bf&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;f156abc5de8658f22ee8f08d7a72c88f9409ebd8=
c7933e9466b0842afeb2f145&quot;<br>
<br>
diff --git a/recipes-core/jacl/<a href=3D"http://jacl_1.4.1.bb" rel=3D"nore=
ferrer" target=3D"_blank">jacl_1.4.1.bb</a> b/recipes-core/jacl/<a href=3D"=
http://jacl_1.4.1.bb" rel=3D"noreferrer" target=3D"_blank">jacl_1.4.1.bb</a=
><br>
index d510cc8..b15991e 100644<br>
--- a/recipes-core/jacl/<a href=3D"http://jacl_1.4.1.bb" rel=3D"noreferrer"=
 target=3D"_blank">jacl_1.4.1.bb</a><br>
+++ b/recipes-core/jacl/<a href=3D"http://jacl_1.4.1.bb" rel=3D"noreferrer"=
 target=3D"_blank">jacl_1.4.1.bb</a><br>
@@ -23,7 +23,6 @@ do_compile() {<br>
=C2=A0 =C2=A0fastjar cf ${JARFILENAME} -C build .<br>
=C2=A0}<br>
<br>
-SRC_URI[md5sum] =3D &quot;a7ec8300e8933164e854460c73ac6269&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;0edac0a7d2253c29c44ccc92427fa9ad4ee81b6c=
82142e417f72399a8584b749&quot;<br>
<br>
=C2=A0BBCLASSEXTEND =3D &quot;native&quot;<br>
diff --git a/recipes-core/jakarta-commons/<a href=3D"http://commons-beanuti=
ls_1.8.0.bb" rel=3D"noreferrer" target=3D"_blank">commons-beanutils_1.8.0.b=
b</a> b/recipes-core/jakarta-commons/<a href=3D"http://commons-beanutils_1.=
8.0.bb" rel=3D"noreferrer" target=3D"_blank">commons-beanutils_1.8.0.bb</a>=
<br>
index 2c5ecc2..4521ed8 100644<br>
--- a/recipes-core/jakarta-commons/<a href=3D"http://commons-beanutils_1.8.=
0.bb" rel=3D"noreferrer" target=3D"_blank">commons-beanutils_1.8.0.bb</a><b=
r>
+++ b/recipes-core/jakarta-commons/<a href=3D"http://commons-beanutils_1.8.=
0.bb" rel=3D"noreferrer" target=3D"_blank">commons-beanutils_1.8.0.bb</a><b=
r>
@@ -11,5 +11,4 @@ RDEPENDS:${PN} =3D &quot;libcommons-collections3-java lib=
commons-logging-java&quot;<br>
<br>
=C2=A0CP =3D &quot;commons-collections3 commons-logging&quot;<br>
<br>
-SRC_URI[md5sum] =3D &quot;1bce3cfa4ae33c94686422e78abc0792&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;aff3c8c772e4ff32f2d9a37a727a488583372e45=
535a3d5aad09662691851dcf&quot;<br>
diff --git a/recipes-core/jakarta-commons/<a href=3D"http://commons-cli_1.1=
.bb" rel=3D"noreferrer" target=3D"_blank">commons-cli_1.1.bb</a> b/recipes-=
core/jakarta-commons/<a href=3D"http://commons-cli_1.1.bb" rel=3D"noreferre=
r" target=3D"_blank">commons-cli_1.1.bb</a><br>
index a87097b..2b83a03 100644<br>
--- a/recipes-core/jakarta-commons/<a href=3D"http://commons-cli_1.1.bb" re=
l=3D"noreferrer" target=3D"_blank">commons-cli_1.1.bb</a><br>
+++ b/recipes-core/jakarta-commons/<a href=3D"http://commons-cli_1.1.bb" re=
l=3D"noreferrer" target=3D"_blank">commons-cli_1.1.bb</a><br>
@@ -7,7 +7,6 @@ SUMMARY =3D &quot;Java argument parsing helper classes&quot=
;<br>
<br>
=C2=A0SRC_URI =3D &quot;<a href=3D"http://archive.apache.org/dist/commons/c=
li/source/$%7BBP%7D-src.tar.gz" rel=3D"noreferrer" target=3D"_blank">http:/=
/archive.apache.org/dist/commons/cli/source/${BP}-src.tar.gz</a>&quot;<br>
<br>
-SRC_URI[md5sum] =3D &quot;ccc1aa194132e2387557bbb7f65391f4&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;929eb140c136673e7f5029cd206c81b3c1f5e66b=
ba0dfdcd021b9dd5596356d2&quot;<br>
<br>
=C2=A0BBCLASSEXTEND =3D &quot;native&quot;<br>
diff --git a/recipes-core/jakarta-commons/<a href=3D"http://commons-codec_1=
.3.bb" rel=3D"noreferrer" target=3D"_blank">commons-codec_1.3.bb</a> b/reci=
pes-core/jakarta-commons/<a href=3D"http://commons-codec_1.3.bb" rel=3D"nor=
eferrer" target=3D"_blank">commons-codec_1.3.bb</a><br>
index fa74f6c..cfaada5 100644<br>
--- a/recipes-core/jakarta-commons/<a href=3D"http://commons-codec_1.3.bb" =
rel=3D"noreferrer" target=3D"_blank">commons-codec_1.3.bb</a><br>
+++ b/recipes-core/jakarta-commons/<a href=3D"http://commons-codec_1.3.bb" =
rel=3D"noreferrer" target=3D"_blank">commons-codec_1.3.bb</a><br>
@@ -9,7 +9,6 @@ SRC_URI =3D &quot;<a href=3D"http://archive.apache.org/dist=
/commons/codec/source/$%7BBP%7D-src.tar.gz" rel=3D"noreferrer" target=3D"_b=
lank">http://archive.apache.org/dist/commons/codec/source/${BP}-src.tar.gz<=
/a>&quot;<br>
<br>
=C2=A0S =3D &quot;${WORKDIR}/${BP}&quot;<br>
<br>
-SRC_URI[md5sum] =3D &quot;af3c3acf618de6108d65fcdc92b492e1&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;12effcf3fea025bd34edbfec60a6216ca453fb27=
e781d8e5783caf75fd33d90e&quot;<br>
<br>
=C2=A0BBCLASSEXTEND =3D &quot;native&quot;<br>
diff --git a/recipes-core/jakarta-commons/<a href=3D"http://commons-collect=
ions3_3.2.2.bb" rel=3D"noreferrer" target=3D"_blank">commons-collections3_3=
.2.2.bb</a> b/recipes-core/jakarta-commons/<a href=3D"http://commons-collec=
tions3_3.2.2.bb" rel=3D"noreferrer" target=3D"_blank">commons-collections3_=
3.2.2.bb</a><br>
index 0a53d09..2f23490 100644<br>
--- a/recipes-core/jakarta-commons/<a href=3D"http://commons-collections3_3=
.2.2.bb" rel=3D"noreferrer" target=3D"_blank">commons-collections3_3.2.2.bb=
</a><br>
+++ b/recipes-core/jakarta-commons/<a href=3D"http://commons-collections3_3=
.2.2.bb" rel=3D"noreferrer" target=3D"_blank">commons-collections3_3.2.2.bb=
</a><br>
@@ -10,5 +10,4 @@ SRC_URI =3D &quot;<a href=3D"http://www.apache.org/dist/c=
ommons/collections/source/commons-collect" rel=3D"noreferrer" target=3D"_bl=
ank">http://www.apache.org/dist/commons/collections/source/commons-collect<=
/a><br>
=C2=A0S =3D &quot;${WORKDIR}/commons-collections-${PV}-src&quot;<br>
<br>
<br>
-SRC_URI[md5sum] =3D &quot;776b51a51312c1854ad8f6d344a47cda&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;070d94fe77969d8949bd129a618e6a7bee6b83b5=
b5db3ef3f983395a5428b914&quot;<br>
diff --git a/recipes-core/jakarta-commons/<a href=3D"http://commons-collect=
ions_2.1.1.bb" rel=3D"noreferrer" target=3D"_blank">commons-collections_2.1=
.1.bb</a> b/recipes-core/jakarta-commons/<a href=3D"http://commons-collecti=
ons_2.1.1.bb" rel=3D"noreferrer" target=3D"_blank">commons-collections_2.1.=
1.bb</a><br>
index 4d100a7..898a7df 100644<br>
--- a/recipes-core/jakarta-commons/<a href=3D"http://commons-collections_2.=
1.1.bb" rel=3D"noreferrer" target=3D"_blank">commons-collections_2.1.1.bb</=
a><br>
+++ b/recipes-core/jakarta-commons/<a href=3D"http://commons-collections_2.=
1.1.bb" rel=3D"noreferrer" target=3D"_blank">commons-collections_2.1.1.bb</=
a><br>
@@ -7,5 +7,4 @@ DESCRIPTION =3D &quot;A set of abstract data type interface=
s and implementations that o<br>
=C2=A0SRC_URI =3D &quot;<a href=3D"http://archive.apache.org/dist/commons/c=
ollections/source/$%7BBP%7D-src.tar.gz" rel=3D"noreferrer" target=3D"_blank=
">http://archive.apache.org/dist/commons/collections/source/${BP}-src.tar.g=
z</a>&quot;<br>
<br>
<br>
-SRC_URI[md5sum] =3D &quot;3fc2e8f9d0647074cba992b534ecf6df&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;73eb5907a31c8770480c70f6a6a8d9a9a2ffe602=
e1b461c045cff51ace4cab2a&quot;<br>
diff --git a/recipes-core/jakarta-commons/<a href=3D"http://commons-digeste=
r_1.8.bb" rel=3D"noreferrer" target=3D"_blank">commons-digester_1.8.bb</a> =
b/recipes-core/jakarta-commons/<a href=3D"http://commons-digester_1.8.bb" r=
el=3D"noreferrer" target=3D"_blank">commons-digester_1.8.bb</a><br>
index de264b8..7e595ee 100644<br>
--- a/recipes-core/jakarta-commons/<a href=3D"http://commons-digester_1.8.b=
b" rel=3D"noreferrer" target=3D"_blank">commons-digester_1.8.bb</a><br>
+++ b/recipes-core/jakarta-commons/<a href=3D"http://commons-digester_1.8.b=
b" rel=3D"noreferrer" target=3D"_blank">commons-digester_1.8.bb</a><br>
@@ -13,5 +13,4 @@ CP =3D &quot;commons-logging commons-beanutils&quot;<br>
<br>
=C2=A0FINDARGS =3D &quot;-name &#39;*.dtd&#39;&quot;<br>
<br>
-SRC_URI[md5sum] =3D &quot;689f41905a68c67f7231f9afbb3e2147&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;d9a965c82828a881d2ab6256fba7076f62815a95=
45b3af9d553dc5271577182b&quot;<br>
diff --git a/recipes-core/jakarta-commons/<a href=3D"http://commons-discove=
ry_0.4.bb" rel=3D"noreferrer" target=3D"_blank">commons-discovery_0.4.bb</a=
> b/recipes-core/jakarta-commons/<a href=3D"http://commons-discovery_0.4.bb=
" rel=3D"noreferrer" target=3D"_blank">commons-discovery_0.4.bb</a><br>
index aa87349..60cf683 100644<br>
--- a/recipes-core/jakarta-commons/<a href=3D"http://commons-discovery_0.4.=
bb" rel=3D"noreferrer" target=3D"_blank">commons-discovery_0.4.bb</a><br>
+++ b/recipes-core/jakarta-commons/<a href=3D"http://commons-discovery_0.4.=
bb" rel=3D"noreferrer" target=3D"_blank">commons-discovery_0.4.bb</a><br>
@@ -12,5 +12,4 @@ RDEPENDS:${PN} =3D &quot;libcommons-logging-java&quot;<br=
>
<br>
=C2=A0CP =3D &quot;commons-logging&quot;<br>
<br>
-SRC_URI[md5sum] =3D &quot;1275ad4c6ce54b9323269e30dc42dd0e&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;596242302be4f0502073f5a934c608289bba6221=
591e7dbea53ce629f67498a3&quot;<br>
diff --git a/recipes-core/jakarta-commons/<a href=3D"http://commons-el_1.0.=
bb" rel=3D"noreferrer" target=3D"_blank">commons-el_1.0.bb</a> b/recipes-co=
re/jakarta-commons/<a href=3D"http://commons-el_1.0.bb" rel=3D"noreferrer" =
target=3D"_blank">commons-el_1.0.bb</a><br>
index bb4c35b..b93b68f 100644<br>
--- a/recipes-core/jakarta-commons/<a href=3D"http://commons-el_1.0.bb" rel=
=3D"noreferrer" target=3D"_blank">commons-el_1.0.bb</a><br>
+++ b/recipes-core/jakarta-commons/<a href=3D"http://commons-el_1.0.bb" rel=
=3D"noreferrer" target=3D"_blank">commons-el_1.0.bb</a><br>
@@ -16,5 +16,4 @@ FINDARGS =3D &quot;\( -name &#39;*.properties&#39; -or -n=
ame &#39;*.jj&#39; \)&quot;<br>
<br>
<br>
<br>
-SRC_URI[md5sum] =3D &quot;25038283a0b5f638db5e891295d20020&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;3c9bdded6073563aaaddc9ad7c7387b242dc03cc=
385381503026b665a366c2c6&quot;<br>
diff --git a/recipes-core/jakarta-commons/<a href=3D"http://commons-fileupl=
oad_1.2.1.bb" rel=3D"noreferrer" target=3D"_blank">commons-fileupload_1.2.1=
.bb</a> b/recipes-core/jakarta-commons/<a href=3D"http://commons-fileupload=
_1.2.1.bb" rel=3D"noreferrer" target=3D"_blank">commons-fileupload_1.2.1.bb=
</a><br>
index 395fa15..71a866b 100644<br>
--- a/recipes-core/jakarta-commons/<a href=3D"http://commons-fileupload_1.2=
.1.bb" rel=3D"noreferrer" target=3D"_blank">commons-fileupload_1.2.1.bb</a>=
<br>
+++ b/recipes-core/jakarta-commons/<a href=3D"http://commons-fileupload_1.2=
.1.bb" rel=3D"noreferrer" target=3D"_blank">commons-fileupload_1.2.1.bb</a>=
<br>
@@ -16,5 +16,4 @@ CP =3D &quot;commons-beanutils commons-io servlet-2.3&quo=
t;<br>
=C2=A0COMPILE_FINDARGS =3D &quot;-name &#39;*.java&#39; -not -wholename &#3=
9;*portlet*&#39;&quot;<br>
<br>
<br>
-SRC_URI[md5sum] =3D &quot;c2bdb9264aec564e3f4fbbdf4344a844&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;08905cb3a0db4f7fa67f3b579b2c481060334d50=
d7f913c6974c7513243152f5&quot;<br>
diff --git a/recipes-core/jakarta-commons/<a href=3D"http://commons-httpcli=
ent_3.1.bb" rel=3D"noreferrer" target=3D"_blank">commons-httpclient_3.1.bb<=
/a> b/recipes-core/jakarta-commons/<a href=3D"http://commons-httpclient_3.1=
.bb" rel=3D"noreferrer" target=3D"_blank">commons-httpclient_3.1.bb</a><br>
index a6fb53b..b4e5e2a 100644<br>
--- a/recipes-core/jakarta-commons/<a href=3D"http://commons-httpclient_3.1=
.bb" rel=3D"noreferrer" target=3D"_blank">commons-httpclient_3.1.bb</a><br>
+++ b/recipes-core/jakarta-commons/<a href=3D"http://commons-httpclient_3.1=
.bb" rel=3D"noreferrer" target=3D"_blank">commons-httpclient_3.1.bb</a><br>
@@ -15,7 +15,6 @@ RDEPENDS:${PN}:class-native =3D &quot;&quot;<br>
<br>
=C2=A0CP =3D &quot;commons-logging commons-codec&quot;<br>
<br>
-SRC_URI[md5sum] =3D &quot;2c9b0f83ed5890af02c0df1c1776f39b&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;f9a496d3418b0e15894fb351652cd4fa5ca434eb=
fc3ce3bb8da40defd8b097f2&quot;<br>
<br>
=C2=A0BBCLASSEXTEND =3D &quot;native&quot;<br>
diff --git a/recipes-core/jakarta-commons/<a href=3D"http://commons-io_1.4.=
bb" rel=3D"noreferrer" target=3D"_blank">commons-io_1.4.bb</a> b/recipes-co=
re/jakarta-commons/<a href=3D"http://commons-io_1.4.bb" rel=3D"noreferrer" =
target=3D"_blank">commons-io_1.4.bb</a><br>
index f1dbc88..799a9d4 100644<br>
--- a/recipes-core/jakarta-commons/<a href=3D"http://commons-io_1.4.bb" rel=
=3D"noreferrer" target=3D"_blank">commons-io_1.4.bb</a><br>
+++ b/recipes-core/jakarta-commons/<a href=3D"http://commons-io_1.4.bb" rel=
=3D"noreferrer" target=3D"_blank">commons-io_1.4.bb</a><br>
@@ -7,5 +7,4 @@ DESCRIPTION =3D &quot;Java library with utility classes, st=
ream implementations, file f<br>
<br>
=C2=A0SRC_URI =3D &quot;<a href=3D"http://archive.apache.org/dist/commons/i=
o/source/$%7BBP%7D-src.tar.gz" rel=3D"noreferrer" target=3D"_blank">http://=
archive.apache.org/dist/commons/io/source/${BP}-src.tar.gz</a>&quot;<br>
<br>
-SRC_URI[md5sum] =3D &quot;24b228f2d0c40ffed9204cdab015bccf&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;eca986497f7b4d1b1ec41821b1b5df827bb31fc1=
4833e4449cfa8bcd5d7f29bb&quot;<br>
diff --git a/recipes-core/jakarta-commons/<a href=3D"http://commons-lang_2.=
4.bb" rel=3D"noreferrer" target=3D"_blank">commons-lang_2.4.bb</a> b/recipe=
s-core/jakarta-commons/<a href=3D"http://commons-lang_2.4.bb" rel=3D"norefe=
rrer" target=3D"_blank">commons-lang_2.4.bb</a><br>
index 48cc291..e0c3736 100644<br>
--- a/recipes-core/jakarta-commons/<a href=3D"http://commons-lang_2.4.bb" r=
el=3D"noreferrer" target=3D"_blank">commons-lang_2.4.bb</a><br>
+++ b/recipes-core/jakarta-commons/<a href=3D"http://commons-lang_2.4.bb" r=
el=3D"noreferrer" target=3D"_blank">commons-lang_2.4.bb</a><br>
@@ -8,5 +8,4 @@ DESCRIPTION =3D &quot;Set of Java classes that provide help=
er methods for the standard<br>
=C2=A0SRC_URI =3D &quot;<a href=3D"http://archive.apache.org/dist/commons/l=
ang/source/$%7BBP%7D-src.tar.gz" rel=3D"noreferrer" target=3D"_blank">http:=
//archive.apache.org/dist/commons/lang/source/${BP}-src.tar.gz</a>&quot;<br=
>
<br>
<br>
-SRC_URI[md5sum] =3D &quot;625ff5f2f968dd908bca43c9469d6e6b&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;2445238cd0eb167e99a1147394f61325490559f3=
df7e7e8f628043fb70cbf2f4&quot;<br>
diff --git a/recipes-core/jakarta-commons/<a href=3D"http://commons-logging=
_1.1.1.bb" rel=3D"noreferrer" target=3D"_blank">commons-logging_1.1.1.bb</a=
> b/recipes-core/jakarta-commons/<a href=3D"http://commons-logging_1.1.1.bb=
" rel=3D"noreferrer" target=3D"_blank">commons-logging_1.1.1.bb</a><br>
index 7aa2372..6de3228 100644<br>
--- a/recipes-core/jakarta-commons/<a href=3D"http://commons-logging_1.1.1.=
bb" rel=3D"noreferrer" target=3D"_blank">commons-logging_1.1.1.bb</a><br>
+++ b/recipes-core/jakarta-commons/<a href=3D"http://commons-logging_1.1.1.=
bb" rel=3D"noreferrer" target=3D"_blank">commons-logging_1.1.1.bb</a><br>
@@ -12,7 +12,6 @@ CP =3D &quot;log4j-1.2 servlet-2.3 logkit&quot;<br>
<br>
=C2=A0COMPILE_FINDARGS =3D &quot;-name &#39;*.java&#39; -and -not -name &#3=
9;*Avalon*&#39;&quot;<br>
<br>
-SRC_URI[md5sum] =3D &quot;e5cfa8cca13152d7545fde6b1783c60a&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;b49a79fa78ebfae15dc46ae6f0144fee6b94ab60=
8a25518c54609d3419909eb2&quot;<br>
<br>
=C2=A0BBCLASSEXTEND =3D &quot;native&quot;<br>
diff --git a/recipes-core/jakarta-commons/<a href=3D"http://commons-net_1.4=
.1.bb" rel=3D"noreferrer" target=3D"_blank">commons-net_1.4.1.bb</a> b/reci=
pes-core/jakarta-commons/<a href=3D"http://commons-net_1.4.1.bb" rel=3D"nor=
eferrer" target=3D"_blank">commons-net_1.4.1.bb</a><br>
index ba62ebc..bffbbae 100644<br>
--- a/recipes-core/jakarta-commons/<a href=3D"http://commons-net_1.4.1.bb" =
rel=3D"noreferrer" target=3D"_blank">commons-net_1.4.1.bb</a><br>
+++ b/recipes-core/jakarta-commons/<a href=3D"http://commons-net_1.4.1.bb" =
rel=3D"noreferrer" target=3D"_blank">commons-net_1.4.1.bb</a><br>
@@ -18,7 +18,6 @@ CP =3D &quot;oro&quot;<br>
<br>
=C2=A0MAINSOURCES =3D &quot;src/java/org&quot;<br>
<br>
-SRC_URI[md5sum] =3D &quot;ccbb3f67b55e8a7a676499db4386673c&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;fdea779f261f70b9bbec40121c830b11e3e63b61=
88f662f95505045ff8d44add&quot;<br>
<br>
=C2=A0BBCLASSEXTEND =3D &quot;native&quot;<br>
diff --git a/recipes-core/jakarta-commons/<a href=3D"http://commons-pool_1.=
4.bb" rel=3D"noreferrer" target=3D"_blank">commons-pool_1.4.bb</a> b/recipe=
s-core/jakarta-commons/<a href=3D"http://commons-pool_1.4.bb" rel=3D"norefe=
rrer" target=3D"_blank">commons-pool_1.4.bb</a><br>
index 95c8cf1..824b772 100644<br>
--- a/recipes-core/jakarta-commons/<a href=3D"http://commons-pool_1.4.bb" r=
el=3D"noreferrer" target=3D"_blank">commons-pool_1.4.bb</a><br>
+++ b/recipes-core/jakarta-commons/<a href=3D"http://commons-pool_1.4.bb" r=
el=3D"noreferrer" target=3D"_blank">commons-pool_1.4.bb</a><br>
@@ -7,5 +7,4 @@ SUMMARY =3D &quot;Java Object-pooling API&quot;<br>
<br>
=C2=A0SRC_URI =3D &quot;<a href=3D"http://archive.apache.org/dist/commons/p=
ool/source/$%7BBP%7D-src.tar.gz" rel=3D"noreferrer" target=3D"_blank">http:=
//archive.apache.org/dist/commons/pool/source/${BP}-src.tar.gz</a>&quot;<br=
>
<br>
-SRC_URI[md5sum] =3D &quot;4dc988ee16e1471799af97763297b41b&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;ca4452f2a2ce2daf6eaa1743ded2d3b36013200c=
48e3f2117b65584ca5cc1d9b&quot;<br>
diff --git a/recipes-core/jakarta-libs/<a href=3D"http://bsf_2.4.0.bb" rel=
=3D"noreferrer" target=3D"_blank">bsf_2.4.0.bb</a> b/recipes-core/jakarta-l=
ibs/<a href=3D"http://bsf_2.4.0.bb" rel=3D"noreferrer" target=3D"_blank">bs=
f_2.4.0.bb</a><br>
index 22d9320..a38c335 100644<br>
--- a/recipes-core/jakarta-libs/<a href=3D"http://bsf_2.4.0.bb" rel=3D"nore=
ferrer" target=3D"_blank">bsf_2.4.0.bb</a><br>
+++ b/recipes-core/jakarta-libs/<a href=3D"http://bsf_2.4.0.bb" rel=3D"nore=
ferrer" target=3D"_blank">bsf_2.4.0.bb</a><br>
@@ -27,7 +27,6 @@ do_compile() {<br>
=C2=A0}<br>
<br>
<br>
-SRC_URI[md5sum] =3D &quot;7e58b2a009c0f70ab36bbef420b25c07&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;5ab58cf5738c144f4d85a4a442c2f33be2c4c502=
dca6e29e0c570c2a51ae6ae9&quot;<br>
<br>
=C2=A0BBCLASSEXTEND =3D &quot;native&quot;<br>
diff --git a/recipes-core/jakarta-libs/<a href=3D"http://log4j1.2_1.2.17.bb=
" rel=3D"noreferrer" target=3D"_blank">log4j1.2_1.2.17.bb</a> b/recipes-cor=
e/jakarta-libs/<a href=3D"http://log4j1.2_1.2.17.bb" rel=3D"noreferrer" tar=
get=3D"_blank">log4j1.2_1.2.17.bb</a><br>
index 2f04e96..bd8c9d8 100644<br>
--- a/recipes-core/jakarta-libs/<a href=3D"http://log4j1.2_1.2.17.bb" rel=
=3D"noreferrer" target=3D"_blank">log4j1.2_1.2.17.bb</a><br>
+++ b/recipes-core/jakarta-libs/<a href=3D"http://log4j1.2_1.2.17.bb" rel=
=3D"noreferrer" target=3D"_blank">log4j1.2_1.2.17.bb</a><br>
@@ -29,7 +29,6 @@ do_compile() {<br>
=C2=A0 =C2=A0fastjar cf ${JARFILENAME} -C build .<br>
=C2=A0}<br>
<br>
-SRC_URI[md5sum] =3D &quot;8218714e41ee0c6509dcfeafa2e1f53f&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;a528e3771ee6234661b5eb0fa02e14faee89dfec=
38de94088c163ddf2a0a8663&quot;<br>
<br>
=C2=A0BBCLASSEXTEND =3D &quot;native&quot;<br>
diff --git a/recipes-core/jakarta-libs/<a href=3D"http://logkit_1.2.2.bb" r=
el=3D"noreferrer" target=3D"_blank">logkit_1.2.2.bb</a> b/recipes-core/jaka=
rta-libs/<a href=3D"http://logkit_1.2.2.bb" rel=3D"noreferrer" target=3D"_b=
lank">logkit_1.2.2.bb</a><br>
index 8b4de11..c3d83a5 100644<br>
--- a/recipes-core/jakarta-libs/<a href=3D"http://logkit_1.2.2.bb" rel=3D"n=
oreferrer" target=3D"_blank">logkit_1.2.2.bb</a><br>
+++ b/recipes-core/jakarta-libs/<a href=3D"http://logkit_1.2.2.bb" rel=3D"n=
oreferrer" target=3D"_blank">logkit_1.2.2.bb</a><br>
@@ -26,7 +26,6 @@ do_compile() {<br>
=C2=A0 =C2=A0fastjar cf ${JARFILENAME} -C build .<br>
=C2=A0}<br>
<br>
-SRC_URI[md5sum] =3D &quot;996ee20d6b5785ab71f4692f64d10f9c&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;2c81edc87571fbd05797da7f65515e089c62cbb7=
35bdbd10f93e29bd3aa3ddb8&quot;<br>
<br>
=C2=A0BBCLASSEXTEND =3D &quot;native&quot;<br>
diff --git a/recipes-core/jakarta-libs/<a href=3D"http://oro_2.0.8.bb" rel=
=3D"noreferrer" target=3D"_blank">oro_2.0.8.bb</a> b/recipes-core/jakarta-l=
ibs/<a href=3D"http://oro_2.0.8.bb" rel=3D"noreferrer" target=3D"_blank">or=
o_2.0.8.bb</a><br>
index 97e29d0..80efd49 100644<br>
--- a/recipes-core/jakarta-libs/<a href=3D"http://oro_2.0.8.bb" rel=3D"nore=
ferrer" target=3D"_blank">oro_2.0.8.bb</a><br>
+++ b/recipes-core/jakarta-libs/<a href=3D"http://oro_2.0.8.bb" rel=3D"nore=
ferrer" target=3D"_blank">oro_2.0.8.bb</a><br>
@@ -18,7 +18,6 @@ do_compile() {<br>
=C2=A0 =C2=A0fastjar cf ${JARFILENAME} -C build org<br>
=C2=A0}<br>
<br>
-SRC_URI[md5sum] =3D &quot;6f7690c6ba9750e3cbb8ebd10078a79a&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;4c4f3c7c479994c3ce09f542d4fbdc03eed58a2d=
7f320d32f2baf238b5b6f566&quot;<br>
<br>
=C2=A0BBCLASSEXTEND =3D &quot;native&quot;<br>
diff --git a/recipes-core/jakarta-libs/<a href=3D"http://poi_3.0.bb" rel=3D=
"noreferrer" target=3D"_blank">poi_3.0.bb</a> b/recipes-core/jakarta-libs/<=
a href=3D"http://poi_3.0.bb" rel=3D"noreferrer" target=3D"_blank">poi_3.0.b=
b</a><br>
index e33f2f2..3733c3c 100644<br>
--- a/recipes-core/jakarta-libs/<a href=3D"http://poi_3.0.bb" rel=3D"norefe=
rrer" target=3D"_blank">poi_3.0.bb</a><br>
+++ b/recipes-core/jakarta-libs/<a href=3D"http://poi_3.0.bb" rel=3D"norefe=
rrer" target=3D"_blank">poi_3.0.bb</a><br>
@@ -26,5 +26,4 @@ do_compile() {<br>
=C2=A0 =C2=A0fastjar -C build -c -f ${JARFILENAME} .<br>
=C2=A0}<br>
<br>
-SRC_URI[md5sum] =3D &quot;1fb488c4061256197a667f1c480ffc33&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;48a5aabb873d4cc654c95acf6576868d7a8a3ee9=
7e1c6418e1d716698b6efa76&quot;<br>
diff --git a/recipes-core/jakarta-libs/<a href=3D"http://regexp_1.5.bb" rel=
=3D"noreferrer" target=3D"_blank">regexp_1.5.bb</a> b/recipes-core/jakarta-=
libs/<a href=3D"http://regexp_1.5.bb" rel=3D"noreferrer" target=3D"_blank">=
regexp_1.5.bb</a><br>
index 614da2a..40dec0a 100644<br>
--- a/recipes-core/jakarta-libs/<a href=3D"http://regexp_1.5.bb" rel=3D"nor=
eferrer" target=3D"_blank">regexp_1.5.bb</a><br>
+++ b/recipes-core/jakarta-libs/<a href=3D"http://regexp_1.5.bb" rel=3D"nor=
eferrer" target=3D"_blank">regexp_1.5.bb</a><br>
@@ -18,7 +18,6 @@ do_compile() {<br>
=C2=A0 =C2=A0fastjar cf ${JARFILENAME} -C build .<br>
=C2=A0}<br>
<br>
-SRC_URI[md5sum] =3D &quot;b941b8f4de297827f3211c2cb34af199&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;79e80af8cbeb68ddad75a1aa6244d7acd62176bf=
d69bcdc0640d11177dcde97d&quot;<br>
<br>
=C2=A0BBCLASSEXTEND =3D &quot;native&quot;<br>
diff --git a/recipes-core/jamvm/<a href=3D"http://jamvm-initial-native_1.4.=
5.bb" rel=3D"noreferrer" target=3D"_blank">jamvm-initial-native_1.4.5.bb</a=
> b/recipes-core/jamvm/<a href=3D"http://jamvm-initial-native_1.4.5.bb" rel=
=3D"noreferrer" target=3D"_blank">jamvm-initial-native_1.4.5.bb</a><br>
index 7773409..6a34f31 100644<br>
--- a/recipes-core/jamvm/<a href=3D"http://jamvm-initial-native_1.4.5.bb" r=
el=3D"noreferrer" target=3D"_blank">jamvm-initial-native_1.4.5.bb</a><br>
+++ b/recipes-core/jamvm/<a href=3D"http://jamvm-initial-native_1.4.5.bb" r=
el=3D"noreferrer" target=3D"_blank">jamvm-initial-native_1.4.5.bb</a><br>
@@ -43,7 +43,6 @@ do_install:append() {<br>
=C2=A0 =C2=A0install -m 0755 ${WORKDIR}/java-initial ${D}${bindir}/<br>
=C2=A0}<br>
<br>
-SRC_URI[md5sum] =3D &quot;3f538bab6e1c77aed331e5e71f754f5b&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;f329d1c8f42c06b53a3e82763d33900b100b8e9a=
cd7afe02f7583c51253fd6e5&quot;<br>
=C2=A0# shared state for jamvm-native does not work<br>
=C2=A0# since the paths are hardcoded<br>
diff --git a/recipes-core/javasqlite/<a href=3D"http://javasqlite_20150419.=
bb" rel=3D"noreferrer" target=3D"_blank">javasqlite_20150419.bb</a> b/recip=
es-core/javasqlite/<a href=3D"http://javasqlite_20150419.bb" rel=3D"norefer=
rer" target=3D"_blank">javasqlite_20150419.bb</a><br>
index 45262e2..9a6518d 100644<br>
--- a/recipes-core/javasqlite/<a href=3D"http://javasqlite_20150419.bb" rel=
=3D"noreferrer" target=3D"_blank">javasqlite_20150419.bb</a><br>
+++ b/recipes-core/javasqlite/<a href=3D"http://javasqlite_20150419.bb" rel=
=3D"noreferrer" target=3D"_blank">javasqlite_20150419.bb</a><br>
@@ -23,7 +23,6 @@ FILES:${PN} +=3D&quot;/usr/share&quot;<br>
<br>
=C2=A0PARALLEL_MAKE =3D &quot;-j 1&quot;<br>
<br>
-SRC_URI[md5sum] =3D &quot;242e384c1cd863d6996a35cf8c1c1e97&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;b6b26e2c1a2174f5525d904eb3ff698c3f7089f0=
d4b4c84cf6121da08c8d801f&quot;<br>
<br>
=C2=A0EXTRA_OECONF =3D &quot; \<br>
diff --git a/recipes-core/jcraft/<a href=3D"http://jsch_0.1.40.bb" rel=3D"n=
oreferrer" target=3D"_blank">jsch_0.1.40.bb</a> b/recipes-core/jcraft/<a hr=
ef=3D"http://jsch_0.1.40.bb" rel=3D"noreferrer" target=3D"_blank">jsch_0.1.=
40.bb</a><br>
index aeb04b4..7fa8571 100644<br>
--- a/recipes-core/jcraft/<a href=3D"http://jsch_0.1.40.bb" rel=3D"noreferr=
er" target=3D"_blank">jsch_0.1.40.bb</a><br>
+++ b/recipes-core/jcraft/<a href=3D"http://jsch_0.1.40.bb" rel=3D"noreferr=
er" target=3D"_blank">jsch_0.1.40.bb</a><br>
@@ -22,7 +22,6 @@ do_compile() {<br>
=C2=A0 =C2=A0fastjar cf ${JARFILENAME} -C build .<br>
=C2=A0}<br>
<br>
-SRC_URI[md5sum] =3D &quot;b59cec19a487e95aed68378976b4b566&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;ca9d2ae08fd7a8983fb00d04f0f0c216a985218a=
5eb364ff9bee73870f28e097&quot;<br>
<br>
=C2=A0CVE_STATUS[CVE-2016-5725] =3D &quot;not-applicable-platform: Issue on=
ly applies on Windows&quot;<br>
diff --git a/recipes-core/jcraft/<a href=3D"http://jzlib_1.0.7.bb" rel=3D"n=
oreferrer" target=3D"_blank">jzlib_1.0.7.bb</a> b/recipes-core/jcraft/<a hr=
ef=3D"http://jzlib_1.0.7.bb" rel=3D"noreferrer" target=3D"_blank">jzlib_1.0=
.7.bb</a><br>
index 1e34d2c..65cced8 100644<br>
--- a/recipes-core/jcraft/<a href=3D"http://jzlib_1.0.7.bb" rel=3D"noreferr=
er" target=3D"_blank">jzlib_1.0.7.bb</a><br>
+++ b/recipes-core/jcraft/<a href=3D"http://jzlib_1.0.7.bb" rel=3D"noreferr=
er" target=3D"_blank">jzlib_1.0.7.bb</a><br>
@@ -16,7 +16,6 @@ do_compile() {<br>
=C2=A0 =C2=A0fastjar cf ${JARFILENAME} -C build .<br>
=C2=A0}<br>
<br>
-SRC_URI[md5sum] =3D &quot;3c52a0afb970e8a1fb2d34f30d330a83&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;20923a3f771a14c58c8cddfff2b589d568aff09f=
8a931919dc63ddaabb32407a&quot;<br>
<br>
=C2=A0BBCLASSEXTEND =3D &quot;native&quot;<br>
diff --git a/recipes-core/jikes/<a href=3D"http://jikes_1.22.bb" rel=3D"nor=
eferrer" target=3D"_blank">jikes_1.22.bb</a> b/recipes-core/jikes/<a href=
=3D"http://jikes_1.22.bb" rel=3D"noreferrer" target=3D"_blank">jikes_1.22.b=
b</a><br>
index 3e83ff8..b7fa7fa 100644<br>
--- a/recipes-core/jikes/<a href=3D"http://jikes_1.22.bb" rel=3D"noreferrer=
" target=3D"_blank">jikes_1.22.bb</a><br>
+++ b/recipes-core/jikes/<a href=3D"http://jikes_1.22.bb" rel=3D"noreferrer=
" target=3D"_blank">jikes_1.22.bb</a><br>
@@ -32,5 +32,4 @@ ALTERNATIVE:${PN} =3D &quot;javac&quot;<br>
=C2=A0ALTERNATIVE_LINK =3D &quot;/usr/bin/javac&quot;<br>
=C2=A0ALTERNATIVE_TARGET =3D &quot;${bindir}/javac.jikes&quot;<br>
<br>
-SRC_URI[md5sum] =3D &quot;cda958c7fef6b43b803e1d1ef9afcb85&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;0cb02c763bc441349f6d38cacd52adf762302cce=
3a08e269f1f75f726e6e14e3&quot;<br>
diff --git a/recipes-core/jlex/<a href=3D"http://jlex_1.2.6.bb" rel=3D"nore=
ferrer" target=3D"_blank">jlex_1.2.6.bb</a> b/recipes-core/jlex/<a href=3D"=
http://jlex_1.2.6.bb" rel=3D"noreferrer" target=3D"_blank">jlex_1.2.6.bb</a=
><br>
index 48ec357..5c8d9ee 100644<br>
--- a/recipes-core/jlex/<a href=3D"http://jlex_1.2.6.bb" rel=3D"noreferrer"=
 target=3D"_blank">jlex_1.2.6.bb</a><br>
+++ b/recipes-core/jlex/<a href=3D"http://jlex_1.2.6.bb" rel=3D"noreferrer"=
 target=3D"_blank">jlex_1.2.6.bb</a><br>
@@ -44,7 +44,6 @@ PACKAGES =3D &quot;${PN}&quot;<br>
<br>
=C2=A0FILES:${PN} +=3D &quot;${datadir_java}&quot;<br>
<br>
-SRC_URI[md5sum] =3D &quot;fe0cff5db3e2f0f5d67a153cf6c783af&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;aeebaece3b3a53972bb0ba0f810540386c267070=
ee9dca6ffa43c6ff74a54bd7&quot;<br>
<br>
=C2=A0BBCLASSEXTEND =3D &quot;native&quot;<br>
diff --git a/recipes-core/junit/<a href=3D"http://junit4_4.3.1.bb" rel=3D"n=
oreferrer" target=3D"_blank">junit4_4.3.1.bb</a> b/recipes-core/junit/<a hr=
ef=3D"http://junit4_4.3.1.bb" rel=3D"noreferrer" target=3D"_blank">junit4_4=
.3.1.bb</a><br>
index b2cd4d9..89517cb 100644<br>
--- a/recipes-core/junit/<a href=3D"http://junit4_4.3.1.bb" rel=3D"noreferr=
er" target=3D"_blank">junit4_4.3.1.bb</a><br>
+++ b/recipes-core/junit/<a href=3D"http://junit4_4.3.1.bb" rel=3D"noreferr=
er" target=3D"_blank">junit4_4.3.1.bb</a><br>
@@ -23,7 +23,6 @@ do_compile() {<br>
=C2=A0 =C2=A0fastjar -C build -c -f ${JARFILENAME} .<br>
=C2=A0}<br>
<br>
-SRC_URI[md5sum] =3D &quot;170f9645a41398388e8553b32ff5f630&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;57d1e49ee3fd0dbdc0a68a852925c973af5c30b1=
725b6aa63bfb42df6f7c3349&quot;<br>
<br>
=C2=A0BBCLASSEXTEND =3D &quot;native&quot;<br>
diff --git a/recipes-core/junit/<a href=3D"http://junit_3.8.2.bb" rel=3D"no=
referrer" target=3D"_blank">junit_3.8.2.bb</a> b/recipes-core/junit/<a href=
=3D"http://junit_3.8.2.bb" rel=3D"noreferrer" target=3D"_blank">junit_3.8.2=
.bb</a><br>
index 57dd459..988101f 100644<br>
--- a/recipes-core/junit/<a href=3D"http://junit_3.8.2.bb" rel=3D"noreferre=
r" target=3D"_blank">junit_3.8.2.bb</a><br>
+++ b/recipes-core/junit/<a href=3D"http://junit_3.8.2.bb" rel=3D"noreferre=
r" target=3D"_blank">junit_3.8.2.bb</a><br>
@@ -36,7 +36,6 @@ do_compile() {<br>
=C2=A0 =C2=A0fastjar cf ${JARFILENAME} -C build .<br>
=C2=A0}<br>
<br>
-SRC_URI[md5sum] =3D &quot;9b8963ba2147a64bd5f1574b6fd289cb&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;aae23d20e6f4dc45b4bf0b10fedcbd209c100342=
a0cafce1aa07d2da6da1f24a&quot;<br>
<br>
=C2=A0BBCLASSEXTEND =3D &quot;native&quot;<br>
diff --git a/recipes-core/libmatthew/<a href=3D"http://libmatthew_0.8.bb" r=
el=3D"noreferrer" target=3D"_blank">libmatthew_0.8.bb</a> b/recipes-core/li=
bmatthew/<a href=3D"http://libmatthew_0.8.bb" rel=3D"noreferrer" target=3D"=
_blank">libmatthew_0.8.bb</a><br>
index c4ace08..1cf50c7 100644<br>
--- a/recipes-core/libmatthew/<a href=3D"http://libmatthew_0.8.bb" rel=3D"n=
oreferrer" target=3D"_blank">libmatthew_0.8.bb</a><br>
+++ b/recipes-core/libmatthew/<a href=3D"http://libmatthew_0.8.bb" rel=3D"n=
oreferrer" target=3D"_blank">libmatthew_0.8.bb</a><br>
@@ -7,6 +7,5 @@ LIC_FILES_CHKSUM =3D &quot;file://COPYING;md5=3D48a42f2f974=
7f02bf40a0bce2655b509&quot;<br>
=C2=A0SRC_URI =3D &quot;<a href=3D"http://pkgs.fedoraproject.org/repo/pkgs/=
libmatthew-java/libmatthew-java-0.8.tar.gz/8455b8751083ce25c99c2840609271f5=
/libmatthew-java-$%7BPV%7D.tar.gz" rel=3D"noreferrer" target=3D"_blank">htt=
p://pkgs.fedoraproject.org/repo/pkgs/libmatthew-java/libmatthew-java-0.8.ta=
r.gz/8455b8751083ce25c99c2840609271f5/libmatthew-java-${PV}.tar.gz</a> \<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0file://Makefile-0.7.patch&q=
uot;<br>
-SRC_URI[md5sum] =3D &quot;8455b8751083ce25c99c2840609271f5&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;05d1d3d9b5e33bd3642102aae10bba904e296c5c=
01a10854200ad4df349c8dfa&quot;<br>
<br>
diff --git a/recipes-core/servlet-api/<a href=3D"http://jsp2.0_5.5.26.bb" r=
el=3D"noreferrer" target=3D"_blank">jsp2.0_5.5.26.bb</a> b/recipes-core/ser=
vlet-api/<a href=3D"http://jsp2.0_5.5.26.bb" rel=3D"noreferrer" target=3D"_=
blank">jsp2.0_5.5.26.bb</a><br>
index ac8617c..3d9f4da 100644<br>
--- a/recipes-core/servlet-api/<a href=3D"http://jsp2.0_5.5.26.bb" rel=3D"n=
oreferrer" target=3D"_blank">jsp2.0_5.5.26.bb</a><br>
+++ b/recipes-core/servlet-api/<a href=3D"http://jsp2.0_5.5.26.bb" rel=3D"n=
oreferrer" target=3D"_blank">jsp2.0_5.5.26.bb</a><br>
@@ -43,5 +43,4 @@ do_compile() {<br>
=C2=A0 =C2=A0fastjar -C build -c -m src/etc/manifest -f ${JARFILENAME} .<br=
>
=C2=A0}<br>
<br>
-SRC_URI[md5sum] =3D &quot;642b6526354cb18c5b5d77ebef8109ae&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;ddc677d7391c438e6102d0b3e9653eaca661344e=
f74b0260c1f488340d660395&quot;<br>
diff --git a/recipes-core/servlet-api/<a href=3D"http://servlet2.3_4.1.37.b=
b" rel=3D"noreferrer" target=3D"_blank">servlet2.3_4.1.37.bb</a> b/recipes-=
core/servlet-api/<a href=3D"http://servlet2.3_4.1.37.bb" rel=3D"noreferrer"=
 target=3D"_blank">servlet2.3_4.1.37.bb</a><br>
index 996f93b..dceece6 100644<br>
--- a/recipes-core/servlet-api/<a href=3D"http://servlet2.3_4.1.37.bb" rel=
=3D"noreferrer" target=3D"_blank">servlet2.3_4.1.37.bb</a><br>
+++ b/recipes-core/servlet-api/<a href=3D"http://servlet2.3_4.1.37.bb" rel=
=3D"noreferrer" target=3D"_blank">servlet2.3_4.1.37.bb</a><br>
@@ -43,7 +43,6 @@ do_compile() {<br>
=C2=A0 =C2=A0fastjar cfm ${JARFILENAME} src/etc/manifest -C build .<br>
=C2=A0}<br>
<br>
-SRC_URI[md5sum] =3D &quot;fe50177a25a084ad1abf4a201d08c2a6&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;65e4cc9d3ea4a7f30044bfd6c660c772adb75ac1=
52d775342deb6049a0d19d74&quot;<br>
<br>
=C2=A0BBCLASSEXTEND =3D &quot;native&quot;<br>
diff --git a/recipes-core/servlet-api/<a href=3D"http://servlet2.4_5.5.26.b=
b" rel=3D"noreferrer" target=3D"_blank">servlet2.4_5.5.26.bb</a> b/recipes-=
core/servlet-api/<a href=3D"http://servlet2.4_5.5.26.bb" rel=3D"noreferrer"=
 target=3D"_blank">servlet2.4_5.5.26.bb</a><br>
index 7424673..eb2f769 100644<br>
--- a/recipes-core/servlet-api/<a href=3D"http://servlet2.4_5.5.26.bb" rel=
=3D"noreferrer" target=3D"_blank">servlet2.4_5.5.26.bb</a><br>
+++ b/recipes-core/servlet-api/<a href=3D"http://servlet2.4_5.5.26.bb" rel=
=3D"noreferrer" target=3D"_blank">servlet2.4_5.5.26.bb</a><br>
@@ -39,5 +39,4 @@ do_compile() {<br>
=C2=A0 =C2=A0fastjar -C build -c -m src/etc/manifest -f ${JARFILENAME} .<br=
>
=C2=A0}<br>
<br>
-SRC_URI[md5sum] =3D &quot;642b6526354cb18c5b5d77ebef8109ae&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;ddc677d7391c438e6102d0b3e9653eaca661344e=
f74b0260c1f488340d660395&quot;<br>
diff --git a/recipes-core/xerces-j/<a href=3D"http://xerces-j_2.11.0.bb" re=
l=3D"noreferrer" target=3D"_blank">xerces-j_2.11.0.bb</a> b/recipes-core/xe=
rces-j/<a href=3D"http://xerces-j_2.11.0.bb" rel=3D"noreferrer" target=3D"_=
blank">xerces-j_2.11.0.bb</a><br>
index 45d3c43..56ffe97 100644<br>
--- a/recipes-core/xerces-j/<a href=3D"http://xerces-j_2.11.0.bb" rel=3D"no=
referrer" target=3D"_blank">xerces-j_2.11.0.bb</a><br>
+++ b/recipes-core/xerces-j/<a href=3D"http://xerces-j_2.11.0.bb" rel=3D"no=
referrer" target=3D"_blank">xerces-j_2.11.0.bb</a><br>
@@ -63,7 +63,6 @@ do_compile() {<br>
<br>
=C2=A0}<br>
<br>
-SRC_URI[md5sum] =3D &quot;d01fc11eacbe43b45681cb85ac112ebf&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;f59a5ef7b51bd883f2e9bda37a9360692e6c5e43=
9b98d9b6ac1953e1f98b0680&quot;<br>
<br>
=C2=A0BBCLASSEXTEND =3D &quot;native&quot;<br>
diff --git a/recipes-core/xml-commons/<a href=3D"http://jaxp1.3_1.4.01.bb" =
rel=3D"noreferrer" target=3D"_blank">jaxp1.3_1.4.01.bb</a> b/recipes-core/x=
ml-commons/<a href=3D"http://jaxp1.3_1.4.01.bb" rel=3D"noreferrer" target=
=3D"_blank">jaxp1.3_1.4.01.bb</a><br>
index 98cb077..7965bb8 100644<br>
--- a/recipes-core/xml-commons/<a href=3D"http://jaxp1.3_1.4.01.bb" rel=3D"=
noreferrer" target=3D"_blank">jaxp1.3_1.4.01.bb</a><br>
+++ b/recipes-core/xml-commons/<a href=3D"http://jaxp1.3_1.4.01.bb" rel=3D"=
noreferrer" target=3D"_blank">jaxp1.3_1.4.01.bb</a><br>
@@ -27,7 +27,6 @@ do_compile() {<br>
=C2=A0 =C2=A0fastjar cfm ${JARFILENAME} manifest.commons -C build .<br>
=C2=A0}<br>
<br>
-SRC_URI[md5sum] =3D &quot;2fea8e97a5d4d1a24bd05f5f62f3e04e&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;d34bd88dc89c5c1ed2545ec5c61e4606fc28beb2=
00a6fecf8c3ed17694181866&quot;<br>
<br>
=C2=A0BBCLASSEXTEND =3D &quot;native&quot;<br>
diff --git a/recipes-core/xml-commons/<a href=3D"http://jdom_1.1.3.bb" rel=
=3D"noreferrer" target=3D"_blank">jdom_1.1.3.bb</a> b/recipes-core/xml-comm=
ons/<a href=3D"http://jdom_1.1.3.bb" rel=3D"noreferrer" target=3D"_blank">j=
dom_1.1.3.bb</a><br>
index acd2ae1..c7b42f1 100644<br>
--- a/recipes-core/xml-commons/<a href=3D"http://jdom_1.1.3.bb" rel=3D"nore=
ferrer" target=3D"_blank">jdom_1.1.3.bb</a><br>
+++ b/recipes-core/xml-commons/<a href=3D"http://jdom_1.1.3.bb" rel=3D"nore=
ferrer" target=3D"_blank">jdom_1.1.3.bb</a><br>
@@ -9,7 +9,6 @@ HOMEPAGE =3D &quot;<a href=3D"http://jdom.org/" rel=3D"nore=
ferrer" target=3D"_blank">http://jdom.org/</a>&quot;<br>
=C2=A0DEPENDS =3D &quot;fastjar-native virtual/javac-native jaxen&quot;<br>
<br>
=C2=A0SRC_URI =3D &quot;<a href=3D"http://www.jdom.org/dist/source/archive/=
jdom-$%7BPV%7D.tar.gz" rel=3D"noreferrer" target=3D"_blank">http://www.jdom=
.org/dist/source/archive/jdom-${PV}.tar.gz</a>&quot;<br>
-SRC_URI[md5sum] =3D &quot;dc8391e84cfdb170fcd8279aa370019f&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;d471718c4ac7a1a2f10715b93cb3fcd2ecbab603=
84b73ad1c089712e47bd8d1f&quot;<br>
<br>
=C2=A0PACKAGE_ARCH =3D &quot;${TUNE_PKGARCH}&quot;<br>
diff --git a/recipes-core/xml-commons/<a href=3D"http://xml-commons-resolve=
r1.1_1.2.bb" rel=3D"noreferrer" target=3D"_blank">xml-commons-resolver1.1_1=
.2.bb</a> b/recipes-core/xml-commons/<a href=3D"http://xml-commons-resolver=
1.1_1.2.bb" rel=3D"noreferrer" target=3D"_blank">xml-commons-resolver1.1_1.=
2.bb</a><br>
index 42ce703..0fafcea 100644<br>
--- a/recipes-core/xml-commons/<a href=3D"http://xml-commons-resolver1.1_1.=
2.bb" rel=3D"noreferrer" target=3D"_blank">xml-commons-resolver1.1_1.2.bb</=
a><br>
+++ b/recipes-core/xml-commons/<a href=3D"http://xml-commons-resolver1.1_1.=
2.bb" rel=3D"noreferrer" target=3D"_blank">xml-commons-resolver1.1_1.2.bb</=
a><br>
@@ -36,7 +36,6 @@ do_compile() {<br>
=C2=A0 =C2=A0fastjar cfm ${JARFILENAME} src/manifest.resolver -C build=C2=
=A0 org<br>
=C2=A0}<br>
<br>
-SRC_URI[md5sum] =3D &quot;46d52acdb67ba60f0156043f30108766&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;55dbe7bd56452c175320ce9a97b752252c553742=
7221323c72e9b9c1ac221efe&quot;<br>
<br>
=C2=A0BBCLASSEXTEND =3D &quot;native&quot;<br>
diff --git a/recipes-core/xml-commons/<a href=3D"http://xpp2_2.1.10.bb" rel=
=3D"noreferrer" target=3D"_blank">xpp2_2.1.10.bb</a> b/recipes-core/xml-com=
mons/<a href=3D"http://xpp2_2.1.10.bb" rel=3D"noreferrer" target=3D"_blank"=
>xpp2_2.1.10.bb</a><br>
index a76cc4e..170f4ff 100644<br>
--- a/recipes-core/xml-commons/<a href=3D"http://xpp2_2.1.10.bb" rel=3D"nor=
eferrer" target=3D"_blank">xpp2_2.1.10.bb</a><br>
+++ b/recipes-core/xml-commons/<a href=3D"http://xpp2_2.1.10.bb" rel=3D"nor=
eferrer" target=3D"_blank">xpp2_2.1.10.bb</a><br>
@@ -30,5 +30,4 @@ do_compile() {<br>
=C2=A0 =C2=A0 =C2=A0fastjar -C build-oe -c -f ${JARFILENAME} .<br>
=C2=A0}<br>
<br>
-SRC_URI[md5sum] =3D &quot;865ca4e2496c215d301b57450137626f&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;ad82569b809e29c19b8223feaa12923f97bb4bbc=
942ff985857f9d853db489cf&quot;<br>
diff --git a/recipes-core/xml-commons/<a href=3D"http://xpp3_1.1.3.4.O.bb" =
rel=3D"noreferrer" target=3D"_blank">xpp3_1.1.3.4.O.bb</a> b/recipes-core/x=
ml-commons/<a href=3D"http://xpp3_1.1.3.4.O.bb" rel=3D"noreferrer" target=
=3D"_blank">xpp3_1.1.3.4.O.bb</a><br>
index 09ef1f1..ce344c4 100644<br>
--- a/recipes-core/xml-commons/<a href=3D"http://xpp3_1.1.3.4.O.bb" rel=3D"=
noreferrer" target=3D"_blank">xpp3_1.1.3.4.O.bb</a><br>
+++ b/recipes-core/xml-commons/<a href=3D"http://xpp3_1.1.3.4.O.bb" rel=3D"=
noreferrer" target=3D"_blank">xpp3_1.1.3.4.O.bb</a><br>
@@ -46,5 +46,4 @@ do_install:append() {<br>
=C2=A0FILES:libxpp3-xpath-java =3D &quot;${datadir}/java/xpp3-xpath*&quot;<=
br>
<br>
<br>
-SRC_URI[md5sum] =3D &quot;e1b6aeaad1cd06e64568aae1a507d5c6&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;404c0cd332f54ecf9807dc86d365c17dcffab669=
994c9dcbbad31fbc4b59f811&quot;<br>
diff --git a/recipes-extended/dbus/<a href=3D"http://dbus-java_2.7.bb" rel=
=3D"noreferrer" target=3D"_blank">dbus-java_2.7.bb</a> b/recipes-extended/d=
bus/<a href=3D"http://dbus-java_2.7.bb" rel=3D"noreferrer" target=3D"_blank=
">dbus-java_2.7.bb</a><br>
index 0e5ae92..fc42bcd 100644<br>
--- a/recipes-extended/dbus/<a href=3D"http://dbus-java_2.7.bb" rel=3D"nore=
ferrer" target=3D"_blank">dbus-java_2.7.bb</a><br>
+++ b/recipes-extended/dbus/<a href=3D"http://dbus-java_2.7.bb" rel=3D"nore=
ferrer" target=3D"_blank">dbus-java_2.7.bb</a><br>
@@ -18,7 +18,6 @@ PACKAGE_ARCH =3D &quot;${TUNE_PKGARCH}&quot;<br>
=C2=A0LIC_FILES_CHKSUM =3D &quot;file://COPYING;md5=3D72cc739fb93ae32741edb=
ae802490e92&quot;<br>
=C2=A0SRC_URI =3D &quot;<a href=3D"http://dbus.freedesktop.org/releases/dbu=
s-java/dbus-java-$%7BPV%7D.tar.gz" rel=3D"noreferrer" target=3D"_blank">htt=
p://dbus.freedesktop.org/releases/dbus-java/dbus-java-${PV}.tar.gz</a>&quot=
;<br>
<br>
-SRC_URI[md5sum] =3D &quot;8b8470db5cd657591bac245e3b6e18e4&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;be404ea36284d938646192d0ee42e14685306421=
7d4e3aaf89b56bd351ebca33&quot;<br>
<br>
=C2=A0S =3D &quot;${WORKDIR}/dbus-java-${PV}&quot;<br>
diff --git a/recipes-extended/hsqldb/<a href=3D"http://hsqldb_1.8.0.10.bb" =
rel=3D"noreferrer" target=3D"_blank">hsqldb_1.8.0.10.bb</a> b/recipes-exten=
ded/hsqldb/<a href=3D"http://hsqldb_1.8.0.10.bb" rel=3D"noreferrer" target=
=3D"_blank">hsqldb_1.8.0.10.bb</a><br>
index 6c34106..b1769f8 100644<br>
--- a/recipes-extended/hsqldb/<a href=3D"http://hsqldb_1.8.0.10.bb" rel=3D"=
noreferrer" target=3D"_blank">hsqldb_1.8.0.10.bb</a><br>
+++ b/recipes-extended/hsqldb/<a href=3D"http://hsqldb_1.8.0.10.bb" rel=3D"=
noreferrer" target=3D"_blank">hsqldb_1.8.0.10.bb</a><br>
@@ -36,6 +36,5 @@ do_compile() {<br>
=C2=A0 =C2=A0 =C2=A0fastjar -C classes -c -f ${JARFILENAME} .<br>
=C2=A0}<br>
<br>
-SRC_URI[md5sum] =3D &quot;17410483b5b5f267aa18b7e00b65e6e0&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;d30b13f4ba2e3b6a2d4f020c0dee0a9fb9fc6fbc=
c2d561f36b78da4bf3802370&quot;<br>
<br>
diff --git a/recipes-extended/rxtx/<a href=3D"http://rxtx_2.2.0.bb" rel=3D"=
noreferrer" target=3D"_blank">rxtx_2.2.0.bb</a> b/recipes-extended/rxtx/<a =
href=3D"http://rxtx_2.2.0.bb" rel=3D"noreferrer" target=3D"_blank">rxtx_2.2=
.0.bb</a><br>
index 27935bc..ade4b96 100644<br>
--- a/recipes-extended/rxtx/<a href=3D"http://rxtx_2.2.0.bb" rel=3D"norefer=
rer" target=3D"_blank">rxtx_2.2.0.bb</a><br>
+++ b/recipes-extended/rxtx/<a href=3D"http://rxtx_2.2.0.bb" rel=3D"norefer=
rer" target=3D"_blank">rxtx_2.2.0.bb</a><br>
@@ -22,7 +22,6 @@ SRC_URI =3D &quot;<a href=3D"http://rxtx.qbang.org/pub/rx=
tx/rxtx-2.2pre2.zip" rel=3D"noreferrer" target=3D"_blank">http://rxtx.qbang=
.org/pub/rxtx/rxtx-2.2pre2.zip</a> \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 file://0001-Support-Freescale-i.M=
X-serial-ports.patch \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 file://javapath.patch&quot;<br>
<br>
-SRC_URI[md5sum] =3D &quot;7eedb18e3f33a427e2b0e9be8ce3f94c&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;3c30373e760f444def3650c76c5a00ae12fb1d86=
0ec008750d084f4880495b03&quot;<br>
<br>
=C2=A0S =3D &quot;${WORKDIR}/rxtx-2.2pre2&quot;<br>
diff --git a/recipes-extended/xmlpull/<a href=3D"http://xmlpull_1.1.3.4c.bb=
" rel=3D"noreferrer" target=3D"_blank">xmlpull_1.1.3.4c.bb</a> b/recipes-ex=
tended/xmlpull/<a href=3D"http://xmlpull_1.1.3.4c.bb" rel=3D"noreferrer" ta=
rget=3D"_blank">xmlpull_1.1.3.4c.bb</a><br>
index 4f8c9f8..85e970c 100644<br>
--- a/recipes-extended/xmlpull/<a href=3D"http://xmlpull_1.1.3.4c.bb" rel=
=3D"noreferrer" target=3D"_blank">xmlpull_1.1.3.4c.bb</a><br>
+++ b/recipes-extended/xmlpull/<a href=3D"http://xmlpull_1.1.3.4c.bb" rel=
=3D"noreferrer" target=3D"_blank">xmlpull_1.1.3.4c.bb</a><br>
@@ -25,6 +25,5 @@ do_install() {<br>
=C2=A0 =C2=A0 =C2=A0cp build/lib/${PN}_1_1_3_4c.jar ${JAR}<br>
=C2=A0}<br>
<br>
-SRC_URI[md5sum] =3D &quot;34c8a093e5678dd633411dfea88f8558&quot;<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;e17aa1a26119966258a3656a262bbba0f0b036ee=
cb6d9bf192cf4b497686f4c3&quot;<br>
<br>
-- <br>
2.43.0<br>
<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#984): <a href=3D"https://lists.yoctoproject.org/g/yocto=
-patches/message/984" rel=3D"noreferrer" target=3D"_blank">https://lists.yo=
ctoproject.org/g/yocto-patches/message/984</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/110697255/924=
729" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/mt=
/110697255/924729</a><br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leav=
e/13169857/924729/1023951714/xyzzy" rel=3D"noreferrer" target=3D"_blank">ht=
tps://lists.yoctoproject.org/g/yocto-patches/leave/13169857/924729/10239517=
14/xyzzy</a> [<a href=3D"mailto:ticotimo@gmail.com" target=3D"_blank">ticot=
imo@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
</blockquote></div>

--000000000000e2cc25062c18f1c7--

