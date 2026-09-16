Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0482C982D2
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 22:30:52 +0000 (UTC)
Received: from mail-qk2-f36.google.com (mail-qk2-f36.google.com [74.125.230.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.27096.1789597848194371577
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 15:30:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=QnYvo1D7;
 spf=pass (domain: konsulko.com, ip: 74.125.230.228, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f36.google.com with SMTP id af79cd13be357-93910cadeb7so19070985a.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 15:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789597847; x=1790202647; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8SfJqpNNlZfm+F3fWHxrloIYqLX19PTFGzMoF+ExH0g=;
        b=QnYvo1D7z/1sCaiJ0euImvOgidQt7tKIFv07TdU3+kbAze+kSkCzBuH+xTtFJ9KH5W
         +zm+/RNPn3AHfuRJ/MBfJipO7msDgkJ182oEZasQm5W9zrnDI6Rm6nCzga+mR7AAdvqE
         xo+HMa0us+a8WBB5sGfb5EXV7KacIBr+vGXl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789597847; x=1790202647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8SfJqpNNlZfm+F3fWHxrloIYqLX19PTFGzMoF+ExH0g=;
        b=1Ac37aOSg2nzZ8lhy3ehqHiFhKcu1NuySxCPgh7P1BrdRSjWRUNUeuP5/dkytAflWW
         CqOIDX/GA6U6GSy2HYADTomBHgpeJ9TrFcV0T7xXYhyS5y3Pyg+qo3f7cmemGhUcBjMm
         cbqGALGUAE1CV1mf8PK2UOSv53ubVs1olIlyrEWN3017WOglqLqkLisjRqJ/VGlZFEjZ
         ynP9MvsZUSlcqSL9EMgYSCnCXLQK2tHHRJsecOsdrjSGfRRlh2xpSpTS4qb3xVJK80ZC
         //wrj+axeyFVn5JVZLAWXjOys0HcuDMzMoGac3DIihD+UPHcgcqhVDotN1uIX2EXylMm
         k4HA==
X-Gm-Message-State: AFuF++nYnVeXL/+y2FBnBuYTF2YibU5rQLKpTBA4WEsnQuCLk459sI9r
	wrQan5O8klvcbLrpOcZOhyyWPI0zW5lLKWOLovXYda29807WFiVOgQFDjPqXN3aDTN2uLqY1J7d
	vIyaA
X-Gm-Gg: AYBFou3bHGZSEPbqZMoofR3g8CVyc5qicQo22S+7kzA02ETcWFEetx2sVOtNJaNDB24
	N+BSetYWKi+MoZLWkSzuVi83rb6SsshIwb1XXGbUH1Ym3knM1rPDR1dLrWGOyfNs4/v0XbWZIgH
	7o2ffEUEJKEX+xfXYMK/wltNBy43RiiBIWRIA9WTMJeOvTd6PH8peGMzs4CTZEq8t0UGkjCy/gL
	1I5jsqJdyf4BOvBgolM3hNfb7GVuQDkkRRqtZoSgOknTtN5X++MYVU4D1ztY4PrwSBGjL2ThKIP
	WxYnLRDRDCqXIfOE05HtyWpnLVRr0+ffNuy89loJbI6KSPJPpdj+OMHf102bg9EVPH3OUHHnGXv
	LSRX6v9fmCbcvweLQOgVVswmjjUEG9AyETRGruKPST/2/QDH7H3RWrpwjkXj9UgmmhTuleZiMjd
	mkQhjFB9f268TECNjUOEbEc5C2X/357t/kJ72ilpc3mjn9IdexwI2ONDyg6t/8yyZFm2QO4yozL
	aNAxbB/VmacXJAum3pAJd/Agn6dNEAjztYW20pZLvq7xsdNYiz+LGy3KqsLtmuJ7fINFhYTSBPw
	ouBzNPL/9KPaUPN9i6+axCSFLT3SS8EMuYKu
X-Received: by 2002:a05:620a:170b:b0:93a:583:49db with SMTP id af79cd13be357-93bb79299b5mr830948285a.39.1789597845831;
        Wed, 16 Sep 2026 15:30:45 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b781d94c0sm310900685a.10.2026.09.16.15.30.43
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 15:30:44 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 15/24] krill: upgrade 0.12.3 -> 0.16.0
Date: Wed, 16 Sep 2026 18:30:09 -0400
Message-ID: <958edac22e9e2304f8719d9dee8d5a0612d82b8d.1789597604.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789597604.git.scott.murray@konsulko.com>
References: <cover.1789597604.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 22:30:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4892

Release notes:
https://github.com/NLnetLabs/krill/releases/tag/v0.13.0
https://github.com/NLnetLabs/krill/releases/tag/v0.13.1
https://github.com/NLnetLabs/krill/releases/tag/v0.14.0
https://github.com/NLnetLabs/krill/releases/tag/v0.14.1
https://github.com/NLnetLabs/krill/releases/tag/v0.14.2
https://github.com/NLnetLabs/krill/releases/tag/v0.14.3
https://github.com/NLnetLabs/krill/releases/tag/v0.14.4
https://github.com/NLnetLabs/krill/releases/tag/v0.14.5
https://github.com/NLnetLabs/krill/releases/tag/v0.14.6
https://github.com/NLnetLabs/krill/releases/tag/v0.15.0
https://github.com/NLnetLabs/krill/releases/tag/v0.15.1
https://github.com/NLnetLabs/krill/releases/tag/v0.16.0

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../files/0001-Disable-abort-on-panic.patch   |   24 +
 .../krill/files/panic_workaround.patch        |   16 -
 recipes-security/krill/krill-crates.inc       | 1332 ++++++++++-------
 .../{krill_0.12.3.bb => krill_0.16.0.bb}      |    8 +-
 4 files changed, 847 insertions(+), 533 deletions(-)
 create mode 100644 recipes-security/krill/files/0001-Disable-abort-on-panic.patch
 delete mode 100644 recipes-security/krill/files/panic_workaround.patch
 rename recipes-security/krill/{krill_0.12.3.bb => krill_0.16.0.bb} (89%)

diff --git a/recipes-security/krill/files/0001-Disable-abort-on-panic.patch b/recipes-security/krill/files/0001-Disable-abort-on-panic.patch
new file mode 100644
index 0000000..34943ee
--- /dev/null
+++ b/recipes-security/krill/files/0001-Disable-abort-on-panic.patch
@@ -0,0 +1,24 @@
+From 2ab05412b6c4abf21c1eec11fb62b28068e5ea81 Mon Sep 17 00:00:00 2001
+From: Armin Kuster <akuster808@gmail.com>
+Date: Tue, 27 Jul 2021 08:06:43 -0700
+Subject: [PATCH] Disable abort on panic
+
+Upstream-Status: Inappropriate [OE specific]
+Signed-off-by: Armin Kuster <akuster808@gmail.com>
+---
+ Cargo.toml | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/Cargo.toml b/Cargo.toml
+index 8e37e968..92e6fb9a 100644
+--- a/Cargo.toml
++++ b/Cargo.toml
+@@ -107,7 +107,7 @@ urlparse  = "0.7"
+ # Make sure that Krill crashes on panics, rather than losing threads and
+ # limping on in a bad state.
+ [profile.release]
+-panic = "abort"
++#panic = "abort"
+ 
+ # ------------------------------------------------------------------------------
+ # START DEBIAN PACKAGING
diff --git a/recipes-security/krill/files/panic_workaround.patch b/recipes-security/krill/files/panic_workaround.patch
deleted file mode 100644
index f63169f..0000000
--- a/recipes-security/krill/files/panic_workaround.patch
+++ /dev/null
@@ -1,16 +0,0 @@
-Upstream-Status: Inappropriate [OE specific]
-Signed-off-by: Armin Kuster <akuster808@gmail.com>
-
-Index: git/Cargo.toml
-===================================================================
---- git.orig/Cargo.toml
-+++ git/Cargo.toml
-@@ -91,7 +91,7 @@ hsm-tests-pkcs11 = [ "hsm" ]
- # Make sure that Krill crashes on panics, rather than losing threads and
- # limping on in a bad state.
- [profile.release]
--panic = "abort"
-+#panic = "abort"
- 
- [dev-dependencies]
- regex     = "1.5.5"
diff --git a/recipes-security/krill/krill-crates.inc b/recipes-security/krill/krill-crates.inc
index 85830ec..d0a3fcd 100644
--- a/recipes-security/krill/krill-crates.inc
+++ b/recipes-security/krill/krill-crates.inc
@@ -2,549 +2,855 @@
 
 # from Cargo.lock
 SRC_URI += " \
-    crate://crates.io/addr2line/0.17.0;name=addr2line-0.17.0 \
-    crate://crates.io/adler/1.0.2;name=adler-1.0.2 \
-    crate://crates.io/adler32/1.2.0;name=adler32-1.2.0 \
-    crate://crates.io/aho-corasick/0.7.18;name=aho-corasick-0.7.18 \
-    crate://crates.io/android_system_properties/0.1.5;name=android_system_properties-0.1.5 \
-    crate://crates.io/ansi_term/0.12.1;name=ansi_term-0.12.1 \
-    crate://crates.io/ascii/1.0.0;name=ascii-1.0.0 \
-    crate://crates.io/ascii-canvas/3.0.0;name=ascii-canvas-3.0.0 \
-    crate://crates.io/atty/0.2.14;name=atty-0.2.14 \
-    crate://crates.io/autocfg/1.1.0;name=autocfg-1.1.0 \
-    crate://crates.io/backoff/0.3.0;name=backoff-0.3.0 \
-    crate://crates.io/backtrace/0.3.66;name=backtrace-0.3.66 \
-    crate://crates.io/base64/0.13.0;name=base64-0.13.0 \
-    crate://crates.io/basic-cookies/0.1.4;name=basic-cookies-0.1.4 \
-    crate://crates.io/bcder/0.7.0;name=bcder-0.7.0 \
-    crate://crates.io/bit-set/0.5.2;name=bit-set-0.5.2 \
-    crate://crates.io/bit-vec/0.6.3;name=bit-vec-0.6.3 \
-    crate://crates.io/bitflags/1.3.2;name=bitflags-1.3.2 \
-    crate://crates.io/block-buffer/0.9.0;name=block-buffer-0.9.0 \
-    crate://crates.io/block-buffer/0.10.2;name=block-buffer-0.10.2 \
-    crate://crates.io/bumpalo/3.10.0;name=bumpalo-3.10.0 \
-    crate://crates.io/bytes/1.1.0;name=bytes-1.1.0 \
-    crate://crates.io/cc/1.0.73;name=cc-1.0.73 \
-    crate://crates.io/cfg-if/1.0.0;name=cfg-if-1.0.0 \
-    crate://crates.io/chrono/0.4.22;name=chrono-0.4.22 \
-    crate://crates.io/chunked_transfer/1.4.0;name=chunked_transfer-1.4.0 \
-    crate://crates.io/cipher/0.2.5;name=cipher-0.2.5 \
-    crate://crates.io/clap/2.34.0;name=clap-2.34.0 \
-    crate://crates.io/codespan-reporting/0.11.1;name=codespan-reporting-0.11.1 \
-    crate://crates.io/core-foundation/0.9.3;name=core-foundation-0.9.3 \
-    crate://crates.io/core-foundation-sys/0.8.3;name=core-foundation-sys-0.8.3 \
-    crate://crates.io/cpufeatures/0.2.2;name=cpufeatures-0.2.2 \
-    crate://crates.io/crc32fast/1.3.2;name=crc32fast-1.3.2 \
-    crate://crates.io/crunchy/0.2.2;name=crunchy-0.2.2 \
-    crate://crates.io/crypto-common/0.1.6;name=crypto-common-0.1.6 \
-    crate://crates.io/crypto-mac/0.10.1;name=crypto-mac-0.10.1 \
-    crate://crates.io/cryptoki/0.3.0;name=cryptoki-0.3.0 \
-    crate://crates.io/cryptoki-sys/0.1.4;name=cryptoki-sys-0.1.4 \
-    crate://crates.io/ctrlc/3.2.2;name=ctrlc-3.2.2 \
-    crate://crates.io/cxx/1.0.79;name=cxx-1.0.79 \
-    crate://crates.io/cxx-build/1.0.79;name=cxx-build-1.0.79 \
-    crate://crates.io/cxxbridge-flags/1.0.79;name=cxxbridge-flags-1.0.79 \
-    crate://crates.io/cxxbridge-macro/1.0.79;name=cxxbridge-macro-1.0.79 \
-    crate://crates.io/derivative/2.2.0;name=derivative-2.2.0 \
-    crate://crates.io/deunicode/0.4.3;name=deunicode-0.4.3 \
-    crate://crates.io/diff/0.1.13;name=diff-0.1.13 \
-    crate://crates.io/digest/0.9.0;name=digest-0.9.0 \
-    crate://crates.io/digest/0.10.3;name=digest-0.10.3 \
-    crate://crates.io/dirs-next/2.0.0;name=dirs-next-2.0.0 \
-    crate://crates.io/dirs-sys-next/0.1.2;name=dirs-sys-next-0.1.2 \
-    crate://crates.io/either/1.7.0;name=either-1.7.0 \
-    crate://crates.io/ena/0.14.0;name=ena-0.14.0 \
-    crate://crates.io/encoding_rs/0.8.31;name=encoding_rs-0.8.31 \
-    crate://crates.io/enum-display-derive/0.1.1;name=enum-display-derive-0.1.1 \
-    crate://crates.io/enum-flags/0.1.8;name=enum-flags-0.1.8 \
-    crate://crates.io/error-chain/0.11.0;name=error-chain-0.11.0 \
-    crate://crates.io/fastrand/1.7.0;name=fastrand-1.7.0 \
-    crate://crates.io/fern/0.5.9;name=fern-0.5.9 \
-    crate://crates.io/fixedbitset/0.4.2;name=fixedbitset-0.4.2 \
-    crate://crates.io/fnv/1.0.7;name=fnv-1.0.7 \
-    crate://crates.io/foreign-types/0.3.2;name=foreign-types-0.3.2 \
-    crate://crates.io/foreign-types-shared/0.1.1;name=foreign-types-shared-0.1.1 \
-    crate://crates.io/form_urlencoded/1.0.1;name=form_urlencoded-1.0.1 \
-    crate://crates.io/fslock/0.2.1;name=fslock-0.2.1 \
-    crate://crates.io/futures/0.3.21;name=futures-0.3.21 \
-    crate://crates.io/futures-channel/0.3.21;name=futures-channel-0.3.21 \
-    crate://crates.io/futures-core/0.3.21;name=futures-core-0.3.21 \
-    crate://crates.io/futures-executor/0.3.21;name=futures-executor-0.3.21 \
-    crate://crates.io/futures-io/0.3.21;name=futures-io-0.3.21 \
-    crate://crates.io/futures-macro/0.3.21;name=futures-macro-0.3.21 \
-    crate://crates.io/futures-sink/0.3.21;name=futures-sink-0.3.21 \
-    crate://crates.io/futures-task/0.3.21;name=futures-task-0.3.21 \
-    crate://crates.io/futures-util/0.3.21;name=futures-util-0.3.21 \
-    crate://crates.io/generic-array/0.14.5;name=generic-array-0.14.5 \
-    crate://crates.io/getrandom/0.2.7;name=getrandom-0.2.7 \
-    crate://crates.io/gimli/0.26.2;name=gimli-0.26.2 \
-    crate://crates.io/h2/0.3.13;name=h2-0.3.13 \
-    crate://crates.io/hashbrown/0.12.3;name=hashbrown-0.12.3 \
-    crate://crates.io/hermit-abi/0.1.19;name=hermit-abi-0.1.19 \
-    crate://crates.io/hex/0.4.3;name=hex-0.4.3 \
-    crate://crates.io/hmac/0.10.1;name=hmac-0.10.1 \
-    crate://crates.io/http/0.2.8;name=http-0.2.8 \
-    crate://crates.io/http-body/0.4.5;name=http-body-0.4.5 \
-    crate://crates.io/httparse/1.7.1;name=httparse-1.7.1 \
-    crate://crates.io/httpdate/1.0.2;name=httpdate-1.0.2 \
-    crate://crates.io/hyper/0.14.20;name=hyper-0.14.20 \
-    crate://crates.io/hyper-tls/0.5.0;name=hyper-tls-0.5.0 \
-    crate://crates.io/iana-time-zone/0.1.51;name=iana-time-zone-0.1.51 \
-    crate://crates.io/iana-time-zone-haiku/0.1.1;name=iana-time-zone-haiku-0.1.1 \
-    crate://crates.io/idna/0.2.3;name=idna-0.2.3 \
-    crate://crates.io/impl-trait-for-tuples/0.2.2;name=impl-trait-for-tuples-0.2.2 \
-    crate://crates.io/indexmap/1.9.1;name=indexmap-1.9.1 \
-    crate://crates.io/instant/0.1.12;name=instant-0.1.12 \
-    crate://crates.io/intervaltree/0.2.7;name=intervaltree-0.2.7 \
-    crate://crates.io/ipnet/2.5.0;name=ipnet-2.5.0 \
-    crate://crates.io/itertools/0.10.3;name=itertools-0.10.3 \
-    crate://crates.io/itoa/1.0.2;name=itoa-1.0.2 \
-    crate://crates.io/jmespatch/0.3.0;name=jmespatch-0.3.0 \
-    crate://crates.io/js-sys/0.3.58;name=js-sys-0.3.58 \
-    crate://crates.io/kmip-protocol/0.4.2;name=kmip-protocol-0.4.2 \
-    crate://crates.io/kmip-ttlv/0.3.3;name=kmip-ttlv-0.3.3 \
-    crate://crates.io/lalrpop/0.19.8;name=lalrpop-0.19.8 \
-    crate://crates.io/lalrpop-util/0.19.8;name=lalrpop-util-0.19.8 \
-    crate://crates.io/lazy_static/1.4.0;name=lazy_static-1.4.0 \
-    crate://crates.io/libc/0.2.126;name=libc-0.2.126 \
-    crate://crates.io/libflate/1.2.0;name=libflate-1.2.0 \
-    crate://crates.io/libflate_lz77/1.1.0;name=libflate_lz77-1.1.0 \
-    crate://crates.io/libloading/0.7.3;name=libloading-0.7.3 \
-    crate://crates.io/link-cplusplus/1.0.7;name=link-cplusplus-1.0.7 \
-    crate://crates.io/lock_api/0.4.7;name=lock_api-0.4.7 \
-    crate://crates.io/log/0.4.17;name=log-0.4.17 \
-    crate://crates.io/maplit/1.0.2;name=maplit-1.0.2 \
-    crate://crates.io/matchers/0.0.1;name=matchers-0.0.1 \
-    crate://crates.io/matches/0.1.9;name=matches-0.1.9 \
-    crate://crates.io/maybe-async/0.2.6;name=maybe-async-0.2.6 \
-    crate://crates.io/memchr/2.5.0;name=memchr-2.5.0 \
-    crate://crates.io/mime/0.3.16;name=mime-0.3.16 \
-    crate://crates.io/miniz_oxide/0.5.3;name=miniz_oxide-0.5.3 \
-    crate://crates.io/mio/0.8.4;name=mio-0.8.4 \
-    crate://crates.io/native-tls/0.2.10;name=native-tls-0.2.10 \
-    crate://crates.io/new_debug_unreachable/1.0.4;name=new_debug_unreachable-1.0.4 \
-    crate://crates.io/nix/0.24.2;name=nix-0.24.2 \
-    crate://crates.io/num-bigint/0.4.3;name=num-bigint-0.4.3 \
-    crate://crates.io/num-integer/0.1.45;name=num-integer-0.1.45 \
-    crate://crates.io/num-traits/0.2.15;name=num-traits-0.2.15 \
-    crate://crates.io/num_cpus/1.13.1;name=num_cpus-1.13.1 \
-    crate://crates.io/oauth2/4.2.3;name=oauth2-4.2.3 \
-    crate://crates.io/object/0.29.0;name=object-0.29.0 \
-    crate://crates.io/once_cell/1.13.0;name=once_cell-1.13.0 \
-    crate://crates.io/opaque-debug/0.3.0;name=opaque-debug-0.3.0 \
-    crate://crates.io/openidconnect/2.3.2;name=openidconnect-2.3.2 \
-    crate://crates.io/openssl/0.10.41;name=openssl-0.10.41 \
-    crate://crates.io/openssl-macros/0.1.0;name=openssl-macros-0.1.0 \
-    crate://crates.io/openssl-probe/0.1.5;name=openssl-probe-0.1.5 \
-    crate://crates.io/openssl-src/111.25.0+1.1.1t;name=openssl-src-111.25.0+1.1.1t \
-    crate://crates.io/openssl-sys/0.9.75;name=openssl-sys-0.9.75 \
-    crate://crates.io/ordered-float/2.10.0;name=ordered-float-2.10.0 \
-    crate://crates.io/oso/0.12.4;name=oso-0.12.4 \
-    crate://crates.io/parking_lot/0.12.1;name=parking_lot-0.12.1 \
-    crate://crates.io/parking_lot_core/0.9.3;name=parking_lot_core-0.9.3 \
-    crate://crates.io/pbkdf2/0.7.5;name=pbkdf2-0.7.5 \
-    crate://crates.io/percent-encoding/2.1.0;name=percent-encoding-2.1.0 \
-    crate://crates.io/petgraph/0.6.2;name=petgraph-0.6.2 \
-    crate://crates.io/phf_shared/0.10.0;name=phf_shared-0.10.0 \
-    crate://crates.io/pico-args/0.4.2;name=pico-args-0.4.2 \
-    crate://crates.io/pin-project-lite/0.2.9;name=pin-project-lite-0.2.9 \
-    crate://crates.io/pin-utils/0.1.0;name=pin-utils-0.1.0 \
-    crate://crates.io/pkg-config/0.3.25;name=pkg-config-0.3.25 \
-    crate://crates.io/polar-core/0.12.4;name=polar-core-0.12.4 \
-    crate://crates.io/ppv-lite86/0.2.16;name=ppv-lite86-0.2.16 \
-    crate://crates.io/precomputed-hash/0.1.1;name=precomputed-hash-0.1.1 \
-    crate://crates.io/priority-queue/1.2.2;name=priority-queue-1.2.2 \
-    crate://crates.io/proc-macro2/1.0.40;name=proc-macro2-1.0.40 \
-    crate://crates.io/quick-xml/0.23.0;name=quick-xml-0.23.0 \
-    crate://crates.io/quote/1.0.20;name=quote-1.0.20 \
-    crate://crates.io/r2d2/0.8.10;name=r2d2-0.8.10 \
-    crate://crates.io/rand/0.8.5;name=rand-0.8.5 \
-    crate://crates.io/rand_chacha/0.3.1;name=rand_chacha-0.3.1 \
-    crate://crates.io/rand_core/0.6.3;name=rand_core-0.6.3 \
-    crate://crates.io/redox_syscall/0.2.13;name=redox_syscall-0.2.13 \
-    crate://crates.io/redox_users/0.4.3;name=redox_users-0.4.3 \
-    crate://crates.io/regex/1.6.0;name=regex-1.6.0 \
-    crate://crates.io/regex-automata/0.1.10;name=regex-automata-0.1.10 \
-    crate://crates.io/regex-syntax/0.6.27;name=regex-syntax-0.6.27 \
-    crate://crates.io/remove_dir_all/0.5.3;name=remove_dir_all-0.5.3 \
-    crate://crates.io/reqwest/0.11.11;name=reqwest-0.11.11 \
-    crate://crates.io/ring/0.16.20;name=ring-0.16.20 \
-    crate://crates.io/rle-decode-fast/1.0.3;name=rle-decode-fast-1.0.3 \
-    crate://crates.io/routecore/0.2.0;name=routecore-0.2.0 \
-    crate://crates.io/rpassword/5.0.1;name=rpassword-5.0.1 \
-    crate://crates.io/rpki/0.15.8;name=rpki-0.15.8 \
-    crate://crates.io/rustc-demangle/0.1.21;name=rustc-demangle-0.1.21 \
-    crate://crates.io/rustc_version/0.4.0;name=rustc_version-0.4.0 \
-    crate://crates.io/rustls/0.19.1;name=rustls-0.19.1 \
-    crate://crates.io/rustversion/1.0.8;name=rustversion-1.0.8 \
-    crate://crates.io/ryu/1.0.10;name=ryu-1.0.10 \
-    crate://crates.io/salsa20/0.7.2;name=salsa20-0.7.2 \
-    crate://crates.io/schannel/0.1.20;name=schannel-0.1.20 \
-    crate://crates.io/scheduled-thread-pool/0.2.6;name=scheduled-thread-pool-0.2.6 \
-    crate://crates.io/scopeguard/1.1.0;name=scopeguard-1.1.0 \
-    crate://crates.io/scratch/1.0.2;name=scratch-1.0.2 \
-    crate://crates.io/scrypt/0.6.5;name=scrypt-0.6.5 \
-    crate://crates.io/sct/0.6.1;name=sct-0.6.1 \
-    crate://crates.io/security-framework/2.6.1;name=security-framework-2.6.1 \
-    crate://crates.io/security-framework-sys/2.6.1;name=security-framework-sys-2.6.1 \
-    crate://crates.io/semver/1.0.12;name=semver-1.0.12 \
-    crate://crates.io/serde/1.0.139;name=serde-1.0.139 \
-    crate://crates.io/serde-value/0.7.0;name=serde-value-0.7.0 \
-    crate://crates.io/serde_bytes/0.11.6;name=serde_bytes-0.11.6 \
-    crate://crates.io/serde_derive/1.0.139;name=serde_derive-1.0.139 \
-    crate://crates.io/serde_json/1.0.82;name=serde_json-1.0.82 \
-    crate://crates.io/serde_path_to_error/0.1.7;name=serde_path_to_error-0.1.7 \
-    crate://crates.io/serde_urlencoded/0.7.1;name=serde_urlencoded-0.7.1 \
-    crate://crates.io/sha2/0.9.9;name=sha2-0.9.9 \
-    crate://crates.io/sha2/0.10.2;name=sha2-0.10.2 \
-    crate://crates.io/sharded-slab/0.1.4;name=sharded-slab-0.1.4 \
-    crate://crates.io/signal-hook-registry/1.4.0;name=signal-hook-registry-1.4.0 \
-    crate://crates.io/siphasher/0.3.10;name=siphasher-0.3.10 \
-    crate://crates.io/slab/0.4.6;name=slab-0.4.6 \
-    crate://crates.io/slug/0.1.4;name=slug-0.1.4 \
-    crate://crates.io/smallvec/1.9.0;name=smallvec-1.9.0 \
-    crate://crates.io/socket2/0.4.4;name=socket2-0.4.4 \
-    crate://crates.io/spin/0.5.2;name=spin-0.5.2 \
-    crate://crates.io/string_cache/0.8.4;name=string_cache-0.8.4 \
-    crate://crates.io/strsim/0.8.0;name=strsim-0.8.0 \
-    crate://crates.io/subtle/2.4.1;name=subtle-2.4.1 \
-    crate://crates.io/syn/1.0.98;name=syn-1.0.98 \
-    crate://crates.io/syslog/4.0.1;name=syslog-4.0.1 \
-    crate://crates.io/target-lexicon/0.12.4;name=target-lexicon-0.12.4 \
-    crate://crates.io/tempfile/3.3.0;name=tempfile-3.3.0 \
-    crate://crates.io/term/0.7.0;name=term-0.7.0 \
-    crate://crates.io/termcolor/1.1.3;name=termcolor-1.1.3 \
-    crate://crates.io/textwrap/0.11.0;name=textwrap-0.11.0 \
-    crate://crates.io/thiserror/1.0.31;name=thiserror-1.0.31 \
-    crate://crates.io/thiserror-impl/1.0.31;name=thiserror-impl-1.0.31 \
-    crate://crates.io/thread_local/1.1.4;name=thread_local-1.1.4 \
-    crate://crates.io/time/0.1.44;name=time-0.1.44 \
-    crate://crates.io/tiny-keccak/2.0.2;name=tiny-keccak-2.0.2 \
-    crate://crates.io/tiny_http/0.8.2;name=tiny_http-0.8.2 \
-    crate://crates.io/tinyvec/1.6.0;name=tinyvec-1.6.0 \
-    crate://crates.io/tinyvec_macros/0.1.0;name=tinyvec_macros-0.1.0 \
-    crate://crates.io/tokio/1.20.4;name=tokio-1.20.4 \
-    crate://crates.io/tokio-macros/1.8.0;name=tokio-macros-1.8.0 \
-    crate://crates.io/tokio-native-tls/0.3.0;name=tokio-native-tls-0.3.0 \
-    crate://crates.io/tokio-rustls/0.22.0;name=tokio-rustls-0.22.0 \
-    crate://crates.io/tokio-util/0.7.3;name=tokio-util-0.7.3 \
-    crate://crates.io/toml/0.5.9;name=toml-0.5.9 \
-    crate://crates.io/tower-service/0.3.2;name=tower-service-0.3.2 \
-    crate://crates.io/tracing/0.1.35;name=tracing-0.1.35 \
-    crate://crates.io/tracing-attributes/0.1.22;name=tracing-attributes-0.1.22 \
-    crate://crates.io/tracing-core/0.1.28;name=tracing-core-0.1.28 \
-    crate://crates.io/tracing-log/0.1.3;name=tracing-log-0.1.3 \
-    crate://crates.io/tracing-serde/0.1.3;name=tracing-serde-0.1.3 \
-    crate://crates.io/tracing-subscriber/0.2.25;name=tracing-subscriber-0.2.25 \
-    crate://crates.io/trait-set/0.2.0;name=trait-set-0.2.0 \
-    crate://crates.io/try-lock/0.2.3;name=try-lock-0.2.3 \
-    crate://crates.io/typenum/1.15.0;name=typenum-1.15.0 \
-    crate://crates.io/unicode-bidi/0.3.8;name=unicode-bidi-0.3.8 \
-    crate://crates.io/unicode-ident/1.0.2;name=unicode-ident-1.0.2 \
-    crate://crates.io/unicode-normalization/0.1.21;name=unicode-normalization-0.1.21 \
-    crate://crates.io/unicode-width/0.1.9;name=unicode-width-0.1.9 \
-    crate://crates.io/unicode-xid/0.2.3;name=unicode-xid-0.2.3 \
-    crate://crates.io/untrusted/0.7.1;name=untrusted-0.7.1 \
-    crate://crates.io/url/2.2.2;name=url-2.2.2 \
-    crate://crates.io/urlparse/0.7.3;name=urlparse-0.7.3 \
-    crate://crates.io/uuid/1.1.2;name=uuid-1.1.2 \
-    crate://crates.io/valuable/0.1.0;name=valuable-0.1.0 \
-    crate://crates.io/vcpkg/0.2.15;name=vcpkg-0.2.15 \
-    crate://crates.io/vec_map/0.8.2;name=vec_map-0.8.2 \
-    crate://crates.io/version_check/0.9.4;name=version_check-0.9.4 \
-    crate://crates.io/want/0.3.0;name=want-0.3.0 \
-    crate://crates.io/wasi/0.10.0+wasi-snapshot-preview1;name=wasi-0.10.0+wasi-snapshot-preview1 \
-    crate://crates.io/wasi/0.11.0+wasi-snapshot-preview1;name=wasi-0.11.0+wasi-snapshot-preview1 \
-    crate://crates.io/wasm-bindgen/0.2.81;name=wasm-bindgen-0.2.81 \
-    crate://crates.io/wasm-bindgen-backend/0.2.81;name=wasm-bindgen-backend-0.2.81 \
-    crate://crates.io/wasm-bindgen-futures/0.4.31;name=wasm-bindgen-futures-0.4.31 \
-    crate://crates.io/wasm-bindgen-macro/0.2.81;name=wasm-bindgen-macro-0.2.81 \
-    crate://crates.io/wasm-bindgen-macro-support/0.2.81;name=wasm-bindgen-macro-support-0.2.81 \
-    crate://crates.io/wasm-bindgen-shared/0.2.81;name=wasm-bindgen-shared-0.2.81 \
-    crate://crates.io/web-sys/0.3.58;name=web-sys-0.3.58 \
-    crate://crates.io/webpki/0.21.4;name=webpki-0.21.4 \
-    crate://crates.io/winapi/0.3.9;name=winapi-0.3.9 \
-    crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0;name=winapi-i686-pc-windows-gnu-0.4.0 \
-    crate://crates.io/winapi-util/0.1.5;name=winapi-util-0.1.5 \
-    crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0;name=winapi-x86_64-pc-windows-gnu-0.4.0 \
-    crate://crates.io/windows-sys/0.36.1;name=windows-sys-0.36.1 \
-    crate://crates.io/windows_aarch64_msvc/0.36.1;name=windows_aarch64_msvc-0.36.1 \
-    crate://crates.io/windows_i686_gnu/0.36.1;name=windows_i686_gnu-0.36.1 \
-    crate://crates.io/windows_i686_msvc/0.36.1;name=windows_i686_msvc-0.36.1 \
-    crate://crates.io/windows_x86_64_gnu/0.36.1;name=windows_x86_64_gnu-0.36.1 \
-    crate://crates.io/windows_x86_64_msvc/0.36.1;name=windows_x86_64_msvc-0.36.1 \
-    crate://crates.io/winreg/0.10.1;name=winreg-0.10.1 \
+    crate://crates.io/adler32/1.2.0 \
+    crate://crates.io/aho-corasick/1.1.4 \
+    crate://crates.io/allocator-api2/0.2.21 \
+    crate://crates.io/android_system_properties/0.1.5 \
+    crate://crates.io/anstream/0.6.21 \
+    crate://crates.io/anstyle/1.0.13 \
+    crate://crates.io/anstyle-parse/0.2.7 \
+    crate://crates.io/anstyle-query/1.1.5 \
+    crate://crates.io/anstyle-wincon/3.0.11 \
+    crate://crates.io/anyhow/1.0.101 \
+    crate://crates.io/arc-swap/1.8.2 \
+    crate://crates.io/ascii-canvas/3.0.0 \
+    crate://crates.io/atomic-waker/1.1.2 \
+    crate://crates.io/autocfg/1.5.0 \
+    crate://crates.io/aws-lc-rs/1.15.4 \
+    crate://crates.io/aws-lc-sys/0.37.1 \
+    crate://crates.io/backoff/0.4.0 \
+    crate://crates.io/base16ct/0.2.0 \
+    crate://crates.io/base64/0.21.7 \
+    crate://crates.io/base64/0.22.1 \
+    crate://crates.io/base64ct/1.8.3 \
+    crate://crates.io/basic-cookies/0.1.5 \
+    crate://crates.io/bcder/0.7.6 \
+    crate://crates.io/bit-set/0.5.3 \
+    crate://crates.io/bit-vec/0.6.3 \
+    crate://crates.io/bitflags/2.11.0 \
+    crate://crates.io/block-buffer/0.10.4 \
+    crate://crates.io/bumpalo/3.19.1 \
+    crate://crates.io/bytes/1.11.1 \
+    crate://crates.io/cc/1.2.56 \
+    crate://crates.io/cesu8/1.1.0 \
+    crate://crates.io/cfg-if/1.0.4 \
+    crate://crates.io/cfg_aliases/0.2.1 \
+    crate://crates.io/chacha20/0.10.0 \
+    crate://crates.io/chrono/0.4.43 \
+    crate://crates.io/cipher/0.4.4 \
+    crate://crates.io/clap/4.5.59 \
+    crate://crates.io/clap_builder/4.5.59 \
+    crate://crates.io/clap_derive/4.5.55 \
+    crate://crates.io/clap_lex/1.0.0 \
+    crate://crates.io/cmake/0.1.57 \
+    crate://crates.io/colorchoice/1.0.4 \
+    crate://crates.io/combine/4.6.7 \
+    crate://crates.io/const-oid/0.9.6 \
+    crate://crates.io/core-foundation/0.9.4 \
+    crate://crates.io/core-foundation/0.10.1 \
+    crate://crates.io/core-foundation-sys/0.8.7 \
+    crate://crates.io/core2/0.4.0 \
+    crate://crates.io/cpufeatures/0.2.17 \
+    crate://crates.io/cpufeatures/0.3.0 \
+    crate://crates.io/crc32fast/1.5.0 \
+    crate://crates.io/crunchy/0.2.4 \
+    crate://crates.io/crypto-bigint/0.5.5 \
+    crate://crates.io/crypto-common/0.1.7 \
+    crate://crates.io/cryptoki/0.12.0 \
+    crate://crates.io/cryptoki-sys/0.5.0 \
+    crate://crates.io/curve25519-dalek/4.1.3 \
+    crate://crates.io/curve25519-dalek-derive/0.1.1 \
+    crate://crates.io/darling/0.21.3 \
+    crate://crates.io/darling_core/0.21.3 \
+    crate://crates.io/darling_macro/0.21.3 \
+    crate://crates.io/dary_heap/0.3.8 \
+    crate://crates.io/der/0.7.10 \
+    crate://crates.io/deranged/0.5.6 \
+    crate://crates.io/digest/0.10.7 \
+    crate://crates.io/dirs-next/2.0.0 \
+    crate://crates.io/dirs-sys-next/0.1.2 \
+    crate://crates.io/displaydoc/0.2.5 \
+    crate://crates.io/dunce/1.0.5 \
+    crate://crates.io/dyn-clone/1.0.20 \
+    crate://crates.io/ecdsa/0.16.9 \
+    crate://crates.io/ed25519/2.2.3 \
+    crate://crates.io/ed25519-dalek/2.2.0 \
+    crate://crates.io/either/1.15.0 \
+    crate://crates.io/elliptic-curve/0.13.8 \
+    crate://crates.io/ena/0.14.4 \
+    crate://crates.io/encoding_rs/0.8.35 \
+    crate://crates.io/enum-display-derive/0.1.1 \
+    crate://crates.io/enum-flags/0.1.8 \
+    crate://crates.io/equivalent/1.0.2 \
+    crate://crates.io/errno/0.3.14 \
+    crate://crates.io/fastrand/2.3.0 \
+    crate://crates.io/fd-lock/4.0.4 \
+    crate://crates.io/fern/0.7.1 \
+    crate://crates.io/ff/0.13.1 \
+    crate://crates.io/fiat-crypto/0.2.9 \
+    crate://crates.io/filetime/0.2.27 \
+    crate://crates.io/find-msvc-tools/0.1.9 \
+    crate://crates.io/fixedbitset/0.4.2 \
+    crate://crates.io/fnv/1.0.7 \
+    crate://crates.io/foldhash/0.1.5 \
+    crate://crates.io/foldhash/0.2.0 \
+    crate://crates.io/foreign-types/0.3.2 \
+    crate://crates.io/foreign-types-shared/0.1.1 \
+    crate://crates.io/form_urlencoded/1.2.2 \
+    crate://crates.io/fs_extra/1.3.0 \
+    crate://crates.io/futures-channel/0.3.32 \
+    crate://crates.io/futures-core/0.3.32 \
+    crate://crates.io/futures-macro/0.3.32 \
+    crate://crates.io/futures-sink/0.3.32 \
+    crate://crates.io/futures-task/0.3.32 \
+    crate://crates.io/futures-util/0.3.32 \
+    crate://crates.io/generic-array/0.14.7 \
+    crate://crates.io/getrandom/0.2.17 \
+    crate://crates.io/getrandom/0.3.4 \
+    crate://crates.io/getrandom/0.4.1 \
+    crate://crates.io/group/0.13.0 \
+    crate://crates.io/h2/0.4.13 \
+    crate://crates.io/hashbrown/0.12.3 \
+    crate://crates.io/hashbrown/0.15.5 \
+    crate://crates.io/hashbrown/0.16.1 \
+    crate://crates.io/heck/0.5.0 \
+    crate://crates.io/hermit-abi/0.5.2 \
+    crate://crates.io/hex/0.4.3 \
+    crate://crates.io/hkdf/0.12.4 \
+    crate://crates.io/hmac/0.12.1 \
+    crate://crates.io/hostname/0.4.2 \
+    crate://crates.io/http/1.4.0 \
+    crate://crates.io/http-body/1.0.1 \
+    crate://crates.io/http-body-util/0.1.3 \
+    crate://crates.io/httparse/1.10.1 \
+    crate://crates.io/httpdate/1.0.3 \
+    crate://crates.io/hyper/1.8.1 \
+    crate://crates.io/hyper-rustls/0.27.7 \
+    crate://crates.io/hyper-util/0.1.20 \
+    crate://crates.io/iana-time-zone/0.1.65 \
+    crate://crates.io/iana-time-zone-haiku/0.1.2 \
+    crate://crates.io/icu_collections/2.1.1 \
+    crate://crates.io/icu_locale_core/2.1.1 \
+    crate://crates.io/icu_normalizer/2.1.1 \
+    crate://crates.io/icu_normalizer_data/2.1.1 \
+    crate://crates.io/icu_properties/2.1.2 \
+    crate://crates.io/icu_properties_data/2.1.2 \
+    crate://crates.io/icu_provider/2.1.1 \
+    crate://crates.io/id-arena/2.3.0 \
+    crate://crates.io/ident_case/1.0.1 \
+    crate://crates.io/idna/1.1.0 \
+    crate://crates.io/idna_adapter/1.2.1 \
+    crate://crates.io/indexmap/1.9.3 \
+    crate://crates.io/indexmap/2.13.0 \
+    crate://crates.io/inout/0.1.4 \
+    crate://crates.io/instant/0.1.13 \
+    crate://crates.io/intervaltree/0.2.7 \
+    crate://crates.io/ipnet/2.11.0 \
+    crate://crates.io/iri-string/0.7.10 \
+    crate://crates.io/is-terminal/0.4.17 \
+    crate://crates.io/is_terminal_polyfill/1.70.2 \
+    crate://crates.io/itertools/0.10.5 \
+    crate://crates.io/itertools/0.11.0 \
+    crate://crates.io/itoa/1.0.17 \
+    crate://crates.io/jni/0.21.1 \
+    crate://crates.io/jni-sys/0.3.0 \
+    crate://crates.io/jobserver/0.1.34 \
+    crate://crates.io/js-sys/0.3.85 \
+    crate://crates.io/kmip-protocol/0.4.3 \
+    crate://crates.io/kmip-ttlv/0.3.5 \
+    crate://crates.io/lalrpop/0.20.2 \
+    crate://crates.io/lalrpop-util/0.20.2 \
+    crate://crates.io/lazy_static/1.5.0 \
+    crate://crates.io/leb128fmt/0.1.0 \
+    crate://crates.io/libc/0.2.180 \
+    crate://crates.io/libflate/2.2.1 \
+    crate://crates.io/libflate_lz77/2.2.0 \
+    crate://crates.io/libloading/0.8.9 \
+    crate://crates.io/libm/0.2.16 \
+    crate://crates.io/libredox/0.1.12 \
+    crate://crates.io/linux-raw-sys/0.11.0 \
+    crate://crates.io/litemap/0.8.1 \
+    crate://crates.io/lock_api/0.4.14 \
+    crate://crates.io/log/0.4.29 \
+    crate://crates.io/lru-slab/0.1.2 \
+    crate://crates.io/maybe-async/0.2.10 \
+    crate://crates.io/memchr/2.8.0 \
+    crate://crates.io/mime/0.3.17 \
+    crate://crates.io/mio/1.1.1 \
+    crate://crates.io/new_debug_unreachable/1.0.6 \
+    crate://crates.io/nix/0.31.1 \
+    crate://crates.io/num-bigint-dig/0.8.6 \
+    crate://crates.io/num-conv/0.2.0 \
+    crate://crates.io/num-integer/0.1.46 \
+    crate://crates.io/num-iter/0.1.45 \
+    crate://crates.io/num-traits/0.2.19 \
+    crate://crates.io/num_threads/0.1.7 \
+    crate://crates.io/oauth2/5.0.0 \
+    crate://crates.io/once_cell/1.21.3 \
+    crate://crates.io/once_cell_polyfill/1.70.2 \
+    crate://crates.io/openidconnect/4.0.1 \
+    crate://crates.io/openssl/0.10.75 \
+    crate://crates.io/openssl-macros/0.1.1 \
+    crate://crates.io/openssl-probe/0.2.1 \
+    crate://crates.io/openssl-sys/0.9.111 \
+    crate://crates.io/ordered-float/2.10.1 \
+    crate://crates.io/p256/0.13.2 \
+    crate://crates.io/p384/0.13.1 \
+    crate://crates.io/parking_lot/0.12.5 \
+    crate://crates.io/parking_lot_core/0.9.12 \
+    crate://crates.io/pbkdf2/0.12.2 \
+    crate://crates.io/pem-rfc7468/0.7.0 \
+    crate://crates.io/percent-encoding/2.3.2 \
+    crate://crates.io/petgraph/0.6.5 \
+    crate://crates.io/phf_shared/0.11.3 \
+    crate://crates.io/pico-args/0.5.0 \
+    crate://crates.io/pin-project-lite/0.2.16 \
+    crate://crates.io/pin-utils/0.1.0 \
+    crate://crates.io/pkcs1/0.7.5 \
+    crate://crates.io/pkcs8/0.10.2 \
+    crate://crates.io/pkg-config/0.3.32 \
+    crate://crates.io/potential_utf/0.1.4 \
+    crate://crates.io/powerfmt/0.2.0 \
+    crate://crates.io/ppv-lite86/0.2.21 \
+    crate://crates.io/precomputed-hash/0.1.1 \
+    crate://crates.io/prettyplease/0.2.37 \
+    crate://crates.io/primeorder/0.13.6 \
+    crate://crates.io/proc-macro2/1.0.106 \
+    crate://crates.io/quick-xml/0.39.1 \
+    crate://crates.io/quinn/0.11.9 \
+    crate://crates.io/quinn-proto/0.11.13 \
+    crate://crates.io/quinn-udp/0.5.14 \
+    crate://crates.io/quote/1.0.44 \
+    crate://crates.io/r-efi/5.3.0 \
+    crate://crates.io/r2d2/0.8.10 \
+    crate://crates.io/rand/0.8.5 \
+    crate://crates.io/rand/0.9.2 \
+    crate://crates.io/rand/0.10.0 \
+    crate://crates.io/rand_chacha/0.3.1 \
+    crate://crates.io/rand_chacha/0.9.0 \
+    crate://crates.io/rand_core/0.6.4 \
+    crate://crates.io/rand_core/0.9.5 \
+    crate://crates.io/rand_core/0.10.0 \
+    crate://crates.io/redox_syscall/0.5.18 \
+    crate://crates.io/redox_syscall/0.7.1 \
+    crate://crates.io/redox_users/0.4.6 \
+    crate://crates.io/ref-cast/1.0.25 \
+    crate://crates.io/ref-cast-impl/1.0.25 \
+    crate://crates.io/regex/1.12.3 \
+    crate://crates.io/regex-automata/0.4.14 \
+    crate://crates.io/regex-syntax/0.8.9 \
+    crate://crates.io/reqwest/0.13.2 \
+    crate://crates.io/rfc6979/0.4.0 \
+    crate://crates.io/ring/0.17.14 \
+    crate://crates.io/rle-decode-fast/1.0.3 \
+    crate://crates.io/rpassword/7.4.0 \
+    crate://crates.io/rpki/0.19.2 \
+    crate://crates.io/rsa/0.9.10 \
+    crate://crates.io/rtoolbox/0.0.3 \
+    crate://crates.io/rustc-hash/2.1.1 \
+    crate://crates.io/rustc_version/0.4.1 \
+    crate://crates.io/rustix/1.1.3 \
+    crate://crates.io/rustls/0.23.36 \
+    crate://crates.io/rustls-native-certs/0.8.3 \
+    crate://crates.io/rustls-pemfile/2.2.0 \
+    crate://crates.io/rustls-pki-types/1.14.0 \
+    crate://crates.io/rustls-platform-verifier/0.6.2 \
+    crate://crates.io/rustls-platform-verifier-android/0.1.1 \
+    crate://crates.io/rustls-webpki/0.103.9 \
+    crate://crates.io/rustversion/1.0.22 \
+    crate://crates.io/salsa20/0.10.2 \
+    crate://crates.io/same-file/1.0.6 \
+    crate://crates.io/schannel/0.1.28 \
+    crate://crates.io/scheduled-thread-pool/0.2.7 \
+    crate://crates.io/schemars/0.9.0 \
+    crate://crates.io/schemars/1.2.1 \
+    crate://crates.io/scopeguard/1.2.0 \
+    crate://crates.io/scrypt/0.11.0 \
+    crate://crates.io/sec1/0.7.3 \
+    crate://crates.io/secrecy/0.10.3 \
+    crate://crates.io/security-framework/3.6.0 \
+    crate://crates.io/security-framework-sys/2.16.0 \
+    crate://crates.io/semver/1.0.27 \
+    crate://crates.io/serde/1.0.228 \
+    crate://crates.io/serde-value/0.7.0 \
+    crate://crates.io/serde_bytes/0.11.19 \
+    crate://crates.io/serde_core/1.0.228 \
+    crate://crates.io/serde_derive/1.0.228 \
+    crate://crates.io/serde_json/1.0.149 \
+    crate://crates.io/serde_path_to_error/0.1.20 \
+    crate://crates.io/serde_plain/1.0.2 \
+    crate://crates.io/serde_spanned/1.0.4 \
+    crate://crates.io/serde_with/3.16.1 \
+    crate://crates.io/serde_with_macros/3.16.1 \
+    crate://crates.io/sha2/0.10.9 \
+    crate://crates.io/shlex/1.3.0 \
+    crate://crates.io/signal-hook-registry/1.4.8 \
+    crate://crates.io/signature/2.2.0 \
+    crate://crates.io/siphasher/1.0.2 \
+    crate://crates.io/slab/0.4.12 \
+    crate://crates.io/smallvec/1.15.1 \
+    crate://crates.io/socket2/0.6.2 \
+    crate://crates.io/spin/0.9.8 \
+    crate://crates.io/spki/0.7.3 \
+    crate://crates.io/stable_deref_trait/1.2.1 \
+    crate://crates.io/stderrlog/0.6.0 \
+    crate://crates.io/string_cache/0.8.9 \
+    crate://crates.io/strsim/0.11.1 \
+    crate://crates.io/subtle/2.6.1 \
+    crate://crates.io/syn/1.0.109 \
+    crate://crates.io/syn/2.0.116 \
+    crate://crates.io/sync_wrapper/1.0.2 \
+    crate://crates.io/synstructure/0.13.2 \
+    crate://crates.io/syslog/7.0.0 \
+    crate://crates.io/system-configuration/0.7.0 \
+    crate://crates.io/system-configuration-sys/0.6.0 \
+    crate://crates.io/tar/0.4.44 \
+    crate://crates.io/tempfile/3.25.0 \
+    crate://crates.io/term/0.7.0 \
+    crate://crates.io/termcolor/1.1.3 \
+    crate://crates.io/terminal_size/0.4.3 \
+    crate://crates.io/thiserror/1.0.69 \
+    crate://crates.io/thiserror/2.0.18 \
+    crate://crates.io/thiserror-impl/1.0.69 \
+    crate://crates.io/thiserror-impl/2.0.18 \
+    crate://crates.io/thread_local/1.1.9 \
+    crate://crates.io/time/0.3.47 \
+    crate://crates.io/time-core/0.1.8 \
+    crate://crates.io/time-macros/0.2.27 \
+    crate://crates.io/tiny-keccak/2.0.2 \
+    crate://crates.io/tinystr/0.8.2 \
+    crate://crates.io/tinyvec/1.10.0 \
+    crate://crates.io/tinyvec_macros/0.1.1 \
+    crate://crates.io/tokio/1.49.0 \
+    crate://crates.io/tokio-macros/2.6.0 \
+    crate://crates.io/tokio-rustls/0.26.4 \
+    crate://crates.io/tokio-util/0.7.18 \
+    crate://crates.io/toml/0.9.12+spec-1.1.0 \
+    crate://crates.io/toml_datetime/0.7.5+spec-1.1.0 \
+    crate://crates.io/toml_parser/1.0.9+spec-1.1.0 \
+    crate://crates.io/toml_writer/1.0.6+spec-1.1.0 \
+    crate://crates.io/tower/0.5.3 \
+    crate://crates.io/tower-http/0.6.8 \
+    crate://crates.io/tower-layer/0.3.3 \
+    crate://crates.io/tower-service/0.3.3 \
+    crate://crates.io/tracing/0.1.44 \
+    crate://crates.io/tracing-core/0.1.36 \
+    crate://crates.io/trait-set/0.2.0 \
+    crate://crates.io/try-lock/0.2.5 \
+    crate://crates.io/typenum/1.19.0 \
+    crate://crates.io/unicode-ident/1.0.24 \
+    crate://crates.io/unicode-normalization/0.1.25 \
+    crate://crates.io/unicode-xid/0.2.6 \
+    crate://crates.io/untrusted/0.9.0 \
+    crate://crates.io/url/2.5.8 \
+    crate://crates.io/urlparse/0.7.3 \
+    crate://crates.io/utf8_iter/1.0.4 \
+    crate://crates.io/utf8parse/0.2.2 \
+    crate://crates.io/uuid/1.21.0 \
+    crate://crates.io/vcpkg/0.2.15 \
+    crate://crates.io/version_check/0.9.5 \
+    crate://crates.io/walkdir/2.5.0 \
+    crate://crates.io/want/0.3.1 \
+    crate://crates.io/wasi/0.11.1+wasi-snapshot-preview1 \
+    crate://crates.io/wasip2/1.0.2+wasi-0.2.9 \
+    crate://crates.io/wasip3/0.4.0+wasi-0.3.0-rc-2026-01-06 \
+    crate://crates.io/wasm-bindgen/0.2.108 \
+    crate://crates.io/wasm-bindgen-futures/0.4.58 \
+    crate://crates.io/wasm-bindgen-macro/0.2.108 \
+    crate://crates.io/wasm-bindgen-macro-support/0.2.108 \
+    crate://crates.io/wasm-bindgen-shared/0.2.108 \
+    crate://crates.io/wasm-encoder/0.244.0 \
+    crate://crates.io/wasm-metadata/0.244.0 \
+    crate://crates.io/wasmparser/0.244.0 \
+    crate://crates.io/web-sys/0.3.85 \
+    crate://crates.io/web-time/1.1.0 \
+    crate://crates.io/webpki-root-certs/1.0.6 \
+    crate://crates.io/winapi/0.3.9 \
+    crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
+    crate://crates.io/winapi-util/0.1.11 \
+    crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
+    crate://crates.io/windows-core/0.62.2 \
+    crate://crates.io/windows-implement/0.60.2 \
+    crate://crates.io/windows-interface/0.59.3 \
+    crate://crates.io/windows-link/0.2.1 \
+    crate://crates.io/windows-registry/0.6.1 \
+    crate://crates.io/windows-result/0.4.1 \
+    crate://crates.io/windows-strings/0.5.1 \
+    crate://crates.io/windows-sys/0.45.0 \
+    crate://crates.io/windows-sys/0.52.0 \
+    crate://crates.io/windows-sys/0.59.0 \
+    crate://crates.io/windows-sys/0.60.2 \
+    crate://crates.io/windows-sys/0.61.2 \
+    crate://crates.io/windows-targets/0.42.2 \
+    crate://crates.io/windows-targets/0.52.6 \
+    crate://crates.io/windows-targets/0.53.5 \
+    crate://crates.io/windows_aarch64_gnullvm/0.42.2 \
+    crate://crates.io/windows_aarch64_gnullvm/0.52.6 \
+    crate://crates.io/windows_aarch64_gnullvm/0.53.1 \
+    crate://crates.io/windows_aarch64_msvc/0.42.2 \
+    crate://crates.io/windows_aarch64_msvc/0.52.6 \
+    crate://crates.io/windows_aarch64_msvc/0.53.1 \
+    crate://crates.io/windows_i686_gnu/0.42.2 \
+    crate://crates.io/windows_i686_gnu/0.52.6 \
+    crate://crates.io/windows_i686_gnu/0.53.1 \
+    crate://crates.io/windows_i686_gnullvm/0.52.6 \
+    crate://crates.io/windows_i686_gnullvm/0.53.1 \
+    crate://crates.io/windows_i686_msvc/0.42.2 \
+    crate://crates.io/windows_i686_msvc/0.52.6 \
+    crate://crates.io/windows_i686_msvc/0.53.1 \
+    crate://crates.io/windows_x86_64_gnu/0.42.2 \
+    crate://crates.io/windows_x86_64_gnu/0.52.6 \
+    crate://crates.io/windows_x86_64_gnu/0.53.1 \
+    crate://crates.io/windows_x86_64_gnullvm/0.42.2 \
+    crate://crates.io/windows_x86_64_gnullvm/0.52.6 \
+    crate://crates.io/windows_x86_64_gnullvm/0.53.1 \
+    crate://crates.io/windows_x86_64_msvc/0.42.2 \
+    crate://crates.io/windows_x86_64_msvc/0.52.6 \
+    crate://crates.io/windows_x86_64_msvc/0.53.1 \
+    crate://crates.io/winnow/0.7.14 \
+    crate://crates.io/wit-bindgen/0.51.0 \
+    crate://crates.io/wit-bindgen-core/0.51.0 \
+    crate://crates.io/wit-bindgen-rust/0.51.0 \
+    crate://crates.io/wit-bindgen-rust-macro/0.51.0 \
+    crate://crates.io/wit-component/0.244.0 \
+    crate://crates.io/wit-parser/0.244.0 \
+    crate://crates.io/writeable/0.6.2 \
+    crate://crates.io/xattr/1.6.1 \
+    crate://crates.io/yoke/0.8.1 \
+    crate://crates.io/yoke-derive/0.8.1 \
+    crate://crates.io/zerocopy/0.8.39 \
+    crate://crates.io/zerocopy-derive/0.8.39 \
+    crate://crates.io/zerofrom/0.1.6 \
+    crate://crates.io/zerofrom-derive/0.1.6 \
+    crate://crates.io/zeroize/1.8.2 \
+    crate://crates.io/zerotrie/0.2.3 \
+    crate://crates.io/zerovec/0.11.5 \
+    crate://crates.io/zerovec-derive/0.11.2 \
+    crate://crates.io/zmij/1.0.21 \
 "
 
-SRC_URI[addr2line-0.17.0.sha256sum] = "b9ecd88a8c8378ca913a680cd98f0f13ac67383d35993f86c90a70e3f137816b"
-SRC_URI[adler-1.0.2.sha256sum] = "f26201604c87b1e01bd3d98f8d5d9a8fcbb815e8cedb41ffccbeb4bf593a35fe"
 SRC_URI[adler32-1.2.0.sha256sum] = "aae1277d39aeec15cb388266ecc24b11c80469deae6067e17a1a7aa9e5c1f234"
-SRC_URI[aho-corasick-0.7.18.sha256sum] = "1e37cfd5e7657ada45f742d6e99ca5788580b5c529dc78faf11ece6dc702656f"
+SRC_URI[aho-corasick-1.1.4.sha256sum] = "ddd31a130427c27518df266943a5308ed92d4b226cc639f5a8f1002816174301"
+SRC_URI[allocator-api2-0.2.21.sha256sum] = "683d7910e743518b0e34f1186f92494becacb047c7b6bf616c96772180fef923"
 SRC_URI[android_system_properties-0.1.5.sha256sum] = "819e7219dbd41043ac279b19830f2efc897156490d7fd6ea916720117ee66311"
-SRC_URI[ansi_term-0.12.1.sha256sum] = "d52a9bb7ec0cf484c551830a7ce27bd20d67eac647e1befb56b0be4ee39a55d2"
-SRC_URI[ascii-1.0.0.sha256sum] = "bbf56136a5198c7b01a49e3afcbef6cf84597273d298f54432926024107b0109"
+SRC_URI[anstream-0.6.21.sha256sum] = "43d5b281e737544384e969a5ccad3f1cdd24b48086a0fc1b2a5262a26b8f4f4a"
+SRC_URI[anstyle-1.0.13.sha256sum] = "5192cca8006f1fd4f7237516f40fa183bb07f8fbdfedaa0036de5ea9b0b45e78"
+SRC_URI[anstyle-parse-0.2.7.sha256sum] = "4e7644824f0aa2c7b9384579234ef10eb7efb6a0deb83f9630a49594dd9c15c2"
+SRC_URI[anstyle-query-1.1.5.sha256sum] = "40c48f72fd53cd289104fc64099abca73db4166ad86ea0b4341abe65af83dadc"
+SRC_URI[anstyle-wincon-3.0.11.sha256sum] = "291e6a250ff86cd4a820112fb8898808a366d8f9f58ce16d1f538353ad55747d"
+SRC_URI[anyhow-1.0.101.sha256sum] = "5f0e0fee31ef5ed1ba1316088939cea399010ed7731dba877ed44aeb407a75ea"
+SRC_URI[arc-swap-1.8.2.sha256sum] = "f9f3647c145568cec02c42054e07bdf9a5a698e15b466fb2341bfc393cd24aa5"
 SRC_URI[ascii-canvas-3.0.0.sha256sum] = "8824ecca2e851cec16968d54a01dd372ef8f95b244fb84b84e70128be347c3c6"
-SRC_URI[atty-0.2.14.sha256sum] = "d9b39be18770d11421cdb1b9947a45dd3f37e93092cbf377614828a319d5fee8"
-SRC_URI[autocfg-1.1.0.sha256sum] = "d468802bab17cbc0cc575e9b053f41e72aa36bfa6b7f55e3529ffa43161b97fa"
-SRC_URI[backoff-0.3.0.sha256sum] = "9fe17f59a06fe8b87a6fc8bf53bb70b3aba76d7685f432487a68cd5552853625"
-SRC_URI[backtrace-0.3.66.sha256sum] = "cab84319d616cfb654d03394f38ab7e6f0919e181b1b57e1fd15e7fb4077d9a7"
-SRC_URI[base64-0.13.0.sha256sum] = "904dfeac50f3cdaba28fc6f57fdcddb75f49ed61346676a78c4ffe55877802fd"
-SRC_URI[basic-cookies-0.1.4.sha256sum] = "cb53b6b315f924c7f113b162e53b3901c05fc9966baf84d201dfcc7432a4bb38"
-SRC_URI[bcder-0.7.0.sha256sum] = "f007d8acfb8ef7d219911c7164c025a6d3504735120fc5df59c3c479ab84ea51"
-SRC_URI[bit-set-0.5.2.sha256sum] = "6e11e16035ea35e4e5997b393eacbf6f63983188f7a2ad25bfb13465f5ad59de"
+SRC_URI[atomic-waker-1.1.2.sha256sum] = "1505bd5d3d116872e7271a6d4e16d81d0c8570876c8de68093a09ac269d8aac0"
+SRC_URI[autocfg-1.5.0.sha256sum] = "c08606f8c3cbf4ce6ec8e28fb0014a2c086708fe954eaa885384a6165172e7e8"
+SRC_URI[aws-lc-rs-1.15.4.sha256sum] = "7b7b6141e96a8c160799cc2d5adecd5cbbe5054cb8c7c4af53da0f83bb7ad256"
+SRC_URI[aws-lc-sys-0.37.1.sha256sum] = "b092fe214090261288111db7a2b2c2118e5a7f30dc2569f1732c4069a6840549"
+SRC_URI[backoff-0.4.0.sha256sum] = "b62ddb9cb1ec0a098ad4bbf9344d0713fa193ae1a80af55febcff2627b6a00c1"
+SRC_URI[base16ct-0.2.0.sha256sum] = "4c7f02d4ea65f2c1853089ffd8d2787bdbc63de2f0d29dedbcf8ccdfa0ccd4cf"
+SRC_URI[base64-0.21.7.sha256sum] = "9d297deb1925b89f2ccc13d7635fa0714f12c87adce1c75356b39ca9b7178567"
+SRC_URI[base64-0.22.1.sha256sum] = "72b3254f16251a8381aa12e40e3c4d2f0199f8c6508fbecb9d91f575e0fbb8c6"
+SRC_URI[base64ct-1.8.3.sha256sum] = "2af50177e190e07a26ab74f8b1efbfe2ef87da2116221318cb1c2e82baf7de06"
+SRC_URI[basic-cookies-0.1.5.sha256sum] = "67bd8fd42c16bdb08688243dc5f0cc117a3ca9efeeaba3a345a18a6159ad96f7"
+SRC_URI[bcder-0.7.6.sha256sum] = "1f7c42c9913f68cf9390a225e81ad56a5c515347287eb98baa710090ca1de86d"
+SRC_URI[bit-set-0.5.3.sha256sum] = "0700ddab506f33b20a03b13996eccd309a48e5ff77d0d95926aa0210fb4e95f1"
 SRC_URI[bit-vec-0.6.3.sha256sum] = "349f9b6a179ed607305526ca489b34ad0a41aed5f7980fa90eb03160b69598fb"
-SRC_URI[bitflags-1.3.2.sha256sum] = "bef38d45163c2f1dde094a7dfd33ccf595c92905c8f8f4fdc18d06fb1037718a"
-SRC_URI[block-buffer-0.9.0.sha256sum] = "4152116fd6e9dadb291ae18fc1ec3575ed6d84c29642d97890f4b4a3417297e4"
-SRC_URI[block-buffer-0.10.2.sha256sum] = "0bf7fe51849ea569fd452f37822f606a5cabb684dc918707a0193fd4664ff324"
-SRC_URI[bumpalo-3.10.0.sha256sum] = "37ccbd214614c6783386c1af30caf03192f17891059cecc394b4fb119e363de3"
-SRC_URI[bytes-1.1.0.sha256sum] = "c4872d67bab6358e59559027aa3b9157c53d9358c51423c17554809a8858e0f8"
-SRC_URI[cc-1.0.73.sha256sum] = "2fff2a6927b3bb87f9595d67196a70493f627687a71d87a0d692242c33f58c11"
-SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
-SRC_URI[chrono-0.4.22.sha256sum] = "bfd4d1b31faaa3a89d7934dbded3111da0d2ef28e3ebccdb4f0179f5929d1ef1"
-SRC_URI[chunked_transfer-1.4.0.sha256sum] = "fff857943da45f546682664a79488be82e69e43c1a7a2307679ab9afb3a66d2e"
-SRC_URI[cipher-0.2.5.sha256sum] = "12f8e7987cbd042a63249497f41aed09f8e65add917ea6566effbc56578d6801"
-SRC_URI[clap-2.34.0.sha256sum] = "a0610544180c38b88101fecf2dd634b174a62eef6946f84dfc6a7127512b381c"
-SRC_URI[codespan-reporting-0.11.1.sha256sum] = "3538270d33cc669650c4b093848450d380def10c331d38c768e34cac80576e6e"
-SRC_URI[core-foundation-0.9.3.sha256sum] = "194a7a9e6de53fa55116934067c844d9d749312f75c6f6d0980e8c252f8c2146"
-SRC_URI[core-foundation-sys-0.8.3.sha256sum] = "5827cebf4670468b8772dd191856768aedcb1b0278a04f989f7766351917b9dc"
-SRC_URI[cpufeatures-0.2.2.sha256sum] = "59a6001667ab124aebae2a495118e11d30984c3a653e99d86d58971708cf5e4b"
-SRC_URI[crc32fast-1.3.2.sha256sum] = "b540bd8bc810d3885c6ea91e2018302f68baba2129ab3e88f32389ee9370880d"
-SRC_URI[crunchy-0.2.2.sha256sum] = "7a81dae078cea95a014a339291cec439d2f232ebe854a9d672b796c6afafa9b7"
-SRC_URI[crypto-common-0.1.6.sha256sum] = "1bfb12502f3fc46cca1bb51ac28df9d618d813cdc3d2f25b9fe775a34af26bb3"
-SRC_URI[crypto-mac-0.10.1.sha256sum] = "bff07008ec701e8028e2ceb8f83f0e4274ee62bd2dbdc4fefff2e9a91824081a"
-SRC_URI[cryptoki-0.3.0.sha256sum] = "503aa2bd88796da9bc6baf2c47696da40f135721b3d6680c7c6cee0b7d1f7a59"
-SRC_URI[cryptoki-sys-0.1.4.sha256sum] = "1e4895bb04269df9a14f2692c6499dc2769e9a93caa33ef37c4df134f76956d2"
-SRC_URI[ctrlc-3.2.2.sha256sum] = "b37feaa84e6861e00a1f5e5aa8da3ee56d605c9992d33e082786754828e20865"
-SRC_URI[cxx-1.0.79.sha256sum] = "3f83d0ebf42c6eafb8d7c52f7e5f2d3003b89c7aa4fd2b79229209459a849af8"
-SRC_URI[cxx-build-1.0.79.sha256sum] = "07d050484b55975889284352b0ffc2ecbda25c0c55978017c132b29ba0818a86"
-SRC_URI[cxxbridge-flags-1.0.79.sha256sum] = "99d2199b00553eda8012dfec8d3b1c75fce747cf27c169a270b3b99e3448ab78"
-SRC_URI[cxxbridge-macro-1.0.79.sha256sum] = "dcb67a6de1f602736dd7eaead0080cf3435df806c61b24b13328db128c58868f"
-SRC_URI[derivative-2.2.0.sha256sum] = "fcc3dd5e9e9c0b295d6e1e4d811fb6f157d5ffd784b8d202fc62eac8035a770b"
-SRC_URI[deunicode-0.4.3.sha256sum] = "850878694b7933ca4c9569d30a34b55031b9b139ee1fc7b94a527c4ef960d690"
-SRC_URI[diff-0.1.13.sha256sum] = "56254986775e3233ffa9c4d7d3faaf6d36a2c09d30b20687e9f88bc8bafc16c8"
-SRC_URI[digest-0.9.0.sha256sum] = "d3dd60d1080a57a05ab032377049e0591415d2b31afd7028356dbf3cc6dcb066"
-SRC_URI[digest-0.10.3.sha256sum] = "f2fb860ca6fafa5552fb6d0e816a69c8e49f0908bf524e30a90d97c85892d506"
+SRC_URI[bitflags-2.11.0.sha256sum] = "843867be96c8daad0d758b57df9392b6d8d271134fce549de6ce169ff98a92af"
+SRC_URI[block-buffer-0.10.4.sha256sum] = "3078c7629b62d3f0439517fa394996acacc5cbc91c5a20d8c658e77abd503a71"
+SRC_URI[bumpalo-3.19.1.sha256sum] = "5dd9dc738b7a8311c7ade152424974d8115f2cdad61e8dab8dac9f2362298510"
+SRC_URI[bytes-1.11.1.sha256sum] = "1e748733b7cbc798e1434b6ac524f0c1ff2ab456fe201501e6497c8417a4fc33"
+SRC_URI[cc-1.2.56.sha256sum] = "aebf35691d1bfb0ac386a69bac2fde4dd276fb618cf8bf4f5318fe285e821bb2"
+SRC_URI[cesu8-1.1.0.sha256sum] = "6d43a04d8753f35258c91f8ec639f792891f748a1edbd759cf1dcea3382ad83c"
+SRC_URI[cfg-if-1.0.4.sha256sum] = "9330f8b2ff13f34540b44e946ef35111825727b38d33286ef986142615121801"
+SRC_URI[cfg_aliases-0.2.1.sha256sum] = "613afe47fcd5fac7ccf1db93babcb082c5994d996f20b8b159f2ad1658eb5724"
+SRC_URI[chacha20-0.10.0.sha256sum] = "6f8d983286843e49675a4b7a2d174efe136dc93a18d69130dd18198a6c167601"
+SRC_URI[chrono-0.4.43.sha256sum] = "fac4744fb15ae8337dc853fee7fb3f4e48c0fbaa23d0afe49c447b4fab126118"
+SRC_URI[cipher-0.4.4.sha256sum] = "773f3b9af64447d2ce9850330c473515014aa235e6a783b02db81ff39e4a3dad"
+SRC_URI[clap-4.5.59.sha256sum] = "c5caf74d17c3aec5495110c34cc3f78644bfa89af6c8993ed4de2790e49b6499"
+SRC_URI[clap_builder-4.5.59.sha256sum] = "370daa45065b80218950227371916a1633217ae42b2715b2287b606dcd618e24"
+SRC_URI[clap_derive-4.5.55.sha256sum] = "a92793da1a46a5f2a02a6f4c46c6496b28c43638adea8306fcb0caa1634f24e5"
+SRC_URI[clap_lex-1.0.0.sha256sum] = "3a822ea5bc7590f9d40f1ba12c0dc3c2760f3482c6984db1573ad11031420831"
+SRC_URI[cmake-0.1.57.sha256sum] = "75443c44cd6b379beb8c5b45d85d0773baf31cce901fe7bb252f4eff3008ef7d"
+SRC_URI[colorchoice-1.0.4.sha256sum] = "b05b61dc5112cbb17e4b6cd61790d9845d13888356391624cbe7e41efeac1e75"
+SRC_URI[combine-4.6.7.sha256sum] = "ba5a308b75df32fe02788e748662718f03fde005016435c444eea572398219fd"
+SRC_URI[const-oid-0.9.6.sha256sum] = "c2459377285ad874054d797f3ccebf984978aa39129f6eafde5cdc8315b612f8"
+SRC_URI[core-foundation-0.9.4.sha256sum] = "91e195e091a93c46f7102ec7818a2aa394e1e1771c3ab4825963fa03e45afb8f"
+SRC_URI[core-foundation-0.10.1.sha256sum] = "b2a6cd9ae233e7f62ba4e9353e81a88df7fc8a5987b8d445b4d90c879bd156f6"
+SRC_URI[core-foundation-sys-0.8.7.sha256sum] = "773648b94d0e5d620f64f280777445740e61fe701025087ec8b57f45c791888b"
+SRC_URI[core2-0.4.0.sha256sum] = "b49ba7ef1ad6107f8824dbe97de947cbaac53c44e7f9756a1fba0d37c1eec505"
+SRC_URI[cpufeatures-0.2.17.sha256sum] = "59ed5838eebb26a2bb2e58f6d5b5316989ae9d08bab10e0e6d103e656d1b0280"
+SRC_URI[cpufeatures-0.3.0.sha256sum] = "8b2a41393f66f16b0823bb79094d54ac5fbd34ab292ddafb9a0456ac9f87d201"
+SRC_URI[crc32fast-1.5.0.sha256sum] = "9481c1c90cbf2ac953f07c8d4a58aa3945c425b7185c9154d67a65e4230da511"
+SRC_URI[crunchy-0.2.4.sha256sum] = "460fbee9c2c2f33933d720630a6a0bac33ba7053db5344fac858d4b8952d77d5"
+SRC_URI[crypto-bigint-0.5.5.sha256sum] = "0dc92fb57ca44df6db8059111ab3af99a63d5d0f8375d9972e319a379c6bab76"
+SRC_URI[crypto-common-0.1.7.sha256sum] = "78c8292055d1c1df0cce5d180393dc8cce0abec0a7102adb6c7b1eef6016d60a"
+SRC_URI[cryptoki-0.12.0.sha256sum] = "ff765b99fc49f3116c9a908484486a2b92fd73c48da45c3a69716471c6cc56c6"
+SRC_URI[cryptoki-sys-0.5.0.sha256sum] = "f1fd850498411e4057f1cba79e6e2bc7cbe960544c1046ab46d4685c403a1121"
+SRC_URI[curve25519-dalek-4.1.3.sha256sum] = "97fb8b7c4503de7d6ae7b42ab72a5a59857b4c937ec27a3d4539dba95b5ab2be"
+SRC_URI[curve25519-dalek-derive-0.1.1.sha256sum] = "f46882e17999c6cc590af592290432be3bce0428cb0d5f8b6715e4dc7b383eb3"
+SRC_URI[darling-0.21.3.sha256sum] = "9cdf337090841a411e2a7f3deb9187445851f91b309c0c0a29e05f74a00a48c0"
+SRC_URI[darling_core-0.21.3.sha256sum] = "1247195ecd7e3c85f83c8d2a366e4210d588e802133e1e355180a9870b517ea4"
+SRC_URI[darling_macro-0.21.3.sha256sum] = "d38308df82d1080de0afee5d069fa14b0326a88c14f15c5ccda35b4a6c414c81"
+SRC_URI[dary_heap-0.3.8.sha256sum] = "06d2e3287df1c007e74221c49ca10a95d557349e54b3a75dc2fb14712c751f04"
+SRC_URI[der-0.7.10.sha256sum] = "e7c1832837b905bbfb5101e07cc24c8deddf52f93225eee6ead5f4d63d53ddcb"
+SRC_URI[deranged-0.5.6.sha256sum] = "cc3dc5ad92c2e2d1c193bbbbdf2ea477cb81331de4f3103f267ca18368b988c4"
+SRC_URI[digest-0.10.7.sha256sum] = "9ed9a281f7bc9b7576e61468ba615a66a5c8cfdff42420a70aa82701a3b1e292"
 SRC_URI[dirs-next-2.0.0.sha256sum] = "b98cf8ebf19c3d1b223e151f99a4f9f0690dca41414773390fc824184ac833e1"
 SRC_URI[dirs-sys-next-0.1.2.sha256sum] = "4ebda144c4fe02d1f7ea1a7d9641b6fc6b580adcfa024ae48797ecdeb6825b4d"
-SRC_URI[either-1.7.0.sha256sum] = "3f107b87b6afc2a64fd13cac55fe06d6c8859f12d4b14cbcdd2c67d0976781be"
-SRC_URI[ena-0.14.0.sha256sum] = "d7402b94a93c24e742487327a7cd839dc9d36fec9de9fb25b09f2dae459f36c3"
-SRC_URI[encoding_rs-0.8.31.sha256sum] = "9852635589dc9f9ea1b6fe9f05b50ef208c85c834a562f0c6abb1c475736ec2b"
+SRC_URI[displaydoc-0.2.5.sha256sum] = "97369cbbc041bc366949bc74d34658d6cda5621039731c6310521892a3a20ae0"
+SRC_URI[dunce-1.0.5.sha256sum] = "92773504d58c093f6de2459af4af33faa518c13451eb8f2b5698ed3d36e7c813"
+SRC_URI[dyn-clone-1.0.20.sha256sum] = "d0881ea181b1df73ff77ffaaf9c7544ecc11e82fba9b5f27b262a3c73a332555"
+SRC_URI[ecdsa-0.16.9.sha256sum] = "ee27f32b5c5292967d2d4a9d7f1e0b0aed2c15daded5a60300e4abb9d8020bca"
+SRC_URI[ed25519-2.2.3.sha256sum] = "115531babc129696a58c64a4fef0a8bf9e9698629fb97e9e40767d235cfbcd53"
+SRC_URI[ed25519-dalek-2.2.0.sha256sum] = "70e796c081cee67dc755e1a36a0a172b897fab85fc3f6bc48307991f64e4eca9"
+SRC_URI[either-1.15.0.sha256sum] = "48c757948c5ede0e46177b7add2e67155f70e33c07fea8284df6576da70b3719"
+SRC_URI[elliptic-curve-0.13.8.sha256sum] = "b5e6043086bf7973472e0c7dff2142ea0b680d30e18d9cc40f267efbf222bd47"
+SRC_URI[ena-0.14.4.sha256sum] = "eabffdaee24bd1bf95c5ef7cec31260444317e72ea56c4c91750e8b7ee58d5f1"
+SRC_URI[encoding_rs-0.8.35.sha256sum] = "75030f3c4f45dafd7586dd6780965a8c7e8e285a5ecb86713e63a79c5b2766f3"
 SRC_URI[enum-display-derive-0.1.1.sha256sum] = "f16ef37b2a9b242295d61a154ee91ae884afff6b8b933b486b12481cc58310ca"
 SRC_URI[enum-flags-0.1.8.sha256sum] = "3682d2328e61f5529088a02cd20bb0a9aeaeeeb2f26597436dd7d75d1340f8f5"
-SRC_URI[error-chain-0.11.0.sha256sum] = "ff511d5dc435d703f4971bc399647c9bc38e20cb41452e3b9feb4765419ed3f3"
-SRC_URI[fastrand-1.7.0.sha256sum] = "c3fcf0cee53519c866c09b5de1f6c56ff9d647101f81c1964fa632e148896cdf"
-SRC_URI[fern-0.5.9.sha256sum] = "e69ab0d5aca163e388c3a49d284fed6c3d0810700e77c5ae2756a50ec1a4daaa"
+SRC_URI[equivalent-1.0.2.sha256sum] = "877a4ace8713b0bcf2a4e7eec82529c029f1d0619886d18145fea96c3ffe5c0f"
+SRC_URI[errno-0.3.14.sha256sum] = "39cab71617ae0d63f51a36d69f866391735b51691dbda63cf6f96d042b63efeb"
+SRC_URI[fastrand-2.3.0.sha256sum] = "37909eebbb50d72f9059c3b6d82c0463f2ff062c9e95845c43a6c9c0355411be"
+SRC_URI[fd-lock-4.0.4.sha256sum] = "0ce92ff622d6dadf7349484f42c93271a0d49b7cc4d466a936405bacbe10aa78"
+SRC_URI[fern-0.7.1.sha256sum] = "4316185f709b23713e41e3195f90edef7fb00c3ed4adc79769cf09cc762a3b29"
+SRC_URI[ff-0.13.1.sha256sum] = "c0b50bfb653653f9ca9095b427bed08ab8d75a137839d9ad64eb11810d5b6393"
+SRC_URI[fiat-crypto-0.2.9.sha256sum] = "28dea519a9695b9977216879a3ebfddf92f1c08c05d984f8996aecd6ecdc811d"
+SRC_URI[filetime-0.2.27.sha256sum] = "f98844151eee8917efc50bd9e8318cb963ae8b297431495d3f758616ea5c57db"
+SRC_URI[find-msvc-tools-0.1.9.sha256sum] = "5baebc0774151f905a1a2cc41989300b1e6fbb29aff0ceffa1064fdd3088d582"
 SRC_URI[fixedbitset-0.4.2.sha256sum] = "0ce7134b9999ecaf8bcd65542e436736ef32ddca1b3e06094cb6ec5755203b80"
 SRC_URI[fnv-1.0.7.sha256sum] = "3f9eec918d3f24069decb9af1554cad7c880e2da24a9afd88aca000531ab82c1"
+SRC_URI[foldhash-0.1.5.sha256sum] = "d9c4f5dac5e15c24eb999c26181a6ca40b39fe946cbe4c263c7209467bc83af2"
+SRC_URI[foldhash-0.2.0.sha256sum] = "77ce24cb58228fbb8aa041425bb1050850ac19177686ea6e0f41a70416f56fdb"
 SRC_URI[foreign-types-0.3.2.sha256sum] = "f6f339eb8adc052cd2ca78910fda869aefa38d22d5cb648e6485e4d3fc06f3b1"
 SRC_URI[foreign-types-shared-0.1.1.sha256sum] = "00b0228411908ca8685dba7fc2cdd70ec9990a6e753e89b6ac91a84c40fbaf4b"
-SRC_URI[form_urlencoded-1.0.1.sha256sum] = "5fc25a87fa4fd2094bffb06925852034d90a17f0d1e05197d4956d3555752191"
-SRC_URI[fslock-0.2.1.sha256sum] = "04412b8935272e3a9bae6f48c7bfff74c2911f60525404edfdd28e49884c3bfb"
-SRC_URI[futures-0.3.21.sha256sum] = "f73fe65f54d1e12b726f517d3e2135ca3125a437b6d998caf1962961f7172d9e"
-SRC_URI[futures-channel-0.3.21.sha256sum] = "c3083ce4b914124575708913bca19bfe887522d6e2e6d0952943f5eac4a74010"
-SRC_URI[futures-core-0.3.21.sha256sum] = "0c09fd04b7e4073ac7156a9539b57a484a8ea920f79c7c675d05d289ab6110d3"
-SRC_URI[futures-executor-0.3.21.sha256sum] = "9420b90cfa29e327d0429f19be13e7ddb68fa1cccb09d65e5706b8c7a749b8a6"
-SRC_URI[futures-io-0.3.21.sha256sum] = "fc4045962a5a5e935ee2fdedaa4e08284547402885ab326734432bed5d12966b"
-SRC_URI[futures-macro-0.3.21.sha256sum] = "33c1e13800337f4d4d7a316bf45a567dbcb6ffe087f16424852d97e97a91f512"
-SRC_URI[futures-sink-0.3.21.sha256sum] = "21163e139fa306126e6eedaf49ecdb4588f939600f0b1e770f4205ee4b7fa868"
-SRC_URI[futures-task-0.3.21.sha256sum] = "57c66a976bf5909d801bbef33416c41372779507e7a6b3a5e25e4749c58f776a"
-SRC_URI[futures-util-0.3.21.sha256sum] = "d8b7abd5d659d9b90c8cba917f6ec750a74e2dc23902ef9cd4cc8c8b22e6036a"
-SRC_URI[generic-array-0.14.5.sha256sum] = "fd48d33ec7f05fbfa152300fdad764757cbded343c1aa1cff2fbaf4134851803"
-SRC_URI[getrandom-0.2.7.sha256sum] = "4eb1a864a501629691edf6c15a593b7a51eebaa1e8468e9ddc623de7c9b58ec6"
-SRC_URI[gimli-0.26.2.sha256sum] = "22030e2c5a68ec659fde1e949a745124b48e6fa8b045b7ed5bd1fe4ccc5c4e5d"
-SRC_URI[h2-0.3.13.sha256sum] = "37a82c6d637fc9515a4694bbf1cb2457b79d81ce52b3108bdeea58b07dd34a57"
+SRC_URI[form_urlencoded-1.2.2.sha256sum] = "cb4cb245038516f5f85277875cdaa4f7d2c9a0fa0468de06ed190163b1581fcf"
+SRC_URI[fs_extra-1.3.0.sha256sum] = "42703706b716c37f96a77aea830392ad231f44c9e9a67872fa5548707e11b11c"
+SRC_URI[futures-channel-0.3.32.sha256sum] = "07bbe89c50d7a535e539b8c17bc0b49bdb77747034daa8087407d655f3f7cc1d"
+SRC_URI[futures-core-0.3.32.sha256sum] = "7e3450815272ef58cec6d564423f6e755e25379b217b0bc688e295ba24df6b1d"
+SRC_URI[futures-macro-0.3.32.sha256sum] = "e835b70203e41293343137df5c0664546da5745f82ec9b84d40be8336958447b"
+SRC_URI[futures-sink-0.3.32.sha256sum] = "c39754e157331b013978ec91992bde1ac089843443c49cbc7f46150b0fad0893"
+SRC_URI[futures-task-0.3.32.sha256sum] = "037711b3d59c33004d3856fbdc83b99d4ff37a24768fa1be9ce3538a1cde4393"
+SRC_URI[futures-util-0.3.32.sha256sum] = "389ca41296e6190b48053de0321d02a77f32f8a5d2461dd38762c0593805c6d6"
+SRC_URI[generic-array-0.14.7.sha256sum] = "85649ca51fd72272d7821adaf274ad91c288277713d9c18820d8499a7ff69e9a"
+SRC_URI[getrandom-0.2.17.sha256sum] = "ff2abc00be7fca6ebc474524697ae276ad847ad0a6b3faa4bcb027e9a4614ad0"
+SRC_URI[getrandom-0.3.4.sha256sum] = "899def5c37c4fd7b2664648c28120ecec138e4d395b459e5ca34f9cce2dd77fd"
+SRC_URI[getrandom-0.4.1.sha256sum] = "139ef39800118c7683f2fd3c98c1b23c09ae076556b435f8e9064ae108aaeeec"
+SRC_URI[group-0.13.0.sha256sum] = "f0f9ef7462f7c099f518d754361858f86d8a07af53ba9af0fe635bbccb151a63"
+SRC_URI[h2-0.4.13.sha256sum] = "2f44da3a8150a6703ed5d34e164b875fd14c2cdab9af1252a9a1020bde2bdc54"
 SRC_URI[hashbrown-0.12.3.sha256sum] = "8a9ee70c43aaf417c914396645a0fa852624801b24ebb7ae78fe8272889ac888"
-SRC_URI[hermit-abi-0.1.19.sha256sum] = "62b467343b94ba476dcb2500d242dadbb39557df889310ac77c5d99100aaac33"
+SRC_URI[hashbrown-0.15.5.sha256sum] = "9229cfe53dfd69f0609a49f65461bd93001ea1ef889cd5529dd176593f5338a1"
+SRC_URI[hashbrown-0.16.1.sha256sum] = "841d1cc9bed7f9236f321df977030373f4a4163ae1a7dbfe1a51a2c1a51d9100"
+SRC_URI[heck-0.5.0.sha256sum] = "2304e00983f87ffb38b55b444b5e3b60a884b5d30c0fca7d82fe33449bbe55ea"
+SRC_URI[hermit-abi-0.5.2.sha256sum] = "fc0fef456e4baa96da950455cd02c081ca953b141298e41db3fc7e36b1da849c"
 SRC_URI[hex-0.4.3.sha256sum] = "7f24254aa9a54b5c858eaee2f5bccdb46aaf0e486a595ed5fd8f86ba55232a70"
-SRC_URI[hmac-0.10.1.sha256sum] = "c1441c6b1e930e2817404b5046f1f989899143a12bf92de603b69f4e0aee1e15"
-SRC_URI[http-0.2.8.sha256sum] = "75f43d41e26995c17e71ee126451dd3941010b0514a81a9d11f3b341debc2399"
-SRC_URI[http-body-0.4.5.sha256sum] = "d5f38f16d184e36f2408a55281cd658ecbd3ca05cce6d6510a176eca393e26d1"
-SRC_URI[httparse-1.7.1.sha256sum] = "496ce29bb5a52785b44e0f7ca2847ae0bb839c9bd28f69acac9b99d461c0c04c"
-SRC_URI[httpdate-1.0.2.sha256sum] = "c4a1e36c821dbe04574f602848a19f742f4fb3c98d40449f11bcad18d6b17421"
-SRC_URI[hyper-0.14.20.sha256sum] = "02c929dc5c39e335a03c405292728118860721b10190d98c2a0f0efd5baafbac"
-SRC_URI[hyper-tls-0.5.0.sha256sum] = "d6183ddfa99b85da61a140bea0efc93fdf56ceaa041b37d553518030827f9905"
-SRC_URI[iana-time-zone-0.1.51.sha256sum] = "f5a6ef98976b22b3b7f2f3a806f858cb862044cfa66805aa3ad84cb3d3b785ed"
-SRC_URI[iana-time-zone-haiku-0.1.1.sha256sum] = "0703ae284fc167426161c2e3f1da3ea71d94b21bedbcc9494e92b28e334e3dca"
-SRC_URI[idna-0.2.3.sha256sum] = "418a0a6fab821475f634efe3ccc45c013f742efe03d853e8d3355d5cb850ecf8"
-SRC_URI[impl-trait-for-tuples-0.2.2.sha256sum] = "11d7a9f6330b71fea57921c9b61c47ee6e84f72d394754eff6163ae67e7395eb"
-SRC_URI[indexmap-1.9.1.sha256sum] = "10a35a97730320ffe8e2d410b5d3b69279b98d2c14bdb8b70ea89ecf7888d41e"
-SRC_URI[instant-0.1.12.sha256sum] = "7a5bbe824c507c5da5956355e86a746d82e0e1464f65d862cc5e71da70e94b2c"
+SRC_URI[hkdf-0.12.4.sha256sum] = "7b5f8eb2ad728638ea2c7d47a21db23b7b58a72ed6a38256b8a1849f15fbbdf7"
+SRC_URI[hmac-0.12.1.sha256sum] = "6c49c37c09c17a53d937dfbb742eb3a961d65a994e6bcdcf37e7399d0cc8ab5e"
+SRC_URI[hostname-0.4.2.sha256sum] = "617aaa3557aef3810a6369d0a99fac8a080891b68bd9f9812a1eeda0c0730cbd"
+SRC_URI[http-1.4.0.sha256sum] = "e3ba2a386d7f85a81f119ad7498ebe444d2e22c2af0b86b069416ace48b3311a"
+SRC_URI[http-body-1.0.1.sha256sum] = "1efedce1fb8e6913f23e0c92de8e62cd5b772a67e7b3946df930a62566c93184"
+SRC_URI[http-body-util-0.1.3.sha256sum] = "b021d93e26becf5dc7e1b75b1bed1fd93124b374ceb73f43d4d4eafec896a64a"
+SRC_URI[httparse-1.10.1.sha256sum] = "6dbf3de79e51f3d586ab4cb9d5c3e2c14aa28ed23d180cf89b4df0454a69cc87"
+SRC_URI[httpdate-1.0.3.sha256sum] = "df3b46402a9d5adb4c86a0cf463f42e19994e3ee891101b1841f30a545cb49a9"
+SRC_URI[hyper-1.8.1.sha256sum] = "2ab2d4f250c3d7b1c9fcdff1cece94ea4e2dfbec68614f7b87cb205f24ca9d11"
+SRC_URI[hyper-rustls-0.27.7.sha256sum] = "e3c93eb611681b207e1fe55d5a71ecf91572ec8a6705cdb6857f7d8d5242cf58"
+SRC_URI[hyper-util-0.1.20.sha256sum] = "96547c2556ec9d12fb1578c4eaf448b04993e7fb79cbaad930a656880a6bdfa0"
+SRC_URI[iana-time-zone-0.1.65.sha256sum] = "e31bc9ad994ba00e440a8aa5c9ef0ec67d5cb5e5cb0cc7f8b744a35b389cc470"
+SRC_URI[iana-time-zone-haiku-0.1.2.sha256sum] = "f31827a206f56af32e590ba56d5d2d085f558508192593743f16b2306495269f"
+SRC_URI[icu_collections-2.1.1.sha256sum] = "4c6b649701667bbe825c3b7e6388cb521c23d88644678e83c0c4d0a621a34b43"
+SRC_URI[icu_locale_core-2.1.1.sha256sum] = "edba7861004dd3714265b4db54a3c390e880ab658fec5f7db895fae2046b5bb6"
+SRC_URI[icu_normalizer-2.1.1.sha256sum] = "5f6c8828b67bf8908d82127b2054ea1b4427ff0230ee9141c54251934ab1b599"
+SRC_URI[icu_normalizer_data-2.1.1.sha256sum] = "7aedcccd01fc5fe81e6b489c15b247b8b0690feb23304303a9e560f37efc560a"
+SRC_URI[icu_properties-2.1.2.sha256sum] = "020bfc02fe870ec3a66d93e677ccca0562506e5872c650f893269e08615d74ec"
+SRC_URI[icu_properties_data-2.1.2.sha256sum] = "616c294cf8d725c6afcd8f55abc17c56464ef6211f9ed59cccffe534129c77af"
+SRC_URI[icu_provider-2.1.1.sha256sum] = "85962cf0ce02e1e0a629cc34e7ca3e373ce20dda4c4d7294bbd0bf1fdb59e614"
+SRC_URI[id-arena-2.3.0.sha256sum] = "3d3067d79b975e8844ca9eb072e16b31c3c1c36928edf9c6789548c524d0d954"
+SRC_URI[ident_case-1.0.1.sha256sum] = "b9e0384b61958566e926dc50660321d12159025e767c18e043daf26b70104c39"
+SRC_URI[idna-1.1.0.sha256sum] = "3b0875f23caa03898994f6ddc501886a45c7d3d62d04d2d90788d47be1b1e4de"
+SRC_URI[idna_adapter-1.2.1.sha256sum] = "3acae9609540aa318d1bc588455225fb2085b9ed0c4f6bd0d9d5bcd86f1a0344"
+SRC_URI[indexmap-1.9.3.sha256sum] = "bd070e393353796e801d209ad339e89596eb4c8d430d18ede6a1cced8fafbd99"
+SRC_URI[indexmap-2.13.0.sha256sum] = "7714e70437a7dc3ac8eb7e6f8df75fd8eb422675fc7678aff7364301092b1017"
+SRC_URI[inout-0.1.4.sha256sum] = "879f10e63c20629ecabbb64a8010319738c66a5cd0c29b02d63d272b03751d01"
+SRC_URI[instant-0.1.13.sha256sum] = "e0242819d153cba4b4b05a5a8f2a7e9bbf97b6055b2a002b395c96b5ff3c0222"
 SRC_URI[intervaltree-0.2.7.sha256sum] = "270bc34e57047cab801a8c871c124d9dc7132f6473c6401f645524f4e6edd111"
-SRC_URI[ipnet-2.5.0.sha256sum] = "879d54834c8c76457ef4293a689b2a8c59b076067ad77b15efafbb05f92a592b"
-SRC_URI[itertools-0.10.3.sha256sum] = "a9a9d19fa1e79b6215ff29b9d6880b706147f16e9b1dbb1e4e5947b5b02bc5e3"
-SRC_URI[itoa-1.0.2.sha256sum] = "112c678d4050afce233f4f2852bb2eb519230b3cf12f33585275537d7e41578d"
-SRC_URI[jmespatch-0.3.0.sha256sum] = "7acf91a732ade34d8eda2dee9500a051833f14f0d3d10d77c149845d6ac6a5f0"
-SRC_URI[js-sys-0.3.58.sha256sum] = "c3fac17f7123a73ca62df411b1bf727ccc805daa070338fda671c86dac1bdc27"
-SRC_URI[kmip-protocol-0.4.2.sha256sum] = "396744d490b405f4ff293057bae5625e03dcf8be70fd4ba8c6346a54e78fd837"
-SRC_URI[kmip-ttlv-0.3.3.sha256sum] = "1aa943fd7166db2cc2deaea17bd5c2862ccf68eef9ce15576bcee9e4b494685c"
-SRC_URI[lalrpop-0.19.8.sha256sum] = "b30455341b0e18f276fa64540aff54deafb54c589de6aca68659c63dd2d5d823"
-SRC_URI[lalrpop-util-0.19.8.sha256sum] = "bcf796c978e9b4d983414f4caedc9273aa33ee214c5b887bd55fde84c85d2dc4"
-SRC_URI[lazy_static-1.4.0.sha256sum] = "e2abad23fbc42b3700f2f279844dc832adb2b2eb069b2df918f455c4e18cc646"
-SRC_URI[libc-0.2.126.sha256sum] = "349d5a591cd28b49e1d1037471617a32ddcda5731b99419008085f72d5a53836"
-SRC_URI[libflate-1.2.0.sha256sum] = "05605ab2bce11bcfc0e9c635ff29ef8b2ea83f29be257ee7d730cac3ee373093"
-SRC_URI[libflate_lz77-1.1.0.sha256sum] = "39a734c0493409afcd49deee13c006a04e3586b9761a03543c6272c9c51f2f5a"
-SRC_URI[libloading-0.7.3.sha256sum] = "efbc0f03f9a775e9f6aed295c6a1ba2253c5757a9e03d55c6caa46a681abcddd"
-SRC_URI[link-cplusplus-1.0.7.sha256sum] = "9272ab7b96c9046fbc5bc56c06c117cb639fe2d509df0c421cad82d2915cf369"
-SRC_URI[lock_api-0.4.7.sha256sum] = "327fa5b6a6940e4699ec49a9beae1ea4845c6bab9314e4f84ac68742139d8c53"
-SRC_URI[log-0.4.17.sha256sum] = "abb12e687cfb44aa40f41fc3978ef76448f9b6038cad6aef4259d3c095a2382e"
-SRC_URI[maplit-1.0.2.sha256sum] = "3e2e65a1a2e43cfcb47a895c4c8b10d1f4a61097f9f254f183aee60cad9c651d"
-SRC_URI[matchers-0.0.1.sha256sum] = "f099785f7595cc4b4553a174ce30dd7589ef93391ff414dbb67f62392b9e0ce1"
-SRC_URI[matches-0.1.9.sha256sum] = "a3e378b66a060d48947b590737b30a1be76706c8dd7b8ba0f2fe3989c68a853f"
-SRC_URI[maybe-async-0.2.6.sha256sum] = "6007f9dad048e0a224f27ca599d669fca8cfa0dac804725aab542b2eb032bce6"
-SRC_URI[memchr-2.5.0.sha256sum] = "2dffe52ecf27772e601905b7522cb4ef790d2cc203488bbd0e2fe85fcb74566d"
-SRC_URI[mime-0.3.16.sha256sum] = "2a60c7ce501c71e03a9c9c0d35b861413ae925bd979cc7a4e30d060069aaac8d"
-SRC_URI[miniz_oxide-0.5.3.sha256sum] = "6f5c75688da582b8ffc1f1799e9db273f32133c49e048f614d22ec3256773ccc"
-SRC_URI[mio-0.8.4.sha256sum] = "57ee1c23c7c63b0c9250c339ffdc69255f110b298b901b9f6c82547b7b87caaf"
-SRC_URI[native-tls-0.2.10.sha256sum] = "fd7e2f3618557f980e0b17e8856252eee3c97fa12c54dff0ca290fb6266ca4a9"
-SRC_URI[new_debug_unreachable-1.0.4.sha256sum] = "e4a24736216ec316047a1fc4252e27dabb04218aa4a3f37c6e7ddbf1f9782b54"
-SRC_URI[nix-0.24.2.sha256sum] = "195cdbc1741b8134346d515b3a56a1c94b0912758009cfd53f99ea0f57b065fc"
-SRC_URI[num-bigint-0.4.3.sha256sum] = "f93ab6289c7b344a8a9f60f88d80aa20032336fe78da341afc91c8a2341fc75f"
-SRC_URI[num-integer-0.1.45.sha256sum] = "225d3389fb3509a24c93f5c29eb6bde2586b98d9f016636dff58d7c6f7569cd9"
-SRC_URI[num-traits-0.2.15.sha256sum] = "578ede34cf02f8924ab9447f50c28075b4d3e5b269972345e7e0372b38c6cdcd"
-SRC_URI[num_cpus-1.13.1.sha256sum] = "19e64526ebdee182341572e50e9ad03965aa510cd94427a4549448f285e957a1"
-SRC_URI[oauth2-4.2.3.sha256sum] = "6d62c436394991641b970a92e23e8eeb4eb9bca74af4f5badc53bcd568daadbd"
-SRC_URI[object-0.29.0.sha256sum] = "21158b2c33aa6d4561f1c0a6ea283ca92bc54802a93b263e910746d679a7eb53"
-SRC_URI[once_cell-1.13.0.sha256sum] = "18a6dbe30758c9f83eb00cbea4ac95966305f5a7772f3f42ebfc7fc7eddbd8e1"
-SRC_URI[opaque-debug-0.3.0.sha256sum] = "624a8340c38c1b80fd549087862da4ba43e08858af025b236e509b6649fc13d5"
-SRC_URI[openidconnect-2.3.2.sha256sum] = "e26afc60b2bf11b9a039db1f3a3c0d5fe201eebdbe646a8ecb8342c8240e3271"
-SRC_URI[openssl-0.10.41.sha256sum] = "618febf65336490dfcf20b73f885f5651a0c89c64c2d4a8c3662585a70bf5bd0"
-SRC_URI[openssl-macros-0.1.0.sha256sum] = "b501e44f11665960c7e7fcf062c7d96a14ade4aa98116c004b2e37b5be7d736c"
-SRC_URI[openssl-probe-0.1.5.sha256sum] = "ff011a302c396a5197692431fc1948019154afc178baf7d8e37367442a4601cf"
-SRC_URI[openssl-src-111.25.0+1.1.1t.sha256sum] = "3173cd3626c43e3854b1b727422a276e568d9ec5fe8cec197822cf52cfb743d6"
-SRC_URI[openssl-sys-0.9.75.sha256sum] = "e5f9bd0c2710541a3cda73d6f9ac4f1b240de4ae261065d309dbe73d9dceb42f"
-SRC_URI[ordered-float-2.10.0.sha256sum] = "7940cf2ca942593318d07fcf2596cdca60a85c9e7fab408a5e21a4f9dcd40d87"
-SRC_URI[oso-0.12.4.sha256sum] = "aec41e2da1ce3a82eb807396f802c172f08aa03e1be31e5df49592a04e12c8c7"
-SRC_URI[parking_lot-0.12.1.sha256sum] = "3742b2c103b9f06bc9fff0a37ff4912935851bee6d36f3c02bcc755bcfec228f"
-SRC_URI[parking_lot_core-0.9.3.sha256sum] = "09a279cbf25cb0757810394fbc1e359949b59e348145c643a939a525692e6929"
-SRC_URI[pbkdf2-0.7.5.sha256sum] = "bf916dd32dd26297907890d99dc2740e33f6bd9073965af4ccff2967962f5508"
-SRC_URI[percent-encoding-2.1.0.sha256sum] = "d4fd5641d01c8f18a23da7b6fe29298ff4b55afcccdf78973b24cf3175fee32e"
-SRC_URI[petgraph-0.6.2.sha256sum] = "e6d5014253a1331579ce62aa67443b4a658c5e7dd03d4bc6d302b94474888143"
-SRC_URI[phf_shared-0.10.0.sha256sum] = "b6796ad771acdc0123d2a88dc428b5e38ef24456743ddb1744ed628f9815c096"
-SRC_URI[pico-args-0.4.2.sha256sum] = "db8bcd96cb740d03149cbad5518db9fd87126a10ab519c011893b1754134c468"
-SRC_URI[pin-project-lite-0.2.9.sha256sum] = "e0a7ae3ac2f1173085d398531c705756c94a4c56843785df85a60c1a0afac116"
+SRC_URI[ipnet-2.11.0.sha256sum] = "469fb0b9cefa57e3ef31275ee7cacb78f2fdca44e4765491884a2b119d4eb130"
+SRC_URI[iri-string-0.7.10.sha256sum] = "c91338f0783edbd6195decb37bae672fd3b165faffb89bf7b9e6942f8b1a731a"
+SRC_URI[is-terminal-0.4.17.sha256sum] = "3640c1c38b8e4e43584d8df18be5fc6b0aa314ce6ebf51b53313d4306cca8e46"
+SRC_URI[is_terminal_polyfill-1.70.2.sha256sum] = "a6cb138bb79a146c1bd460005623e142ef0181e3d0219cb493e02f7d08a35695"
+SRC_URI[itertools-0.10.5.sha256sum] = "b0fd2260e829bddf4cb6ea802289de2f86d6a7a690192fbe91b3f46e0f2c8473"
+SRC_URI[itertools-0.11.0.sha256sum] = "b1c173a5686ce8bfa551b3563d0c2170bf24ca44da99c7ca4bfdab5418c3fe57"
+SRC_URI[itoa-1.0.17.sha256sum] = "92ecc6618181def0457392ccd0ee51198e065e016d1d527a7ac1b6dc7c1f09d2"
+SRC_URI[jni-0.21.1.sha256sum] = "1a87aa2bb7d2af34197c04845522473242e1aa17c12f4935d5856491a7fb8c97"
+SRC_URI[jni-sys-0.3.0.sha256sum] = "8eaf4bc02d17cbdd7ff4c7438cafcdf7fb9a4613313ad11b4f8fefe7d3fa0130"
+SRC_URI[jobserver-0.1.34.sha256sum] = "9afb3de4395d6b3e67a780b6de64b51c978ecf11cb9a462c66be7d4ca9039d33"
+SRC_URI[js-sys-0.3.85.sha256sum] = "8c942ebf8e95485ca0d52d97da7c5a2c387d0e7f0ba4c35e93bfcaee045955b3"
+SRC_URI[kmip-protocol-0.4.3.sha256sum] = "aa5c6e91a4f36736ef47f650dc90d327b8be65f4acaf401bad389ce81c53ded5"
+SRC_URI[kmip-ttlv-0.3.5.sha256sum] = "13cdaafff68ae98da73fd6dff927095849646c6eeee44bdd0a983d30192cdeb1"
+SRC_URI[lalrpop-0.20.2.sha256sum] = "55cb077ad656299f160924eb2912aa147d7339ea7d69e1b5517326fdcec3c1ca"
+SRC_URI[lalrpop-util-0.20.2.sha256sum] = "507460a910eb7b32ee961886ff48539633b788a36b65692b95f225b844c82553"
+SRC_URI[lazy_static-1.5.0.sha256sum] = "bbd2bcb4c963f2ddae06a2efc7e9f3591312473c50c6685e1f298068316e66fe"
+SRC_URI[leb128fmt-0.1.0.sha256sum] = "09edd9e8b54e49e587e4f6295a7d29c3ea94d469cb40ab8ca70b288248a81db2"
+SRC_URI[libc-0.2.180.sha256sum] = "bcc35a38544a891a5f7c865aca548a982ccb3b8650a5b06d0fd33a10283c56fc"
+SRC_URI[libflate-2.2.1.sha256sum] = "e3248b8d211bd23a104a42d81b4fa8bb8ac4a3b75e7a43d85d2c9ccb6179cd74"
+SRC_URI[libflate_lz77-2.2.0.sha256sum] = "a599cb10a9cd92b1300debcef28da8f70b935ec937f44fcd1b70a7c986a11c5c"
+SRC_URI[libloading-0.8.9.sha256sum] = "d7c4b02199fee7c5d21a5ae7d8cfa79a6ef5bb2fc834d6e9058e89c825efdc55"
+SRC_URI[libm-0.2.16.sha256sum] = "b6d2cec3eae94f9f509c767b45932f1ada8350c4bdb85af2fcab4a3c14807981"
+SRC_URI[libredox-0.1.12.sha256sum] = "3d0b95e02c851351f877147b7deea7b1afb1df71b63aa5f8270716e0c5720616"
+SRC_URI[linux-raw-sys-0.11.0.sha256sum] = "df1d3c3b53da64cf5760482273a98e575c651a67eec7f77df96b5b642de8f039"
+SRC_URI[litemap-0.8.1.sha256sum] = "6373607a59f0be73a39b6fe456b8192fcc3585f602af20751600e974dd455e77"
+SRC_URI[lock_api-0.4.14.sha256sum] = "224399e74b87b5f3557511d98dff8b14089b3dadafcab6bb93eab67d3aace965"
+SRC_URI[log-0.4.29.sha256sum] = "5e5032e24019045c762d3c0f28f5b6b8bbf38563a65908389bf7978758920897"
+SRC_URI[lru-slab-0.1.2.sha256sum] = "112b39cec0b298b6c1999fee3e31427f74f676e4cb9879ed1a121b43661a4154"
+SRC_URI[maybe-async-0.2.10.sha256sum] = "5cf92c10c7e361d6b99666ec1c6f9805b0bea2c3bd8c78dc6fe98ac5bd78db11"
+SRC_URI[memchr-2.8.0.sha256sum] = "f8ca58f447f06ed17d5fc4043ce1b10dd205e060fb3ce5b979b8ed8e59ff3f79"
+SRC_URI[mime-0.3.17.sha256sum] = "6877bb514081ee2a7ff5ef9de3281f14a4dd4bceac4c09388074a6b5df8a139a"
+SRC_URI[mio-1.1.1.sha256sum] = "a69bcab0ad47271a0234d9422b131806bf3968021e5dc9328caf2d4cd58557fc"
+SRC_URI[new_debug_unreachable-1.0.6.sha256sum] = "650eef8c711430f1a879fdd01d4745a7deea475becfb90269c06775983bbf086"
+SRC_URI[nix-0.31.1.sha256sum] = "225e7cfe711e0ba79a68baeddb2982723e4235247aefce1482f2f16c27865b66"
+SRC_URI[num-bigint-dig-0.8.6.sha256sum] = "e661dda6640fad38e827a6d4a310ff4763082116fe217f279885c97f511bb0b7"
+SRC_URI[num-conv-0.2.0.sha256sum] = "cf97ec579c3c42f953ef76dbf8d55ac91fb219dde70e49aa4a6b7d74e9919050"
+SRC_URI[num-integer-0.1.46.sha256sum] = "7969661fd2958a5cb096e56c8e1ad0444ac2bbcd0061bd28660485a44879858f"
+SRC_URI[num-iter-0.1.45.sha256sum] = "1429034a0490724d0075ebb2bc9e875d6503c3cf69e235a8941aa757d83ef5bf"
+SRC_URI[num-traits-0.2.19.sha256sum] = "071dfc062690e90b734c0b2273ce72ad0ffa95f0c74596bc250dcfd960262841"
+SRC_URI[num_threads-0.1.7.sha256sum] = "5c7398b9c8b70908f6371f47ed36737907c87c52af34c268fed0bf0ceb92ead9"
+SRC_URI[oauth2-5.0.0.sha256sum] = "51e219e79014df21a225b1860a479e2dcd7cbd9130f4defd4bd0e191ea31d67d"
+SRC_URI[once_cell-1.21.3.sha256sum] = "42f5e15c9953c5e4ccceeb2e7382a716482c34515315f7b03532b8b4e8393d2d"
+SRC_URI[once_cell_polyfill-1.70.2.sha256sum] = "384b8ab6d37215f3c5301a95a4accb5d64aa607f1fcb26a11b5303878451b4fe"
+SRC_URI[openidconnect-4.0.1.sha256sum] = "0d8c6709ba2ea764bbed26bce1adf3c10517113ddea6f2d4196e4851757ef2b2"
+SRC_URI[openssl-0.10.75.sha256sum] = "08838db121398ad17ab8531ce9de97b244589089e290a384c900cb9ff7434328"
+SRC_URI[openssl-macros-0.1.1.sha256sum] = "a948666b637a0f465e8564c73e89d4dde00d72d4d473cc972f390fc3dcee7d9c"
+SRC_URI[openssl-probe-0.2.1.sha256sum] = "7c87def4c32ab89d880effc9e097653c8da5d6ef28e6b539d313baaacfbafcbe"
+SRC_URI[openssl-sys-0.9.111.sha256sum] = "82cab2d520aa75e3c58898289429321eb788c3106963d0dc886ec7a5f4adc321"
+SRC_URI[ordered-float-2.10.1.sha256sum] = "68f19d67e5a2795c94e73e0bb1cc1a7edeb2e28efd39e2e1c9b7a40c1108b11c"
+SRC_URI[p256-0.13.2.sha256sum] = "c9863ad85fa8f4460f9c48cb909d38a0d689dba1f6f6988a5e3e0d31071bcd4b"
+SRC_URI[p384-0.13.1.sha256sum] = "fe42f1670a52a47d448f14b6a5c61dd78fce51856e68edaa38f7ae3a46b8d6b6"
+SRC_URI[parking_lot-0.12.5.sha256sum] = "93857453250e3077bd71ff98b6a65ea6621a19bb0f559a85248955ac12c45a1a"
+SRC_URI[parking_lot_core-0.9.12.sha256sum] = "2621685985a2ebf1c516881c026032ac7deafcda1a2c9b7850dc81e3dfcb64c1"
+SRC_URI[pbkdf2-0.12.2.sha256sum] = "f8ed6a7761f76e3b9f92dfb0a60a6a6477c61024b775147ff0973a02653abaf2"
+SRC_URI[pem-rfc7468-0.7.0.sha256sum] = "88b39c9bfcfc231068454382784bb460aae594343fb030d46e9f50a645418412"
+SRC_URI[percent-encoding-2.3.2.sha256sum] = "9b4f627cb1b25917193a259e49bdad08f671f8d9708acfd5fe0a8c1455d87220"
+SRC_URI[petgraph-0.6.5.sha256sum] = "b4c5cc86750666a3ed20bdaf5ca2a0344f9c67674cae0515bec2da16fbaa47db"
+SRC_URI[phf_shared-0.11.3.sha256sum] = "67eabc2ef2a60eb7faa00097bd1ffdb5bd28e62bf39990626a582201b7a754e5"
+SRC_URI[pico-args-0.5.0.sha256sum] = "5be167a7af36ee22fe3115051bc51f6e6c7054c9348e28deb4f49bd6f705a315"
+SRC_URI[pin-project-lite-0.2.16.sha256sum] = "3b3cff922bd51709b605d9ead9aa71031d81447142d828eb4a6eba76fe619f9b"
 SRC_URI[pin-utils-0.1.0.sha256sum] = "8b870d8c151b6f2fb93e84a13146138f05d02ed11c7e7c54f8826aaaf7c9f184"
-SRC_URI[pkg-config-0.3.25.sha256sum] = "1df8c4ec4b0627e53bdf214615ad287367e482558cf84b109250b37464dc03ae"
-SRC_URI[polar-core-0.12.4.sha256sum] = "53d2b6ee5b5ff6312ca55e2ba75fbd438c72bc041c799055388d815726eca69b"
-SRC_URI[ppv-lite86-0.2.16.sha256sum] = "eb9f9e6e233e5c4a35559a617bf40a4ec447db2e84c20b55a6f83167b7e57872"
+SRC_URI[pkcs1-0.7.5.sha256sum] = "c8ffb9f10fa047879315e6625af03c164b16962a5368d724ed16323b68ace47f"
+SRC_URI[pkcs8-0.10.2.sha256sum] = "f950b2377845cebe5cf8b5165cb3cc1a5e0fa5cfa3e1f7f55707d8fd82e0a7b7"
+SRC_URI[pkg-config-0.3.32.sha256sum] = "7edddbd0b52d732b21ad9a5fab5c704c14cd949e5e9a1ec5929a24fded1b904c"
+SRC_URI[potential_utf-0.1.4.sha256sum] = "b73949432f5e2a09657003c25bca5e19a0e9c84f8058ca374f49e0ebe605af77"
+SRC_URI[powerfmt-0.2.0.sha256sum] = "439ee305def115ba05938db6eb1644ff94165c5ab5e9420d1c1bcedbba909391"
+SRC_URI[ppv-lite86-0.2.21.sha256sum] = "85eae3c4ed2f50dcfe72643da4befc30deadb458a9b590d720cde2f2b1e97da9"
 SRC_URI[precomputed-hash-0.1.1.sha256sum] = "925383efa346730478fb4838dbe9137d2a47675ad789c546d150a6e1dd4ab31c"
-SRC_URI[priority-queue-1.2.2.sha256sum] = "de9cde7493f5f5d2d163b174be9f9a72d756b79b0f6ed85654128d238c347c1e"
-SRC_URI[proc-macro2-1.0.40.sha256sum] = "dd96a1e8ed2596c337f8eae5f24924ec83f5ad5ab21ea8e455d3566c69fbcaf7"
-SRC_URI[quick-xml-0.23.0.sha256sum] = "9279fbdacaad3baf559d8cabe0acc3d06e30ea14931af31af79578ac0946decc"
-SRC_URI[quote-1.0.20.sha256sum] = "3bcdf212e9776fbcb2d23ab029360416bb1706b1aea2d1a5ba002727cbcab804"
+SRC_URI[prettyplease-0.2.37.sha256sum] = "479ca8adacdd7ce8f1fb39ce9ecccbfe93a3f1344b3d0d97f20bc0196208f62b"
+SRC_URI[primeorder-0.13.6.sha256sum] = "353e1ca18966c16d9deb1c69278edbc5f194139612772bd9537af60ac231e1e6"
+SRC_URI[proc-macro2-1.0.106.sha256sum] = "8fd00f0bb2e90d81d1044c2b32617f68fcb9fa3bb7640c23e9c748e53fb30934"
+SRC_URI[quick-xml-0.39.1.sha256sum] = "bd58c6a1fc307e1092aa0bb23d204ca4d1f021764142cd0424dccc84d2d5d106"
+SRC_URI[quinn-0.11.9.sha256sum] = "b9e20a958963c291dc322d98411f541009df2ced7b5a4f2bd52337638cfccf20"
+SRC_URI[quinn-proto-0.11.13.sha256sum] = "f1906b49b0c3bc04b5fe5d86a77925ae6524a19b816ae38ce1e426255f1d8a31"
+SRC_URI[quinn-udp-0.5.14.sha256sum] = "addec6a0dcad8a8d96a771f815f0eaf55f9d1805756410b39f5fa81332574cbd"
+SRC_URI[quote-1.0.44.sha256sum] = "21b2ebcf727b7760c461f091f9f0f539b77b8e87f2fd88131e7f1b433b3cece4"
+SRC_URI[r-efi-5.3.0.sha256sum] = "69cdb34c158ceb288df11e18b4bd39de994f6657d83847bdffdbd7f346754b0f"
 SRC_URI[r2d2-0.8.10.sha256sum] = "51de85fb3fb6524929c8a2eb85e6b6d363de4e8c48f9e2c2eac4944abc181c93"
 SRC_URI[rand-0.8.5.sha256sum] = "34af8d1a0e25924bc5b7c43c079c942339d8f0a8b57c39049bef581b46327404"
+SRC_URI[rand-0.9.2.sha256sum] = "6db2770f06117d490610c7488547d543617b21bfa07796d7a12f6f1bd53850d1"
+SRC_URI[rand-0.10.0.sha256sum] = "bc266eb313df6c5c09c1c7b1fbe2510961e5bcd3add930c1e31f7ed9da0feff8"
 SRC_URI[rand_chacha-0.3.1.sha256sum] = "e6c10a63a0fa32252be49d21e7709d4d4baf8d231c2dbce1eaa8141b9b127d88"
-SRC_URI[rand_core-0.6.3.sha256sum] = "d34f1408f55294453790c48b2f1ebbb1c5b4b7563eb1f418bcfcfdbb06ebb4e7"
-SRC_URI[redox_syscall-0.2.13.sha256sum] = "62f25bc4c7e55e0b0b7a1d43fb893f4fa1361d0abe38b9ce4f323c2adfe6ef42"
-SRC_URI[redox_users-0.4.3.sha256sum] = "b033d837a7cf162d7993aded9304e30a83213c648b6e389db233191f891e5c2b"
-SRC_URI[regex-1.6.0.sha256sum] = "4c4eb3267174b8c6c2f654116623910a0fef09c4753f8dd83db29c48a0df988b"
-SRC_URI[regex-automata-0.1.10.sha256sum] = "6c230d73fb8d8c1b9c0b3135c5142a8acee3a0558fb8db5cf1cb65f8d7862132"
-SRC_URI[regex-syntax-0.6.27.sha256sum] = "a3f87b73ce11b1619a3c6332f45341e0047173771e8b8b73f87bfeefb7b56244"
-SRC_URI[remove_dir_all-0.5.3.sha256sum] = "3acd125665422973a33ac9d3dd2df85edad0f4ae9b00dafb1a05e43a9f5ef8e7"
-SRC_URI[reqwest-0.11.11.sha256sum] = "b75aa69a3f06bbcc66ede33af2af253c6f7a86b1ca0033f60c580a27074fbf92"
-SRC_URI[ring-0.16.20.sha256sum] = "3053cf52e236a3ed746dfc745aa9cacf1b791d846bdaf412f60a8d7d6e17c8fc"
+SRC_URI[rand_chacha-0.9.0.sha256sum] = "d3022b5f1df60f26e1ffddd6c66e8aa15de382ae63b3a0c1bfc0e4d3e3f325cb"
+SRC_URI[rand_core-0.6.4.sha256sum] = "ec0be4795e2f6a28069bec0b5ff3e2ac9bafc99e6a9a7dc3547996c5c816922c"
+SRC_URI[rand_core-0.9.5.sha256sum] = "76afc826de14238e6e8c374ddcc1fa19e374fd8dd986b0d2af0d02377261d83c"
+SRC_URI[rand_core-0.10.0.sha256sum] = "0c8d0fd677905edcbeedbf2edb6494d676f0e98d54d5cf9bda0b061cb8fb8aba"
+SRC_URI[redox_syscall-0.5.18.sha256sum] = "ed2bf2547551a7053d6fdfafda3f938979645c44812fbfcda098faae3f1a362d"
+SRC_URI[redox_syscall-0.7.1.sha256sum] = "35985aa610addc02e24fc232012c86fd11f14111180f902b67e2d5331f8ebf2b"
+SRC_URI[redox_users-0.4.6.sha256sum] = "ba009ff324d1fc1b900bd1fdb31564febe58a8ccc8a6fdbb93b543d33b13ca43"
+SRC_URI[ref-cast-1.0.25.sha256sum] = "f354300ae66f76f1c85c5f84693f0ce81d747e2c3f21a45fef496d89c960bf7d"
+SRC_URI[ref-cast-impl-1.0.25.sha256sum] = "b7186006dcb21920990093f30e3dea63b7d6e977bf1256be20c3563a5db070da"
+SRC_URI[regex-1.12.3.sha256sum] = "e10754a14b9137dd7b1e3e5b0493cc9171fdd105e0ab477f51b72e7f3ac0e276"
+SRC_URI[regex-automata-0.4.14.sha256sum] = "6e1dd4122fc1595e8162618945476892eefca7b88c52820e74af6262213cae8f"
+SRC_URI[regex-syntax-0.8.9.sha256sum] = "a96887878f22d7bad8a3b6dc5b7440e0ada9a245242924394987b21cf2210a4c"
+SRC_URI[reqwest-0.13.2.sha256sum] = "ab3f43e3283ab1488b624b44b0e988d0acea0b3214e694730a055cb6b2efa801"
+SRC_URI[rfc6979-0.4.0.sha256sum] = "f8dd2a808d456c4a54e300a23e9f5a67e122c3024119acbfd73e3bf664491cb2"
+SRC_URI[ring-0.17.14.sha256sum] = "a4689e6c2294d81e88dc6261c768b63bc4fcdb852be6d1352498b114f61383b7"
 SRC_URI[rle-decode-fast-1.0.3.sha256sum] = "3582f63211428f83597b51b2ddb88e2a91a9d52d12831f9d08f5e624e8977422"
-SRC_URI[routecore-0.2.0.sha256sum] = "9afd872857e85411c0ba7d18dfe650fc4864b292c02cde997e86c511314fdfc3"
-SRC_URI[rpassword-5.0.1.sha256sum] = "ffc936cf8a7ea60c58f030fd36a612a48f440610214dc54bc36431f9ea0c3efb"
-SRC_URI[rpki-0.15.8.sha256sum] = "46970b82ec6bfec47c88addaaef3d345cec2a5cf9cb89039ef904123e65ba41a"
-SRC_URI[rustc-demangle-0.1.21.sha256sum] = "7ef03e0a2b150c7a90d01faf6254c9c48a41e95fb2a8c2ac1c6f0d2b9aefc342"
-SRC_URI[rustc_version-0.4.0.sha256sum] = "bfa0f585226d2e68097d4f95d113b15b83a82e819ab25717ec0590d9584ef366"
-SRC_URI[rustls-0.19.1.sha256sum] = "35edb675feee39aec9c99fa5ff985081995a06d594114ae14cbe797ad7b7a6d7"
-SRC_URI[rustversion-1.0.8.sha256sum] = "24c8ad4f0c00e1eb5bc7614d236a7f1300e3dbd76b68cac8e06fb00b015ad8d8"
-SRC_URI[ryu-1.0.10.sha256sum] = "f3f6f92acf49d1b98f7a81226834412ada05458b7364277387724a237f062695"
-SRC_URI[salsa20-0.7.2.sha256sum] = "399f290ffc409596022fce5ea5d4138184be4784f2b28c62c59f0d8389059a15"
-SRC_URI[schannel-0.1.20.sha256sum] = "88d6731146462ea25d9244b2ed5fd1d716d25c52e4d54aa4fb0f3c4e9854dbe2"
-SRC_URI[scheduled-thread-pool-0.2.6.sha256sum] = "977a7519bff143a44f842fd07e80ad1329295bd71686457f18e496736f4bf9bf"
-SRC_URI[scopeguard-1.1.0.sha256sum] = "d29ab0c6d3fc0ee92fe66e2d99f700eab17a8d57d1c1d3b748380fb20baa78cd"
-SRC_URI[scratch-1.0.2.sha256sum] = "9c8132065adcfd6e02db789d9285a0deb2f3fcb04002865ab67d5fb103533898"
-SRC_URI[scrypt-0.6.5.sha256sum] = "19230d10daad7f163d8c1fc8edf84fbe52ac71c2ebe5adf3f763aa1557b843e3"
-SRC_URI[sct-0.6.1.sha256sum] = "b362b83898e0e69f38515b82ee15aa80636befe47c3b6d3d89a911e78fc228ce"
-SRC_URI[security-framework-2.6.1.sha256sum] = "2dc14f172faf8a0194a3aded622712b0de276821addc574fa54fc0a1167e10dc"
-SRC_URI[security-framework-sys-2.6.1.sha256sum] = "0160a13a177a45bfb43ce71c01580998474f556ad854dcbca936dd2841a5c556"
-SRC_URI[semver-1.0.12.sha256sum] = "a2333e6df6d6598f2b1974829f853c2b4c5f4a6e503c10af918081aa6f8564e1"
-SRC_URI[serde-1.0.139.sha256sum] = "0171ebb889e45aa68b44aee0859b3eede84c6f5f5c228e6f140c0b2a0a46cad6"
+SRC_URI[rpassword-7.4.0.sha256sum] = "66d4c8b64f049c6721ec8ccec37ddfc3d641c4a7fca57e8f2a89de509c73df39"
+SRC_URI[rpki-0.19.2.sha256sum] = "99010980abb0aee7a5c4b1c04d0f42f74f57ac168adb5d38a99b3517a4d72df9"
+SRC_URI[rsa-0.9.10.sha256sum] = "b8573f03f5883dcaebdfcf4725caa1ecb9c15b2ef50c43a07b816e06799bb12d"
+SRC_URI[rtoolbox-0.0.3.sha256sum] = "a7cc970b249fbe527d6e02e0a227762c9108b2f49d81094fe357ffc6d14d7f6f"
+SRC_URI[rustc-hash-2.1.1.sha256sum] = "357703d41365b4b27c590e3ed91eabb1b663f07c4c084095e60cbed4362dff0d"
+SRC_URI[rustc_version-0.4.1.sha256sum] = "cfcb3a22ef46e85b45de6ee7e79d063319ebb6594faafcf1c225ea92ab6e9b92"
+SRC_URI[rustix-1.1.3.sha256sum] = "146c9e247ccc180c1f61615433868c99f3de3ae256a30a43b49f67c2d9171f34"
+SRC_URI[rustls-0.23.36.sha256sum] = "c665f33d38cea657d9614f766881e4d510e0eda4239891eea56b4cadcf01801b"
+SRC_URI[rustls-native-certs-0.8.3.sha256sum] = "612460d5f7bea540c490b2b6395d8e34a953e52b491accd6c86c8164c5932a63"
+SRC_URI[rustls-pemfile-2.2.0.sha256sum] = "dce314e5fee3f39953d46bb63bb8a46d40c2f8fb7cc5a3b6cab2bde9721d6e50"
+SRC_URI[rustls-pki-types-1.14.0.sha256sum] = "be040f8b0a225e40375822a563fa9524378b9d63112f53e19ffff34df5d33fdd"
+SRC_URI[rustls-platform-verifier-0.6.2.sha256sum] = "1d99feebc72bae7ab76ba994bb5e121b8d83d910ca40b36e0921f53becc41784"
+SRC_URI[rustls-platform-verifier-android-0.1.1.sha256sum] = "f87165f0995f63a9fbeea62b64d10b4d9d8e78ec6d7d51fb2125fda7bb36788f"
+SRC_URI[rustls-webpki-0.103.9.sha256sum] = "d7df23109aa6c1567d1c575b9952556388da57401e4ace1d15f79eedad0d8f53"
+SRC_URI[rustversion-1.0.22.sha256sum] = "b39cdef0fa800fc44525c84ccb54a029961a8215f9619753635a9c0d2538d46d"
+SRC_URI[salsa20-0.10.2.sha256sum] = "97a22f5af31f73a954c10289c93e8a50cc23d971e80ee446f1f6f7137a088213"
+SRC_URI[same-file-1.0.6.sha256sum] = "93fc1dc3aaa9bfed95e02e6eadabb4baf7e3078b0bd1b4d7b6b0b68378900502"
+SRC_URI[schannel-0.1.28.sha256sum] = "891d81b926048e76efe18581bf793546b4c0eaf8448d72be8de2bbee5fd166e1"
+SRC_URI[scheduled-thread-pool-0.2.7.sha256sum] = "3cbc66816425a074528352f5789333ecff06ca41b36b0b0efdfbb29edc391a19"
+SRC_URI[schemars-0.9.0.sha256sum] = "4cd191f9397d57d581cddd31014772520aa448f65ef991055d7f61582c65165f"
+SRC_URI[schemars-1.2.1.sha256sum] = "a2b42f36aa1cd011945615b92222f6bf73c599a102a300334cd7f8dbeec726cc"
+SRC_URI[scopeguard-1.2.0.sha256sum] = "94143f37725109f92c262ed2cf5e59bce7498c01bcc1502d7b9afe439a4e9f49"
+SRC_URI[scrypt-0.11.0.sha256sum] = "0516a385866c09368f0b5bcd1caff3366aace790fcd46e2bb032697bb172fd1f"
+SRC_URI[sec1-0.7.3.sha256sum] = "d3e97a565f76233a6003f9f5c54be1d9c5bdfa3eccfb189469f11ec4901c47dc"
+SRC_URI[secrecy-0.10.3.sha256sum] = "e891af845473308773346dc847b2c23ee78fe442e0472ac50e22a18a93d3ae5a"
+SRC_URI[security-framework-3.6.0.sha256sum] = "d17b898a6d6948c3a8ee4372c17cb384f90d2e6e912ef00895b14fd7ab54ec38"
+SRC_URI[security-framework-sys-2.16.0.sha256sum] = "321c8673b092a9a42605034a9879d73cb79101ed5fd117bc9a597b89b4e9e61a"
+SRC_URI[semver-1.0.27.sha256sum] = "d767eb0aabc880b29956c35734170f26ed551a859dbd361d140cdbeca61ab1e2"
+SRC_URI[serde-1.0.228.sha256sum] = "9a8e94ea7f378bd32cbbd37198a4a91436180c5bb472411e48b5ec2e2124ae9e"
 SRC_URI[serde-value-0.7.0.sha256sum] = "f3a1a3341211875ef120e117ea7fd5228530ae7e7036a779fdc9117be6b3282c"
-SRC_URI[serde_bytes-0.11.6.sha256sum] = "212e73464ebcde48d723aa02eb270ba62eff38a9b732df31f33f1b4e145f3a54"
-SRC_URI[serde_derive-1.0.139.sha256sum] = "dc1d3230c1de7932af58ad8ffbe1d784bd55efd5a9d84ac24f69c72d83543dfb"
-SRC_URI[serde_json-1.0.82.sha256sum] = "82c2c1fdcd807d1098552c5b9a36e425e42e9fbd7c6a37a8425f390f781f7fa7"
-SRC_URI[serde_path_to_error-0.1.7.sha256sum] = "d7868ad3b8196a8a0aea99a8220b124278ee5320a55e4fde97794b6f85b1a377"
-SRC_URI[serde_urlencoded-0.7.1.sha256sum] = "d3491c14715ca2294c4d6a88f15e84739788c1d030eed8c110436aafdaa2f3fd"
-SRC_URI[sha2-0.9.9.sha256sum] = "4d58a1e1bf39749807d89cf2d98ac2dfa0ff1cb3faa38fbb64dd88ac8013d800"
-SRC_URI[sha2-0.10.2.sha256sum] = "55deaec60f81eefe3cce0dc50bda92d6d8e88f2a27df7c5033b42afeb1ed2676"
-SRC_URI[sharded-slab-0.1.4.sha256sum] = "900fba806f70c630b0a382d0d825e17a0f19fcd059a2ade1ff237bcddf446b31"
-SRC_URI[signal-hook-registry-1.4.0.sha256sum] = "e51e73328dc4ac0c7ccbda3a494dfa03df1de2f46018127f60c693f2648455b0"
-SRC_URI[siphasher-0.3.10.sha256sum] = "7bd3e3206899af3f8b12af284fafc038cc1dc2b41d1b89dd17297221c5d225de"
-SRC_URI[slab-0.4.6.sha256sum] = "eb703cfe953bccee95685111adeedb76fabe4e97549a58d16f03ea7b9367bb32"
-SRC_URI[slug-0.1.4.sha256sum] = "b3bc762e6a4b6c6fcaade73e77f9ebc6991b676f88bb2358bddb56560f073373"
-SRC_URI[smallvec-1.9.0.sha256sum] = "2fd0db749597d91ff862fd1d55ea87f7855a744a8425a64695b6fca237d1dad1"
-SRC_URI[socket2-0.4.4.sha256sum] = "66d72b759436ae32898a2af0a14218dbf55efde3feeb170eb623637db85ee1e0"
-SRC_URI[spin-0.5.2.sha256sum] = "6e63cff320ae2c57904679ba7cb63280a3dc4613885beafb148ee7bf9aa9042d"
-SRC_URI[string_cache-0.8.4.sha256sum] = "213494b7a2b503146286049378ce02b482200519accc31872ee8be91fa820a08"
-SRC_URI[strsim-0.8.0.sha256sum] = "8ea5119cdb4c55b55d432abb513a0429384878c15dde60cc77b1c99de1a95a6a"
-SRC_URI[subtle-2.4.1.sha256sum] = "6bdef32e8150c2a081110b42772ffe7d7c9032b606bc226c8260fd97e0976601"
-SRC_URI[syn-1.0.98.sha256sum] = "c50aef8a904de4c23c788f104b7dddc7d6f79c647c7c8ce4cc8f73eb0ca773dd"
-SRC_URI[syslog-4.0.1.sha256sum] = "a0641142b4081d3d44beffa4eefd7346a228cdf91ed70186db2ca2cef762d327"
-SRC_URI[target-lexicon-0.12.4.sha256sum] = "c02424087780c9b71cc96799eaeddff35af2bc513278cda5c99fc1f5d026d3c1"
-SRC_URI[tempfile-3.3.0.sha256sum] = "5cdb1ef4eaeeaddc8fbd371e5017057064af0911902ef36b39801f67cc6d79e4"
+SRC_URI[serde_bytes-0.11.19.sha256sum] = "a5d440709e79d88e51ac01c4b72fc6cb7314017bb7da9eeff678aa94c10e3ea8"
+SRC_URI[serde_core-1.0.228.sha256sum] = "41d385c7d4ca58e59fc732af25c3983b67ac852c1a25000afe1175de458b67ad"
+SRC_URI[serde_derive-1.0.228.sha256sum] = "d540f220d3187173da220f885ab66608367b6574e925011a9353e4badda91d79"
+SRC_URI[serde_json-1.0.149.sha256sum] = "83fc039473c5595ace860d8c4fafa220ff474b3fc6bfdb4293327f1a37e94d86"
+SRC_URI[serde_path_to_error-0.1.20.sha256sum] = "10a9ff822e371bb5403e391ecd83e182e0e77ba7f6fe0160b795797109d1b457"
+SRC_URI[serde_plain-1.0.2.sha256sum] = "9ce1fc6db65a611022b23a0dec6975d63fb80a302cb3388835ff02c097258d50"
+SRC_URI[serde_spanned-1.0.4.sha256sum] = "f8bbf91e5a4d6315eee45e704372590b30e260ee83af6639d64557f51b067776"
+SRC_URI[serde_with-3.16.1.sha256sum] = "4fa237f2807440d238e0364a218270b98f767a00d3dada77b1c53ae88940e2e7"
+SRC_URI[serde_with_macros-3.16.1.sha256sum] = "52a8e3ca0ca629121f70ab50f95249e5a6f925cc0f6ffe8256c45b728875706c"
+SRC_URI[sha2-0.10.9.sha256sum] = "a7507d819769d01a365ab707794a4084392c824f54a7a6a7862f8c3d0892b283"
+SRC_URI[shlex-1.3.0.sha256sum] = "0fda2ff0d084019ba4d7c6f371c95d8fd75ce3524c3cb8fb653a3023f6323e64"
+SRC_URI[signal-hook-registry-1.4.8.sha256sum] = "c4db69cba1110affc0e9f7bcd48bbf87b3f4fc7c61fc9155afd4c469eb3d6c1b"
+SRC_URI[signature-2.2.0.sha256sum] = "77549399552de45a898a580c1b41d445bf730df867cc44e6c0233bbc4b8329de"
+SRC_URI[siphasher-1.0.2.sha256sum] = "b2aa850e253778c88a04c3d7323b043aeda9d3e30d5971937c1855769763678e"
+SRC_URI[slab-0.4.12.sha256sum] = "0c790de23124f9ab44544d7ac05d60440adc586479ce501c1d6d7da3cd8c9cf5"
+SRC_URI[smallvec-1.15.1.sha256sum] = "67b1b7a3b5fe4f1376887184045fcf45c69e92af734b7aaddc05fb777b6fbd03"
+SRC_URI[socket2-0.6.2.sha256sum] = "86f4aa3ad99f2088c990dfa82d367e19cb29268ed67c574d10d0a4bfe71f07e0"
+SRC_URI[spin-0.9.8.sha256sum] = "6980e8d7511241f8acf4aebddbb1ff938df5eebe98691418c4468d0b72a96a67"
+SRC_URI[spki-0.7.3.sha256sum] = "d91ed6c858b01f942cd56b37a94b3e0a1798290327d1236e4d9cf4eaca44d29d"
+SRC_URI[stable_deref_trait-1.2.1.sha256sum] = "6ce2be8dc25455e1f91df71bfa12ad37d7af1092ae736f3a6cd0e37bc7810596"
+SRC_URI[stderrlog-0.6.0.sha256sum] = "61c910772f992ab17d32d6760e167d2353f4130ed50e796752689556af07dc6b"
+SRC_URI[string_cache-0.8.9.sha256sum] = "bf776ba3fa74f83bf4b63c3dcbbf82173db2632ed8452cb2d891d33f459de70f"
+SRC_URI[strsim-0.11.1.sha256sum] = "7da8b5736845d9f2fcb837ea5d9e2628564b3b043a70948a3f0b778838c5fb4f"
+SRC_URI[subtle-2.6.1.sha256sum] = "13c2bddecc57b384dee18652358fb23172facb8a2c51ccc10d74c157bdea3292"
+SRC_URI[syn-1.0.109.sha256sum] = "72b64191b275b66ffe2469e8af2c1cfe3bafa67b529ead792a6d0160888b4237"
+SRC_URI[syn-2.0.116.sha256sum] = "3df424c70518695237746f84cede799c9c58fcb37450d7b23716568cc8bc69cb"
+SRC_URI[sync_wrapper-1.0.2.sha256sum] = "0bf256ce5efdfa370213c1dabab5935a12e49f2c58d15e9eac2870d3b4f27263"
+SRC_URI[synstructure-0.13.2.sha256sum] = "728a70f3dbaf5bab7f0c4b1ac8d7ae5ea60a4b5549c8a5914361c99147a709d2"
+SRC_URI[syslog-7.0.0.sha256sum] = "019f1500a13379b7d051455df397c75770de6311a7a188a699499502704d9f10"
+SRC_URI[system-configuration-0.7.0.sha256sum] = "a13f3d0daba03132c0aa9767f98351b3488edc2c100cda2d2ec2b04f3d8d3c8b"
+SRC_URI[system-configuration-sys-0.6.0.sha256sum] = "8e1d1b10ced5ca923a1fcb8d03e96b8d3268065d724548c0211415ff6ac6bac4"
+SRC_URI[tar-0.4.44.sha256sum] = "1d863878d212c87a19c1a610eb53bb01fe12951c0501cf5a0d65f724914a667a"
+SRC_URI[tempfile-3.25.0.sha256sum] = "0136791f7c95b1f6dd99f9cc786b91bb81c3800b639b3478e561ddb7be95e5f1"
 SRC_URI[term-0.7.0.sha256sum] = "c59df8ac95d96ff9bede18eb7300b0fda5e5d8d90960e76f8e14ae765eedbf1f"
 SRC_URI[termcolor-1.1.3.sha256sum] = "bab24d30b911b2376f3a13cc2cd443142f0c81dda04c118693e35b3835757755"
-SRC_URI[textwrap-0.11.0.sha256sum] = "d326610f408c7a4eb6f51c37c330e496b08506c9457c9d34287ecc38809fb060"
-SRC_URI[thiserror-1.0.31.sha256sum] = "bd829fe32373d27f76265620b5309d0340cb8550f523c1dda251d6298069069a"
-SRC_URI[thiserror-impl-1.0.31.sha256sum] = "0396bc89e626244658bef819e22d0cc459e795a5ebe878e6ec336d1674a8d79a"
-SRC_URI[thread_local-1.1.4.sha256sum] = "5516c27b78311c50bf42c071425c560ac799b11c30b31f87e3081965fe5e0180"
-SRC_URI[time-0.1.44.sha256sum] = "6db9e6914ab8b1ae1c260a4ae7a49b6c5611b40328a735b21862567685e73255"
+SRC_URI[terminal_size-0.4.3.sha256sum] = "60b8cb979cb11c32ce1603f8137b22262a9d131aaa5c37b5678025f22b8becd0"
+SRC_URI[thiserror-1.0.69.sha256sum] = "b6aaf5339b578ea85b50e080feb250a3e8ae8cfcdff9a461c9ec2904bc923f52"
+SRC_URI[thiserror-2.0.18.sha256sum] = "4288b5bcbc7920c07a1149a35cf9590a2aa808e0bc1eafaade0b80947865fbc4"
+SRC_URI[thiserror-impl-1.0.69.sha256sum] = "4fee6c4efc90059e10f81e6d42c60a18f76588c3d74cb83a0b242a2b6c7504c1"
+SRC_URI[thiserror-impl-2.0.18.sha256sum] = "ebc4ee7f67670e9b64d05fa4253e753e016c6c95ff35b89b7941d6b856dec1d5"
+SRC_URI[thread_local-1.1.9.sha256sum] = "f60246a4944f24f6e018aa17cdeffb7818b76356965d03b07d6a9886e8962185"
+SRC_URI[time-0.3.47.sha256sum] = "743bd48c283afc0388f9b8827b976905fb217ad9e647fae3a379a9283c4def2c"
+SRC_URI[time-core-0.1.8.sha256sum] = "7694e1cfe791f8d31026952abf09c69ca6f6fa4e1a1229e18988f06a04a12dca"
+SRC_URI[time-macros-0.2.27.sha256sum] = "2e70e4c5a0e0a8a4823ad65dfe1a6930e4f4d756dcd9dd7939022b5e8c501215"
 SRC_URI[tiny-keccak-2.0.2.sha256sum] = "2c9d3793400a45f954c52e73d068316d76b6f4e36977e3fcebb13a2721e80237"
-SRC_URI[tiny_http-0.8.2.sha256sum] = "9ce51b50006056f590c9b7c3808c3bd70f0d1101666629713866c227d6e58d39"
-SRC_URI[tinyvec-1.6.0.sha256sum] = "87cc5ceb3875bb20c2890005a4e226a4651264a5c75edb2421b52861a0a0cb50"
-SRC_URI[tinyvec_macros-0.1.0.sha256sum] = "cda74da7e1a664f795bb1f8a87ec406fb89a02522cf6e50620d016add6dbbf5c"
-SRC_URI[tokio-1.20.4.sha256sum] = "eb78f30e4b41e98ca4cce5acb51168a033839a7af9e42b380355808e14e98ee0"
-SRC_URI[tokio-macros-1.8.0.sha256sum] = "9724f9a975fb987ef7a3cd9be0350edcbe130698af5b8f7a631e23d42d052484"
-SRC_URI[tokio-native-tls-0.3.0.sha256sum] = "f7d995660bd2b7f8c1568414c1126076c13fbb725c40112dc0120b78eb9b717b"
-SRC_URI[tokio-rustls-0.22.0.sha256sum] = "bc6844de72e57df1980054b38be3a9f4702aba4858be64dd700181a8a6d0e1b6"
-SRC_URI[tokio-util-0.7.3.sha256sum] = "cc463cd8deddc3770d20f9852143d50bf6094e640b485cb2e189a2099085ff45"
-SRC_URI[toml-0.5.9.sha256sum] = "8d82e1a7758622a465f8cee077614c73484dac5b836c02ff6a40d5d1010324d7"
-SRC_URI[tower-service-0.3.2.sha256sum] = "b6bc1c9ce2b5135ac7f93c72918fc37feb872bdc6a5533a8b85eb4b86bfdae52"
-SRC_URI[tracing-0.1.35.sha256sum] = "a400e31aa60b9d44a52a8ee0343b5b18566b03a8321e0d321f695cf56e940160"
-SRC_URI[tracing-attributes-0.1.22.sha256sum] = "11c75893af559bc8e10716548bdef5cb2b983f8e637db9d0e15126b61b484ee2"
-SRC_URI[tracing-core-0.1.28.sha256sum] = "7b7358be39f2f274f322d2aaed611acc57f382e8eb1e5b48cb9ae30933495ce7"
-SRC_URI[tracing-log-0.1.3.sha256sum] = "78ddad33d2d10b1ed7eb9d1f518a5674713876e97e5bb9b7345a7984fbb4f922"
-SRC_URI[tracing-serde-0.1.3.sha256sum] = "bc6b213177105856957181934e4920de57730fc69bf42c37ee5bb664d406d9e1"
-SRC_URI[tracing-subscriber-0.2.25.sha256sum] = "0e0d2eaa99c3c2e41547cfa109e910a68ea03823cccad4a0525dcbc9b01e8c71"
+SRC_URI[tinystr-0.8.2.sha256sum] = "42d3e9c45c09de15d06dd8acf5f4e0e399e85927b7f00711024eb7ae10fa4869"
+SRC_URI[tinyvec-1.10.0.sha256sum] = "bfa5fdc3bce6191a1dbc8c02d5c8bffcf557bafa17c124c5264a458f1b0613fa"
+SRC_URI[tinyvec_macros-0.1.1.sha256sum] = "1f3ccbac311fea05f86f61904b462b55fb3df8837a366dfc601a0161d0532f20"
+SRC_URI[tokio-1.49.0.sha256sum] = "72a2903cd7736441aac9df9d7688bd0ce48edccaadf181c3b90be801e81d3d86"
+SRC_URI[tokio-macros-2.6.0.sha256sum] = "af407857209536a95c8e56f8231ef2c2e2aff839b22e07a1ffcbc617e9db9fa5"
+SRC_URI[tokio-rustls-0.26.4.sha256sum] = "1729aa945f29d91ba541258c8df89027d5792d85a8841fb65e8bf0f4ede4ef61"
+SRC_URI[tokio-util-0.7.18.sha256sum] = "9ae9cec805b01e8fc3fd2fe289f89149a9b66dd16786abd8b19cfa7b48cb0098"
+SRC_URI[toml-0.9.12+spec-1.1.0.sha256sum] = "cf92845e79fc2e2def6a5d828f0801e29a2f8acc037becc5ab08595c7d5e9863"
+SRC_URI[toml_datetime-0.7.5+spec-1.1.0.sha256sum] = "92e1cfed4a3038bc5a127e35a2d360f145e1f4b971b551a2ba5fd7aedf7e1347"
+SRC_URI[toml_parser-1.0.9+spec-1.1.0.sha256sum] = "702d4415e08923e7e1ef96cd5727c0dfed80b4d2fa25db9647fe5eb6f7c5a4c4"
+SRC_URI[toml_writer-1.0.6+spec-1.1.0.sha256sum] = "ab16f14aed21ee8bfd8ec22513f7287cd4a91aa92e44edfe2c17ddd004e92607"
+SRC_URI[tower-0.5.3.sha256sum] = "ebe5ef63511595f1344e2d5cfa636d973292adc0eec1f0ad45fae9f0851ab1d4"
+SRC_URI[tower-http-0.6.8.sha256sum] = "d4e6559d53cc268e5031cd8429d05415bc4cb4aefc4aa5d6cc35fbf5b924a1f8"
+SRC_URI[tower-layer-0.3.3.sha256sum] = "121c2a6cda46980bb0fcd1647ffaf6cd3fc79a013de288782836f6df9c48780e"
+SRC_URI[tower-service-0.3.3.sha256sum] = "8df9b6e13f2d32c91b9bd719c00d1958837bc7dec474d94952798cc8e69eeec3"
+SRC_URI[tracing-0.1.44.sha256sum] = "63e71662fa4b2a2c3a26f570f037eb95bb1f85397f3cd8076caed2f026a6d100"
+SRC_URI[tracing-core-0.1.36.sha256sum] = "db97caf9d906fbde555dd62fa95ddba9eecfd14cb388e4f491a66d74cd5fb79a"
 SRC_URI[trait-set-0.2.0.sha256sum] = "875c4c873cc824e362fa9a9419ffa59807244824275a44ad06fec9684fff08f2"
-SRC_URI[try-lock-0.2.3.sha256sum] = "59547bce71d9c38b83d9c0e92b6066c4253371f15005def0c30d9657f50c7642"
-SRC_URI[typenum-1.15.0.sha256sum] = "dcf81ac59edc17cc8697ff311e8f5ef2d99fcbd9817b34cec66f90b6c3dfd987"
-SRC_URI[unicode-bidi-0.3.8.sha256sum] = "099b7128301d285f79ddd55b9a83d5e6b9e97c92e0ea0daebee7263e932de992"
-SRC_URI[unicode-ident-1.0.2.sha256sum] = "15c61ba63f9235225a22310255a29b806b907c9b8c964bcbd0a2c70f3f2deea7"
-SRC_URI[unicode-normalization-0.1.21.sha256sum] = "854cbdc4f7bc6ae19c820d44abdc3277ac3e1b2b93db20a636825d9322fb60e6"
-SRC_URI[unicode-width-0.1.9.sha256sum] = "3ed742d4ea2bd1176e236172c8429aaf54486e7ac098db29ffe6529e0ce50973"
-SRC_URI[unicode-xid-0.2.3.sha256sum] = "957e51f3646910546462e67d5f7599b9e4fb8acdd304b087a6494730f9eebf04"
-SRC_URI[untrusted-0.7.1.sha256sum] = "a156c684c91ea7d62626509bce3cb4e1d9ed5c4d978f7b4352658f96a4c26b4a"
-SRC_URI[url-2.2.2.sha256sum] = "a507c383b2d33b5fc35d1861e77e6b383d158b2da5e14fe51b83dfedf6fd578c"
+SRC_URI[try-lock-0.2.5.sha256sum] = "e421abadd41a4225275504ea4d6566923418b7f05506fbc9c0fe86ba7396114b"
+SRC_URI[typenum-1.19.0.sha256sum] = "562d481066bde0658276a35467c4af00bdc6ee726305698a55b86e61d7ad82bb"
+SRC_URI[unicode-ident-1.0.24.sha256sum] = "e6e4313cd5fcd3dad5cafa179702e2b244f760991f45397d14d4ebf38247da75"
+SRC_URI[unicode-normalization-0.1.25.sha256sum] = "5fd4f6878c9cb28d874b009da9e8d183b5abc80117c40bbd187a1fde336be6e8"
+SRC_URI[unicode-xid-0.2.6.sha256sum] = "ebc1c04c71510c7f702b52b7c350734c9ff1295c464a03335b00bb84fc54f853"
+SRC_URI[untrusted-0.9.0.sha256sum] = "8ecb6da28b8a351d773b68d5825ac39017e680750f980f3a1a85cd8dd28a47c1"
+SRC_URI[url-2.5.8.sha256sum] = "ff67a8a4397373c3ef660812acab3268222035010ab8680ec4215f38ba3d0eed"
 SRC_URI[urlparse-0.7.3.sha256sum] = "110352d4e9076c67839003c7788d8604e24dcded13e0b375af3efaa8cf468517"
-SRC_URI[uuid-1.1.2.sha256sum] = "dd6469f4314d5f1ffec476e05f17cc9a78bc7a27a6a857842170bdf8d6f98d2f"
-SRC_URI[valuable-0.1.0.sha256sum] = "830b7e5d4d90034032940e4ace0d9a9a057e7a45cd94e6c007832e39edb82f6d"
+SRC_URI[utf8_iter-1.0.4.sha256sum] = "b6c140620e7ffbb22c2dee59cafe6084a59b5ffc27a8859a5f0d494b5d52b6be"
+SRC_URI[utf8parse-0.2.2.sha256sum] = "06abde3611657adf66d383f00b093d7faecc7fa57071cce2578660c9f1010821"
+SRC_URI[uuid-1.21.0.sha256sum] = "b672338555252d43fd2240c714dc444b8c6fb0a5c5335e65a07bba7742735ddb"
 SRC_URI[vcpkg-0.2.15.sha256sum] = "accd4ea62f7bb7a82fe23066fb0957d48ef677f6eeb8215f372f52e48bb32426"
-SRC_URI[vec_map-0.8.2.sha256sum] = "f1bddf1187be692e79c5ffeab891132dfb0f236ed36a43c7ed39f1165ee20191"
-SRC_URI[version_check-0.9.4.sha256sum] = "49874b5167b65d7193b8aba1567f5c7d93d001cafc34600cee003eda787e483f"
-SRC_URI[want-0.3.0.sha256sum] = "1ce8a968cb1cd110d136ff8b819a556d6fb6d919363c61534f6860c7eb172ba0"
-SRC_URI[wasi-0.10.0+wasi-snapshot-preview1.sha256sum] = "1a143597ca7c7793eff794def352d41792a93c481eb1042423ff7ff72ba2c31f"
-SRC_URI[wasi-0.11.0+wasi-snapshot-preview1.sha256sum] = "9c8d87e72b64a3b4db28d11ce29237c246188f4f51057d65a7eab63b7987e423"
-SRC_URI[wasm-bindgen-0.2.81.sha256sum] = "7c53b543413a17a202f4be280a7e5c62a1c69345f5de525ee64f8cfdbc954994"
-SRC_URI[wasm-bindgen-backend-0.2.81.sha256sum] = "5491a68ab4500fa6b4d726bd67408630c3dbe9c4fe7bda16d5c82a1fd8c7340a"
-SRC_URI[wasm-bindgen-futures-0.4.31.sha256sum] = "de9a9cec1733468a8c657e57fa2413d2ae2c0129b95e87c5b72b8ace4d13f31f"
-SRC_URI[wasm-bindgen-macro-0.2.81.sha256sum] = "c441e177922bc58f1e12c022624b6216378e5febc2f0533e41ba443d505b80aa"
-SRC_URI[wasm-bindgen-macro-support-0.2.81.sha256sum] = "7d94ac45fcf608c1f45ef53e748d35660f168490c10b23704c7779ab8f5c3048"
-SRC_URI[wasm-bindgen-shared-0.2.81.sha256sum] = "6a89911bd99e5f3659ec4acf9c4d93b0a90fe4a2a11f15328472058edc5261be"
-SRC_URI[web-sys-0.3.58.sha256sum] = "2fed94beee57daf8dd7d51f2b15dc2bcde92d7a72304cdf662a4371008b71b90"
-SRC_URI[webpki-0.21.4.sha256sum] = "b8e38c0608262c46d4a56202ebabdeb094cef7e560ca7a226c6bf055188aa4ea"
+SRC_URI[version_check-0.9.5.sha256sum] = "0b928f33d975fc6ad9f86c8f283853ad26bdd5b10b7f1542aa2fa15e2289105a"
+SRC_URI[walkdir-2.5.0.sha256sum] = "29790946404f91d9c5d06f9874efddea1dc06c5efe94541a7d6863108e3a5e4b"
+SRC_URI[want-0.3.1.sha256sum] = "bfa7760aed19e106de2c7c0b581b509f2f25d3dacaf737cb82ac61bc6d760b0e"
+SRC_URI[wasi-0.11.1+wasi-snapshot-preview1.sha256sum] = "ccf3ec651a847eb01de73ccad15eb7d99f80485de043efb2f370cd654f4ea44b"
+SRC_URI[wasip2-1.0.2+wasi-0.2.9.sha256sum] = "9517f9239f02c069db75e65f174b3da828fe5f5b945c4dd26bd25d89c03ebcf5"
+SRC_URI[wasip3-0.4.0+wasi-0.3.0-rc-2026-01-06.sha256sum] = "5428f8bf88ea5ddc08faddef2ac4a67e390b88186c703ce6dbd955e1c145aca5"
+SRC_URI[wasm-bindgen-0.2.108.sha256sum] = "64024a30ec1e37399cf85a7ffefebdb72205ca1c972291c51512360d90bd8566"
+SRC_URI[wasm-bindgen-futures-0.4.58.sha256sum] = "70a6e77fd0ae8029c9ea0063f87c46fde723e7d887703d74ad2616d792e51e6f"
+SRC_URI[wasm-bindgen-macro-0.2.108.sha256sum] = "008b239d9c740232e71bd39e8ef6429d27097518b6b30bdf9086833bd5b6d608"
+SRC_URI[wasm-bindgen-macro-support-0.2.108.sha256sum] = "5256bae2d58f54820e6490f9839c49780dff84c65aeab9e772f15d5f0e913a55"
+SRC_URI[wasm-bindgen-shared-0.2.108.sha256sum] = "1f01b580c9ac74c8d8f0c0e4afb04eeef2acf145458e52c03845ee9cd23e3d12"
+SRC_URI[wasm-encoder-0.244.0.sha256sum] = "990065f2fe63003fe337b932cfb5e3b80e0b4d0f5ff650e6985b1048f62c8319"
+SRC_URI[wasm-metadata-0.244.0.sha256sum] = "bb0e353e6a2fbdc176932bbaab493762eb1255a7900fe0fea1a2f96c296cc909"
+SRC_URI[wasmparser-0.244.0.sha256sum] = "47b807c72e1bac69382b3a6fb3dbe8ea4c0ed87ff5629b8685ae6b9a611028fe"
+SRC_URI[web-sys-0.3.85.sha256sum] = "312e32e551d92129218ea9a2452120f4aabc03529ef03e4d0d82fb2780608598"
+SRC_URI[web-time-1.1.0.sha256sum] = "5a6580f308b1fad9207618087a65c04e7a10bc77e02c8e84e9b00dd4b12fa0bb"
+SRC_URI[webpki-root-certs-1.0.6.sha256sum] = "804f18a4ac2676ffb4e8b5b5fa9ae38af06df08162314f96a68d2a363e21a8ca"
 SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419"
 SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
-SRC_URI[winapi-util-0.1.5.sha256sum] = "70ec6ce85bb158151cae5e5c87f95a8e97d2c0c4b001223f33a334e3ce5de178"
+SRC_URI[winapi-util-0.1.11.sha256sum] = "c2a7b1c03c876122aa43f3020e6c3c3ee5c05081c9a00739faf7503aeba10d22"
 SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
-SRC_URI[windows-sys-0.36.1.sha256sum] = "ea04155a16a59f9eab786fe12a4a450e75cdb175f9e0d80da1e17db09f55b8d2"
-SRC_URI[windows_aarch64_msvc-0.36.1.sha256sum] = "9bb8c3fd39ade2d67e9874ac4f3db21f0d710bee00fe7cab16949ec184eeaa47"
-SRC_URI[windows_i686_gnu-0.36.1.sha256sum] = "180e6ccf01daf4c426b846dfc66db1fc518f074baa793aa7d9b9aaeffad6a3b6"
-SRC_URI[windows_i686_msvc-0.36.1.sha256sum] = "e2e7917148b2812d1eeafaeb22a97e4813dfa60a3f8f78ebe204bcc88f12f024"
-SRC_URI[windows_x86_64_gnu-0.36.1.sha256sum] = "4dcd171b8776c41b97521e5da127a2d86ad280114807d0b2ab1e462bc764d9e1"
-SRC_URI[windows_x86_64_msvc-0.36.1.sha256sum] = "c811ca4a8c853ef420abd8592ba53ddbbac90410fab6903b3e79972a631f7680"
-SRC_URI[winreg-0.10.1.sha256sum] = "80d0f4e272c85def139476380b12f9ac60926689dd2e01d4923222f40580869d"
+SRC_URI[windows-core-0.62.2.sha256sum] = "b8e83a14d34d0623b51dce9581199302a221863196a1dde71a7663a4c2be9deb"
+SRC_URI[windows-implement-0.60.2.sha256sum] = "053e2e040ab57b9dc951b72c264860db7eb3b0200ba345b4e4c3b14f67855ddf"
+SRC_URI[windows-interface-0.59.3.sha256sum] = "3f316c4a2570ba26bbec722032c4099d8c8bc095efccdc15688708623367e358"
+SRC_URI[windows-link-0.2.1.sha256sum] = "f0805222e57f7521d6a62e36fa9163bc891acd422f971defe97d64e70d0a4fe5"
+SRC_URI[windows-registry-0.6.1.sha256sum] = "02752bf7fbdcce7f2a27a742f798510f3e5ad88dbe84871e5168e2120c3d5720"
+SRC_URI[windows-result-0.4.1.sha256sum] = "7781fa89eaf60850ac3d2da7af8e5242a5ea78d1a11c49bf2910bb5a73853eb5"
+SRC_URI[windows-strings-0.5.1.sha256sum] = "7837d08f69c77cf6b07689544538e017c1bfcf57e34b4c0ff58e6c2cd3b37091"
+SRC_URI[windows-sys-0.45.0.sha256sum] = "75283be5efb2831d37ea142365f009c02ec203cd29a3ebecbc093d52315b66d0"
+SRC_URI[windows-sys-0.52.0.sha256sum] = "282be5f36a8ce781fad8c8ae18fa3f9beff57ec1b52cb3de0789201425d9a33d"
+SRC_URI[windows-sys-0.59.0.sha256sum] = "1e38bc4d79ed67fd075bcc251a1c39b32a1776bbe92e5bef1f0bf1f8c531853b"
+SRC_URI[windows-sys-0.60.2.sha256sum] = "f2f500e4d28234f72040990ec9d39e3a6b950f9f22d3dba18416c35882612bcb"
+SRC_URI[windows-sys-0.61.2.sha256sum] = "ae137229bcbd6cdf0f7b80a31df61766145077ddf49416a728b02cb3921ff3fc"
+SRC_URI[windows-targets-0.42.2.sha256sum] = "8e5180c00cd44c9b1c88adb3693291f1cd93605ded80c250a75d472756b4d071"
+SRC_URI[windows-targets-0.52.6.sha256sum] = "9b724f72796e036ab90c1021d4780d4d3d648aca59e491e6b98e725b84e99973"
+SRC_URI[windows-targets-0.53.5.sha256sum] = "4945f9f551b88e0d65f3db0bc25c33b8acea4d9e41163edf90dcd0b19f9069f3"
+SRC_URI[windows_aarch64_gnullvm-0.42.2.sha256sum] = "597a5118570b68bc08d8d59125332c54f1ba9d9adeedeef5b99b02ba2b0698f8"
+SRC_URI[windows_aarch64_gnullvm-0.52.6.sha256sum] = "32a4622180e7a0ec044bb555404c800bc9fd9ec262ec147edd5989ccd0c02cd3"
+SRC_URI[windows_aarch64_gnullvm-0.53.1.sha256sum] = "a9d8416fa8b42f5c947f8482c43e7d89e73a173cead56d044f6a56104a6d1b53"
+SRC_URI[windows_aarch64_msvc-0.42.2.sha256sum] = "e08e8864a60f06ef0d0ff4ba04124db8b0fb3be5776a5cd47641e942e58c4d43"
+SRC_URI[windows_aarch64_msvc-0.52.6.sha256sum] = "09ec2a7bb152e2252b53fa7803150007879548bc709c039df7627cabbd05d469"
+SRC_URI[windows_aarch64_msvc-0.53.1.sha256sum] = "b9d782e804c2f632e395708e99a94275910eb9100b2114651e04744e9b125006"
+SRC_URI[windows_i686_gnu-0.42.2.sha256sum] = "c61d927d8da41da96a81f029489353e68739737d3beca43145c8afec9a31a84f"
+SRC_URI[windows_i686_gnu-0.52.6.sha256sum] = "8e9b5ad5ab802e97eb8e295ac6720e509ee4c243f69d781394014ebfe8bbfa0b"
+SRC_URI[windows_i686_gnu-0.53.1.sha256sum] = "960e6da069d81e09becb0ca57a65220ddff016ff2d6af6a223cf372a506593a3"
+SRC_URI[windows_i686_gnullvm-0.52.6.sha256sum] = "0eee52d38c090b3caa76c563b86c3a4bd71ef1a819287c19d586d7334ae8ed66"
+SRC_URI[windows_i686_gnullvm-0.53.1.sha256sum] = "fa7359d10048f68ab8b09fa71c3daccfb0e9b559aed648a8f95469c27057180c"
+SRC_URI[windows_i686_msvc-0.42.2.sha256sum] = "44d840b6ec649f480a41c8d80f9c65108b92d89345dd94027bfe06ac444d1060"
+SRC_URI[windows_i686_msvc-0.52.6.sha256sum] = "240948bc05c5e7c6dabba28bf89d89ffce3e303022809e73deaefe4f6ec56c66"
+SRC_URI[windows_i686_msvc-0.53.1.sha256sum] = "1e7ac75179f18232fe9c285163565a57ef8d3c89254a30685b57d83a38d326c2"
+SRC_URI[windows_x86_64_gnu-0.42.2.sha256sum] = "8de912b8b8feb55c064867cf047dda097f92d51efad5b491dfb98f6bbb70cb36"
+SRC_URI[windows_x86_64_gnu-0.52.6.sha256sum] = "147a5c80aabfbf0c7d901cb5895d1de30ef2907eb21fbbab29ca94c5b08b1a78"
+SRC_URI[windows_x86_64_gnu-0.53.1.sha256sum] = "9c3842cdd74a865a8066ab39c8a7a473c0778a3f29370b5fd6b4b9aa7df4a499"
+SRC_URI[windows_x86_64_gnullvm-0.42.2.sha256sum] = "26d41b46a36d453748aedef1486d5c7a85db22e56aff34643984ea85514e94a3"
+SRC_URI[windows_x86_64_gnullvm-0.52.6.sha256sum] = "24d5b23dc417412679681396f2b49f3de8c1473deb516bd34410872eff51ed0d"
+SRC_URI[windows_x86_64_gnullvm-0.53.1.sha256sum] = "0ffa179e2d07eee8ad8f57493436566c7cc30ac536a3379fdf008f47f6bb7ae1"
+SRC_URI[windows_x86_64_msvc-0.42.2.sha256sum] = "9aec5da331524158c6d1a4ac0ab1541149c0b9505fde06423b02f5ef0106b9f0"
+SRC_URI[windows_x86_64_msvc-0.52.6.sha256sum] = "589f6da84c646204747d1270a2a5661ea66ed1cced2631d546fdfb155959f9ec"
+SRC_URI[windows_x86_64_msvc-0.53.1.sha256sum] = "d6bbff5f0aada427a1e5a6da5f1f98158182f26556f345ac9e04d36d0ebed650"
+SRC_URI[winnow-0.7.14.sha256sum] = "5a5364e9d77fcdeeaa6062ced926ee3381faa2ee02d3eb83a5c27a8825540829"
+SRC_URI[wit-bindgen-0.51.0.sha256sum] = "d7249219f66ced02969388cf2bb044a09756a083d0fab1e566056b04d9fbcaa5"
+SRC_URI[wit-bindgen-core-0.51.0.sha256sum] = "ea61de684c3ea68cb082b7a88508a8b27fcc8b797d738bfc99a82facf1d752dc"
+SRC_URI[wit-bindgen-rust-0.51.0.sha256sum] = "b7c566e0f4b284dd6561c786d9cb0142da491f46a9fbed79ea69cdad5db17f21"
+SRC_URI[wit-bindgen-rust-macro-0.51.0.sha256sum] = "0c0f9bfd77e6a48eccf51359e3ae77140a7f50b1e2ebfe62422d8afdaffab17a"
+SRC_URI[wit-component-0.244.0.sha256sum] = "9d66ea20e9553b30172b5e831994e35fbde2d165325bec84fc43dbf6f4eb9cb2"
+SRC_URI[wit-parser-0.244.0.sha256sum] = "ecc8ac4bc1dc3381b7f59c34f00b67e18f910c2c0f50015669dde7def656a736"
+SRC_URI[writeable-0.6.2.sha256sum] = "9edde0db4769d2dc68579893f2306b26c6ecfbe0ef499b013d731b7b9247e0b9"
+SRC_URI[xattr-1.6.1.sha256sum] = "32e45ad4206f6d2479085147f02bc2ef834ac85886624a23575ae137c8aa8156"
+SRC_URI[yoke-0.8.1.sha256sum] = "72d6e5c6afb84d73944e5cedb052c4680d5657337201555f9f2a16b7406d4954"
+SRC_URI[yoke-derive-0.8.1.sha256sum] = "b659052874eb698efe5b9e8cf382204678a0086ebf46982b79d6ca3182927e5d"
+SRC_URI[zerocopy-0.8.39.sha256sum] = "db6d35d663eadb6c932438e763b262fe1a70987f9ae936e60158176d710cae4a"
+SRC_URI[zerocopy-derive-0.8.39.sha256sum] = "4122cd3169e94605190e77839c9a40d40ed048d305bfdc146e7df40ab0f3e517"
+SRC_URI[zerofrom-0.1.6.sha256sum] = "50cc42e0333e05660c3587f3bf9d0478688e15d870fab3346451ce7f8c9fbea5"
+SRC_URI[zerofrom-derive-0.1.6.sha256sum] = "d71e5d6e06ab090c67b5e44993ec16b72dcbaabc526db883a360057678b48502"
+SRC_URI[zeroize-1.8.2.sha256sum] = "b97154e67e32c85465826e8bcc1c59429aaaf107c1e4a9e53c8d8ccd5eff88d0"
+SRC_URI[zerotrie-0.2.3.sha256sum] = "2a59c17a5562d507e4b54960e8569ebee33bee890c70aa3fe7b97e85a9fd7851"
+SRC_URI[zerovec-0.11.5.sha256sum] = "6c28719294829477f525be0186d13efa9a3c602f7ec202ca9e353d310fb9a002"
+SRC_URI[zerovec-derive-0.11.2.sha256sum] = "eadce39539ca5cb3985590102671f2567e659fca9666581ad3411d59207951f3"
+SRC_URI[zmij-1.0.21.sha256sum] = "b8848ee67ecc8aedbaf3e4122217aff892639231befc6a1b58d29fff4c2cabaa"
diff --git a/recipes-security/krill/krill_0.12.3.bb b/recipes-security/krill/krill_0.16.0.bb
similarity index 89%
rename from recipes-security/krill/krill_0.12.3.bb
rename to recipes-security/krill/krill_0.16.0.bb
index 2a10584..1a82dc1 100644
--- a/recipes-security/krill/krill_0.12.3.bb
+++ b/recipes-security/krill/krill_0.16.0.bb
@@ -5,10 +5,10 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=9741c346eef56131163e13b9db1241b3"
 
 DEPENDS = "openssl"
 
-# SRC_URI += "crate://crates.io/krill/0.9.1"
-SRC_URI = "git://github.com/NLnetLabs/krill.git;protocol=https;branch=main"
-SRCREV = "e92098419c7ad82939e0483bc76df21eff705b80"
-SRC_URI += "file://panic_workaround.patch"
+SRC_URI = "git://github.com/NLnetLabs/krill.git;protocol=https;branch=main \
+           file://0001-Disable-abort-on-panic.patch \
+"
+SRCREV = "b2a26cd9f44a385d8a62a0199b082f44e5062039"
 
 include krill-crates.inc
 
-- 
2.55.0


