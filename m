Return-Path: <alba@thehoodiefirm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D730E63C8C
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 14:02:53 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13895.1769608971156519721
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Jan 2026 06:02:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@thehoodiefirm-com.20230601.gappssmtp.com header.s=20230601 header.b=LuncD8oC;
 spf=neutral (domain: thehoodiefirm.com, ip: 209.85.128.41, mailfrom: alba@thehoodiefirm.com)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4806ce0f97bso8199685e9.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Jan 2026 06:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thehoodiefirm-com.20230601.gappssmtp.com; s=20230601; t=1769608969; x=1770213769; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHOIglpygeJV22wLQbhjN2W/GIZmY+FjGGAqgppI6/w=;
        b=LuncD8oCqgQlg85/pJAcY5rEdykm4E5adFewCI9sIRKCyth0SDlFampzmQss1T/+93
         iYXVkWurPYKQULptQwLIk7vhvMIq45FNFxFsiPyhWUhT1ShMCI9gdOmSTsdWpXZDAeXA
         Wb/Y/Hi70YZrvtHGuP/cqGO1wcUX9bj7XADY4Aadv3jDNCdyCaN4Lu7RupRoLFJHTOQy
         n9hNgNhpOE/pdkhQkQpWv6TzEL7bGCs3mXcHuIXwd/5HF++RKLwAo9uB6VIe3zQwCTEk
         SyuSHjX10t/3TF+eJ1lQ8pYMAMKP4E02/z6Z0J1fuuSzGTqmwELDBnkbcVIMgtBD+r2B
         qyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769608969; x=1770213769;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHOIglpygeJV22wLQbhjN2W/GIZmY+FjGGAqgppI6/w=;
        b=guwdqsv+Jf2644LE8ZynbDkH0MfJWqabZu8wCtElboWvfcqNZ1eo3lqbpsRqAIXPHG
         r6RIz+TA1QSyQI70mhS2xbnuhm1yhA+v5UwrTBb1rZb4xMP5AA774uc1pJt/o68g/NuJ
         L0PbF87v+oXGH03e5KNwiPrWxrNtRzA0AOF6Qb/jGpgcaXiAIfyLjI41fFexRdqwSA22
         EVfhCs5dM2IJUydcvBJ+WdOL8FGxlIkVDwnIKbjOULIBlFUteOYjam9bxGy+4DlrtkXQ
         rVOtn3z+7BwLY0yjWcD5Jnd2UgJk1Cp42n5ryoQ8Buxgl6Djg8kMQa5mth6oIco/C0oe
         lzTA==
X-Gm-Message-State: AOJu0YxC9hdXuw2qNCRgd3vVWLuD+UPuT6gHOFFD9PanlaI2QS7mgg0r
	A7gWE0x6L/Yw3stNkLjwkFp8x0nF0UneQan1oNLbR7kQXfxvHxXWoRKhMCrtgFhqun826+0l7Zm
	2iy1etEc=
X-Gm-Gg: AZuq6aKpIE93AdT6FxFUITsPrwrsGh469h41RT1E66GkozxJCQHOhKk1W8zHkADYvBB
	vau1oEmp2fDmq9zSIjRRIfLs78awBlfGkw+ntdJkXkVHiCuiy4JfZ3yHag8VUFIHZHAb4iAfW7J
	CFf0gMSqzIOnPWeuvEwHY/rc3z+qknKei4l6AqaVn6Kc959IaxjM1lF+uWdURFVegHStN+DOHp8
	QYJFwgP/DUNSdnWLmf/ZvDbQwpm87OBBp5/wUFu4jhnWsNc5aNpJfrqspPbte3tpg3sJD9A41M/
	ACDgrOGPWLVjF8WL9E2E+KU0tqXH4EefrYsBjif26HVuj59Aj2TjsKrJHh8GWYdixzlVtM/yVsO
	GzA93ZwKnaJz+kfCkN58/9mtwwmolYzPIeb1xOfjb0bf0kAUH7meyCkr1wOh3lGdbPi50iob20+
	abIRdabs41rFj9TpJTK8ktylYjPdBdoEhiw2JgokAFzbI0eJOL++saG5TTgtFxlIHMs7d79vpfw
	wEJZXC8I2wEAog=
X-Received: by 2002:a05:600c:458a:b0:47b:e2a9:2bd7 with SMTP id 5b1f17b1804b1-48069c6970fmr62343545e9.19.1769608967575;
        Wed, 28 Jan 2026 06:02:47 -0800 (PST)
Received: from localhost.localdomain (253.red-83-57-139.dynamicip.rima-tde.net. [83.57.139.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cdd78d3sm68522105e9.1.2026.01.28.06.02.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Jan 2026 06:02:46 -0800 (PST)
Sender: =?UTF-8?B?QWxiYSBIZXJyZXLDrWFzIFJhbcOtcmV6?= <alba@thehoodiefirm.com>
From: Alba Herrerias <alba@neighbourhood.ie>
X-Google-Original-From: Alba Herrerias <albaherreriasdev@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: engineering@neighbourhood.ie,
	Alex Feyerke <alex@neighbourhood.ie>
Subject: [yocto-autobuilder-helper][PATCH 1/4] dashboard: update to unify styles with CVE/Patch Metrics pages
Date: Wed, 28 Jan 2026 14:02:04 +0000
Message-Id: <20260128140207.61443-2-albaherreriasdev@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20260128140207.61443-1-albaherreriasdev@gmail.com>
References: <20260128140207.61443-1-albaherreriasdev@gmail.com>
Reply-To: engineering@neighbourhood.ie
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Jan 2026 14:02:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3132

From: Alex Feyerke <alex@neighbourhood.ie>

Signed-off-by: Alex Feyerke <alex@neighbourhood.ie>
---
 scripts/dashboard/index.html                  |  77 ++++++++++--------
 .../dashboard/resources/apple-touch-icon.png  | Bin 0 -> 7683 bytes
 scripts/dashboard/resources/favicon-16x16.png | Bin 0 -> 792 bytes
 scripts/dashboard/resources/favicon-32x32.png | Bin 0 -> 1246 bytes
 .../resources/pico.fluid.classless.min.css    |   4 +
 scripts/dashboard/resources/shared-styles.css |  75 +++++++++++++++++
 6 files changed, 123 insertions(+), 33 deletions(-)
 create mode 100644 scripts/dashboard/resources/apple-touch-icon.png
 create mode 100644 scripts/dashboard/resources/favicon-16x16.png
 create mode 100644 scripts/dashboard/resources/favicon-32x32.png
 create mode 100644 scripts/dashboard/resources/pico.fluid.classless.min.css
 create mode 100644 scripts/dashboard/resources/shared-styles.css

diff --git a/scripts/dashboard/index.html b/scripts/dashboard/index.html
index 5cff80a..86b4cb8 100644
--- a/scripts/dashboard/index.html
+++ b/scripts/dashboard/index.html
@@ -1,39 +1,50 @@
 <!DOCTYPE html>
 <html>
+
 <head>
-<title>Yocto Project Dashboard</title>
-<style>
-html { color-scheme: light dark; }
-body { width: 35em; margin: 0 auto;
-font-family: Tahoma, Verdana, Arial, sans-serif; }
-</style>
+  <title>Yocto Project Dashboard</title>
+  <meta name=3D"viewport" content=3D"width=3Ddevice-width, initial-scale=
=3D1.0">
+  <link rel=3D"stylesheet" href=3D"resources/pico.fluid.classless.min.css">
+  <link rel=3D"stylesheet" href=3D"resources/shared-styles.css">
+  <link rel=3D"apple-touch-icon" sizes=3D"144x144" href=3D"resources/apple=
-touch-icon.png">
+  <link rel=3D"icon" type=3D"image/png" sizes=3D"32x32" href=3D"resources/=
favicon-32x32.png">
+  <link rel=3D"icon" type=3D"image/png" sizes=3D"16x16" href=3D"resources/=
favicon-16x16.png">
 </head>
+
 <body>
-<h1>Yocto Project Dashboard</h1>
-<p>Current project status is included in the <a href=3D"https://wiki.yocto=
project.org/wiki/Weekly_Status">Weekly Status Report</a></p>
-<p>Links to our commonly used tools and the data they generate:</p>
-<ul>
-<li><a href=3D"https://autobuilder.yoctoproject.org/valkyrie/#/console">CI=
 Main Console (Valkyrie autobuilder)</a></li>
-<li><a href=3D"https://valkyrie.yocto.io/pub/non-release/">Autobuilder res=
ults index</a> (build performance, buildhistory, ptest and test result repo=
rts)</li>
-<li><a href=3D"https://valkyrie.yocto.io/pub/non-release/abint/">Autobuild=
er Intermittent Issue Heatmap/Summary</a></li>
-<li>CVE Status and Patch Metrics: <a href=3D"https://valkyrie.yocto.io/pub=
/non-release/patchmetrics/">OE-Core</a> <a href=3D"https://valkyrie.yocto.i=
o/pub/non-release/patchmetrics-meta-oe/">Meta-OpenEmbedded</a></li>
-<li>Git Repository Statistics: <a href=3D"https://dashboard.yoctoproject.o=
rg/gitstats/poky/">Poky</a> <a href=3D"https://dashboard.yoctoproject.org/g=
itstats/oecore/">OE-Core</a> <a href=3D"https://dashboard.yoctoproject.org/=
gitstats/bitbake/">Bitbake</a> <a href=3D"https://dashboard.yoctoproject.or=
g/gitstats/meta-openembedded/">Meta-OE</a></li>
-<li><a href=3D"bugtriage/">Bug Triage</a></li>
-</ul>
-<p>Other useful links:</p>
-</p>
-<ul>
-<li><a href=3D"https://www.yoctoproject.org/development/releases/">Release=
 Information</a></li>
-<li><a href=3D"https://valkyrie.yocto.io/pub/">Autobuilder unreleased buil=
d output</a></li>
-<li><a href=3D"https://swatbot.yoctoproject.org/">Swatbot - CI failure tri=
age system</a></li>
-<li><a href=3D"https://errors.yoctoproject.org/">Error Reporting System</a=
></li>
-<li><a href=3D"https://layers.openembedded.org/">Layer Index</a></li>
-<li><a href=3D"https://git.yoctoproject.org/">Yocto Project Source Code Re=
positories (git)</a></li>
-<li><a href=3D"https://git.openembedded.org/">OpenEmbedded Source Code Rep=
ositories (git)</a></li>
-<li><a href=3D"https://bugzilla.yoctoproject.org/">Yocto Project Bugzilla<=
/a></li>
-<li><a href=3D"https://www.yoctoproject.org/development/yocto-project-comp=
atible-layers/">Yocto Project Compatible Layers</a></li>
-<li><a href=3D"https://www.yoctoproject.org/reproducible-build-results/">R=
eproducibile Build Status</a></li>
-<li><a href=3D"https://lore.kernel.org/">Lore Public Inbox for mailing lis=
ts</a></li>
-</ul>
+  <main>
+    <h1 class=3D"with-logo">Yocto Project Dashboard</h1>
+    <section>
+      <p>Current project status is included in the <a href=3D"https://wiki=
.yoctoproject.org/wiki/Weekly_Status">Weekly Status Report</a></p>
+      <ul>
+        <li><a href=3D"bugzilla_stats.html">BugZilla Statistics</a></li>
+      </ul>
+      <p>Links to our commonly used tools and the data they generate:</p>
+      <ul>
+        <li><a href=3D"https://autobuilder.yoctoproject.org/valkyrie/#/con=
sole">CI Main Console (Valkyrie autobuilder)</a></li>
+        <li><a href=3D"https://valkyrie.yocto.io/pub/non-release/">Autobui=
lder results index</a> (build performance, buildhistory, ptest and test res=
ult reports)</li>
+        <li><a href=3D"https://valkyrie.yocto.io/pub/non-release/abint/">A=
utobuilder Intermittent Issue Heatmap/Summary</a></li>
+        <li>CVE Status and Patch Metrics: <a href=3D"https://valkyrie.yoct=
o.io/pub/non-release/patchmetrics/">OE-Core</a> <a href=3D"https://valkyrie=
.yocto.io/pub/non-release/patchmetrics-meta-oe/">Meta-OpenEmbedded</a></li>
+        <li>Git Repository Statistics: <a href=3D"https://dashboard.yoctop=
roject.org/gitstats/poky/">Poky</a> <a href=3D"https://dashboard.yoctoproje=
ct.org/gitstats/oecore/">OE-Core</a> <a href=3D"https://dashboard.yoctoproj=
ect.org/gitstats/bitbake/">Bitbake</a> <a href=3D"https://dashboard.yoctopr=
oject.org/gitstats/meta-openembedded/">Meta-OE</a></li>
+        <li><a href=3D"bugtriage/">Bug Triage</a></li>
+      </ul>
+      <p>Other useful links:</p>
+      </p>
+      <ul>
+        <li><a href=3D"https://www.yoctoproject.org/development/releases/"=
>Release Information</a></li>
+        <li><a href=3D"https://valkyrie.yocto.io/pub/">Autobuilder unrelea=
sed build output</a></li>
+        <li><a href=3D"https://swatbot.yoctoproject.org/">Swatbot - CI fai=
lure triage system</a></li>
+        <li><a href=3D"https://errors.yoctoproject.org/">Error Reporting S=
ystem</a></li>
+        <li><a href=3D"https://layers.openembedded.org/">Layer Index</a></=
li>
+        <li><a href=3D"https://git.yoctoproject.org/">Yocto Project Source=
 Code Repositories (git)</a></li>
+        <li><a href=3D"https://git.openembedded.org/">OpenEmbedded Source =
Code Repositories (git)</a></li>
+        <li><a href=3D"https://bugzilla.yoctoproject.org/">Yocto Project B=
ugzilla</a></li>
+        <li><a href=3D"https://www.yoctoproject.org/development/yocto-proj=
ect-compatible-layers/">Yocto Project Compatible Layers</a></li>
+        <li><a href=3D"https://www.yoctoproject.org/reproducible-build-res=
ults/">Reproducibile Build Status</a></li>
+        <li><a href=3D"https://lore.kernel.org/">Lore Public Inbox for mai=
ling lists</a></li>
+      </ul>
+    </section>
+  </main>
 </body>
-</html>
+
+</html>
\ No newline at end of file
diff --git a/scripts/dashboard/resources/apple-touch-icon.png b/scripts/das=
hboard/resources/apple-touch-icon.png
new file mode 100644
index 0000000000000000000000000000000000000000..d11f8bd0f9c0d6a765c81598619=
9c36504bdaf20
GIT binary patch
literal 7683
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

literal 0
HcmV?d00001

diff --git a/scripts/dashboard/resources/favicon-16x16.png b/scripts/dashbo=
ard/resources/favicon-16x16.png
new file mode 100644
index 0000000000000000000000000000000000000000..ba9765fb51ae810cab294ca1d69=
5f691c7e18c1a
GIT binary patch
literal 792
zcmeAS@N?(olHy`uVBq!ia0vp^0wB!63?wyl`GbKJOS+@4BLl<6e(pbstU$g(vPY0F
z14ES>14Ba#1H&(%P{RubhEf9thF1v;3|2E37{m+a><Y92O1uj232`;15->6{%E-tl
zEiJXSwr*{0_4D&HG&HQOt-X5ns=3DmH{c6Rp7n>WM5!yOzPjvP5MW5x_CE32J5cP?47
z#KgqJz`&rmxVX2s_xkng5fKrF2Ktu1Nsj3gO)PATjg7v3{km}BLL(zXE5BsN%&8_8
zw)OS(PoF-GjEpokHrcv$>+<ExO-)T*TwJD4pML4mrI3&iM@Pqv8#kUjc`_v>#mvmi
z)z$U?|Nk#zBd-E|EnX7j7t9iQ>Gz*o8SGK7KIUJ1`s>D<Zw=3D4i*7K?_vo8iJVNCLN
zckyk=3DP)G%G*h@TpUD;o-a&Yi+^nElI2MR6qba4!kxa`}{F4W|}<GNT$<3@DYL{U*u
zmg@I=3DtN(xIIK?&7^Jl(Vy-<ULK}%jiVqAlVNUfrmz-DR1H3>38-y(DrC!Rhvy<zT_
zMOs&*Vi)sFaNE38I#*cIVfEs&>c0mIOy>PznArRB%pCn`+Tshg-pk2tmyKTd>t8{M
zeqlqURs6au%umYdZ8&#}S{#}F?O%4wlE)8UihNk~e`g6Bi{|T>G5bC+W~`H8Irr(a
z7tq0~C9V-ADTyViR>?)FK#IZ0z{o_`z*N`3BE-PL%Fx)#z(U)=3Dz{<cN?xWl}6b-rg
zDVb@NxHagnSylwp5MC7$Q4*9`u24{vpO%@Es!&o{kgAYbP?F5RP%-E6CmxQ%Fb$1U
z{-@7)J`G}ER_4}A<`z~K_MR-lEUe(tU~)KxS$T7a!s#1VP8>ONMCJ(l=3D?0GlUV03#
X#05(}IhjrcTEXDy>gTe~DWM4fR(cu)

literal 0
HcmV?d00001

diff --git a/scripts/dashboard/resources/favicon-32x32.png b/scripts/dashbo=
ard/resources/favicon-32x32.png
new file mode 100644
index 0000000000000000000000000000000000000000..244edb606d7cfdd1c8bca17416d=
1911ff06d80f8
GIT binary patch
literal 1246
zcmeAS@N?(olHy`uVBq!ia0vp^3LwnE3?yBabR7dyEa{HEjtmSN`?>!lvVtU&J%W50
z7^>757#dm_7=3D8hT8eT9klo~KFyh>nTu$sZZAYL$MSD+081LOVxpAc7|0^<P%hK7bl
zMn)zkCf?rOv9Yn1mX^W6!66|bhYlUOd-rZ?YO1ZR?V2@f?%%&(S6Aof=3DXd`6`Tzg_
zuUoe+BO~L*ix=3DO&e{XGVZEtUX{rYuYUY?DO&6zW2JUu;+A3wfz>sEVv`)}XA)z;R2
z{`~pfyLY9frKeAy_VV&FGBPwaGIDly-nVbx{{8!%oSf3r)6HChY$Hm|U4lzWO5VSJ
z|MBC;_3PLF`}fbp%F(rao!_jtZdIF2teqVk9G*RU*3#1AR<Y54_Ivl5?WQ&^+1c4I
zU%s?(3$u%@v+#&CHZk3>VS}*|&}#-378c8vExUN}qQAd?e0=3D=3D9d-s0+{MpynXKHG?
zcJ11~fByyq1ax+Ge)#a=3D)2B~OO-<(J=3D2NFm{q^hD>eZ_q9Ua}=3D+@?>Te);m{A3uJ$
zxVYT9b!)<e35kh`RaI4HW@efpCk=3Ds7s8tf=3D7tFvQU3UEazb}`&v>6?a{<#sua{puU
z;RjZwzgNDy^nLI3z}ObnN4%?k>|^^-Sbhhni!sUD-Nj~kR^oXehrPtp*OmPRD+dQJ
z=3Dg)7<jX>#UPZ!4!i_^7}p9VWQiX45fwWy_Y?u}i$HIg1XA3UV@=3D9u4`cX=3DECC5W@8
z#?AFlfA;6woxQ)GF)D}%tl$Vr+SlY9lEuq3E!+9<h80sD3QpvhV8-R`CElx`z;;^0
zjPH@~6NWh)T=3DP|rWNUn6E}8J8w5`eM@p^47lS}nXdwvTB7kaLIuA!^Fe#Mv74DsuC
zc5R-raq^N~$FdeXF-T{vE&a-JnT`8;gaTVYwea;jPLYnQdAoZOT%xPp)e~7`@4nI7
za$J$2>i3R+jgI*TFMQyTKTuMVbH~i^rDlP}@@461vNZ|oDvRpYlr~1T7Z+w$w(=3D)z
zdiCfAZ(UeK^!*!8`V;cE9Q_$~<KDsujyLZLf3yFKZ?b>%;l+<9BHm0}p1!I1-{irR
z^8M4RU&k7jHbj4(`}*I*iCzp}UjBS~HESdHC;J1jIkna0+@JRgw)Oj8p6=3D17cw;-W
zYJ|^(p46#KT1#~%aJ@3wY2(SS5vx8|Jtc*ytLNOLQ_V)3Z1-<h({taVV(ve`|ADmM
z`8}rExtg}X7*Z{9jVMV;EJ?LWE=3DmPb3`Pb<Cb|Zux&{^@1{PL^##RQF+6D$z1_nRc
zM5|CV<mRVjrd8tB(0O|;s5A+$3W+EQN-S3>D9TUE%t=3D)!sVqoU$Sf#HW?-n8^Y{}F
zM`4(T#wq{PXFQ(<F)%B0>m_pwD+_y17GV}vaA`0(oWiWUIYi;~jVmXPoH-(Mg#C1b
d#{w@shF9W(C7+y3rvj~D@O1TaS?83{1ORK00eJub

literal 0
HcmV?d00001

diff --git a/scripts/dashboard/resources/pico.fluid.classless.min.css b/scr=
ipts/dashboard/resources/pico.fluid.classless.min.css
new file mode 100644
index 0000000..de403a2
--- /dev/null
+++ b/scripts/dashboard/resources/pico.fluid.classless.min.css
@@ -0,0 +1,4 @@
+@charset "UTF-8";/*!
+ * Pico CSS =E2=9C=A8 v2.1.1 (https://picocss.com)
+ * Copyright 2019-2025 - Licensed under MIT
+ */:host,:root{--pico-font-family-emoji:"Apple Color Emoji","Segoe UI Emoj=
i","Segoe UI Symbol","Noto Color Emoji";--pico-font-family-sans-serif:syste=
m-ui,"Segoe UI",Roboto,Oxygen,Ubuntu,Cantarell,Helvetica,Arial,"Helvetica N=
eue",sans-serif,var(--pico-font-family-emoji);--pico-font-family-monospace:=
ui-monospace,SFMono-Regular,"SF Mono",Menlo,Consolas,"Liberation Mono",mono=
space,var(--pico-font-family-emoji);--pico-font-family:var(--pico-font-fami=
ly-sans-serif);--pico-line-height:1.5;--pico-font-weight:400;--pico-font-si=
ze:100%;--pico-text-underline-offset:0.1rem;--pico-border-radius:0.25rem;--=
pico-border-width:0.0625rem;--pico-outline-width:0.125rem;--pico-transition=
:0.2s ease-in-out;--pico-spacing:1rem;--pico-typography-spacing-vertical:1r=
em;--pico-block-spacing-vertical:var(--pico-spacing);--pico-block-spacing-h=
orizontal:var(--pico-spacing);--pico-form-element-spacing-vertical:0.75rem;=
--pico-form-element-spacing-horizontal:1rem;--pico-group-box-shadow:0 0 0 r=
gba(0, 0, 0, 0);--pico-group-box-shadow-focus-with-button:0 0 0 var(--pico-=
outline-width) var(--pico-primary-focus);--pico-group-box-shadow-focus-with=
-input:0 0 0 0.0625rem var(--pico-form-element-border-color);--pico-modal-o=
verlay-backdrop-filter:blur(0.375rem);--pico-nav-element-spacing-vertical:1=
rem;--pico-nav-element-spacing-horizontal:0.5rem;--pico-nav-link-spacing-ve=
rtical:0.5rem;--pico-nav-link-spacing-horizontal:0.5rem;--pico-nav-breadcru=
mb-divider:">";--pico-icon-checkbox:url("data:image/svg+xml,%3Csvg xmlns=3D=
'http://www.w3.org/2000/svg' width=3D'24' height=3D'24' viewBox=3D'0 0 24 2=
4' fill=3D'none' stroke=3D'rgb(255, 255, 255)' stroke-width=3D'4' stroke-li=
necap=3D'round' stroke-linejoin=3D'round'%3E%3Cpolyline points=3D'20 6 9 17=
 4 12'%3E%3C/polyline%3E%3C/svg%3E");--pico-icon-minus:url("data:image/svg+=
xml,%3Csvg xmlns=3D'http://www.w3.org/2000/svg' width=3D'24' height=3D'24' =
viewBox=3D'0 0 24 24' fill=3D'none' stroke=3D'rgb(255, 255, 255)' stroke-wi=
dth=3D'4' stroke-linecap=3D'round' stroke-linejoin=3D'round'%3E%3Cline x1=
=3D'5' y1=3D'12' x2=3D'19' y2=3D'12'%3E%3C/line%3E%3C/svg%3E");--pico-icon-=
chevron:url("data:image/svg+xml,%3Csvg xmlns=3D'http://www.w3.org/2000/svg'=
 width=3D'24' height=3D'24' viewBox=3D'0 0 24 24' fill=3D'none' stroke=3D'r=
gb(136, 145, 164)' stroke-width=3D'2' stroke-linecap=3D'round' stroke-linej=
oin=3D'round'%3E%3Cpolyline points=3D'6 9 12 15 18 9'%3E%3C/polyline%3E%3C/=
svg%3E");--pico-icon-date:url("data:image/svg+xml,%3Csvg xmlns=3D'http://ww=
w.w3.org/2000/svg' width=3D'24' height=3D'24' viewBox=3D'0 0 24 24' fill=3D=
'none' stroke=3D'rgb(136, 145, 164)' stroke-width=3D'2' stroke-linecap=3D'r=
ound' stroke-linejoin=3D'round'%3E%3Crect x=3D'3' y=3D'4' width=3D'18' heig=
ht=3D'18' rx=3D'2' ry=3D'2'%3E%3C/rect%3E%3Cline x1=3D'16' y1=3D'2' x2=3D'1=
6' y2=3D'6'%3E%3C/line%3E%3Cline x1=3D'8' y1=3D'2' x2=3D'8' y2=3D'6'%3E%3C/=
line%3E%3Cline x1=3D'3' y1=3D'10' x2=3D'21' y2=3D'10'%3E%3C/line%3E%3C/svg%=
3E");--pico-icon-time:url("data:image/svg+xml,%3Csvg xmlns=3D'http://www.w3=
.org/2000/svg' width=3D'24' height=3D'24' viewBox=3D'0 0 24 24' fill=3D'non=
e' stroke=3D'rgb(136, 145, 164)' stroke-width=3D'2' stroke-linecap=3D'round=
' stroke-linejoin=3D'round'%3E%3Ccircle cx=3D'12' cy=3D'12' r=3D'10'%3E%3C/=
circle%3E%3Cpolyline points=3D'12 6 12 12 16 14'%3E%3C/polyline%3E%3C/svg%3=
E");--pico-icon-search:url("data:image/svg+xml,%3Csvg xmlns=3D'http://www.w=
3.org/2000/svg' width=3D'24' height=3D'24' viewBox=3D'0 0 24 24' fill=3D'no=
ne' stroke=3D'rgb(136, 145, 164)' stroke-width=3D'1.5' stroke-linecap=3D'ro=
und' stroke-linejoin=3D'round'%3E%3Ccircle cx=3D'11' cy=3D'11' r=3D'8'%3E%3=
C/circle%3E%3Cline x1=3D'21' y1=3D'21' x2=3D'16.65' y2=3D'16.65'%3E%3C/line=
%3E%3C/svg%3E");--pico-icon-close:url("data:image/svg+xml,%3Csvg xmlns=3D'h=
ttp://www.w3.org/2000/svg' width=3D'24' height=3D'24' viewBox=3D'0 0 24 24'=
 fill=3D'none' stroke=3D'rgb(136, 145, 164)' stroke-width=3D'3' stroke-line=
cap=3D'round' stroke-linejoin=3D'round'%3E%3Cline x1=3D'18' y1=3D'6' x2=3D'=
6' y2=3D'18'%3E%3C/line%3E%3Cline x1=3D'6' y1=3D'6' x2=3D'18' y2=3D'18'%3E%=
3C/line%3E%3C/svg%3E");--pico-icon-loading:url("data:image/svg+xml,%3Csvg f=
ill=3D'none' height=3D'24' width=3D'24' viewBox=3D'0 0 24 24' xmlns=3D'http=
://www.w3.org/2000/svg' %3E%3Cstyle%3E g %7B animation: rotate 2s linear in=
finite; transform-origin: center center; %7D circle %7B stroke-dasharray: 7=
5,100; stroke-dashoffset: -5; animation: dash 1.5s ease-in-out infinite; st=
roke-linecap: round; %7D @keyframes rotate %7B 0%25 %7B transform: rotate(0=
deg); %7D 100%25 %7B transform: rotate(360deg); %7D %7D @keyframes dash %7B=
 0%25 %7B stroke-dasharray: 1,100; stroke-dashoffset: 0; %7D 50%25 %7B stro=
ke-dasharray: 44.5,100; stroke-dashoffset: -17.5; %7D 100%25 %7B stroke-das=
harray: 44.5,100; stroke-dashoffset: -62; %7D %7D %3C/style%3E%3Cg%3E%3Ccir=
cle cx=3D'12' cy=3D'12' r=3D'10' fill=3D'none' stroke=3D'rgb(136, 145, 164)=
' stroke-width=3D'4' /%3E%3C/g%3E%3C/svg%3E")}@media (min-width:576px){:hos=
t,:root{--pico-font-size:106.25%}}@media (min-width:768px){:host,:root{--pi=
co-font-size:112.5%}}@media (min-width:1024px){:host,:root{--pico-font-size=
:118.75%}}@media (min-width:1280px){:host,:root{--pico-font-size:125%}}@med=
ia (min-width:1536px){:host,:root{--pico-font-size:131.25%}}a{--pico-text-d=
ecoration:underline}small{--pico-font-size:0.875em}h1,h2,h3,h4,h5,h6{--pico=
-font-weight:700}h1{--pico-font-size:2rem;--pico-line-height:1.125;--pico-t=
ypography-spacing-top:3rem}h2{--pico-font-size:1.75rem;--pico-line-height:1=
.15;--pico-typography-spacing-top:2.625rem}h3{--pico-font-size:1.5rem;--pic=
o-line-height:1.175;--pico-typography-spacing-top:2.25rem}h4{--pico-font-si=
ze:1.25rem;--pico-line-height:1.2;--pico-typography-spacing-top:1.874rem}h5=
{--pico-font-size:1.125rem;--pico-line-height:1.225;--pico-typography-spaci=
ng-top:1.6875rem}h6{--pico-font-size:1rem;--pico-line-height:1.25;--pico-ty=
pography-spacing-top:1.5rem}tfoot td,tfoot th,thead td,thead th{--pico-font=
-weight:600;--pico-border-width:0.1875rem}code,kbd,pre,samp{--pico-font-fam=
ily:var(--pico-font-family-monospace)}kbd{--pico-font-weight:bolder}:where(=
select,textarea),input:not([type=3Dsubmit],[type=3Dbutton],[type=3Dreset],[=
type=3Dcheckbox],[type=3Dradio],[type=3Dfile]){--pico-outline-width:0.0625r=
em}[type=3Dsearch]{--pico-border-radius:5rem}[type=3Dcheckbox],[type=3Dradi=
o]{--pico-border-width:0.125rem}[type=3Dcheckbox][role=3Dswitch]{--pico-bor=
der-width:0.1875rem}[role=3Dsearch]{--pico-border-radius:5rem}[role=3Dgroup=
] [role=3Dbutton],[role=3Dgroup] [type=3Dbutton],[role=3Dgroup] [type=3Dsub=
mit],[role=3Dgroup] button,[role=3Dsearch] [role=3Dbutton],[role=3Dsearch] =
[type=3Dbutton],[role=3Dsearch] [type=3Dsubmit],[role=3Dsearch] button{--pi=
co-form-element-spacing-horizontal:2rem}details summary[role=3Dbutton]::aft=
er{filter:brightness(0) invert(1)}[aria-busy=3Dtrue]:not(input,select,texta=
rea):is(button,[type=3Dsubmit],[type=3Dbutton],[type=3Dreset],[role=3Dbutto=
n])::before{filter:brightness(0) invert(1)}:host(:not([data-theme=3Ddark]))=
,:root:not([data-theme=3Ddark]),[data-theme=3Dlight]{color-scheme:light;--p=
ico-background-color:#fff;--pico-color:#373c44;--pico-text-selection-color:=
rgba(2, 154, 232, 0.25);--pico-muted-color:#646b79;--pico-muted-border-colo=
r:rgb(231, 234, 239.5);--pico-primary:#0172ad;--pico-primary-background:#01=
72ad;--pico-primary-border:var(--pico-primary-background);--pico-primary-un=
derline:rgba(1, 114, 173, 0.5);--pico-primary-hover:#015887;--pico-primary-=
hover-background:#02659a;--pico-primary-hover-border:var(--pico-primary-hov=
er-background);--pico-primary-hover-underline:var(--pico-primary-hover);--p=
ico-primary-focus:rgba(2, 154, 232, 0.5);--pico-primary-inverse:#fff;--pico=
-secondary:#5d6b89;--pico-secondary-background:#525f7a;--pico-secondary-bor=
der:var(--pico-secondary-background);--pico-secondary-underline:rgba(93, 10=
7, 137, 0.5);--pico-secondary-hover:#48536b;--pico-secondary-hover-backgrou=
nd:#48536b;--pico-secondary-hover-border:var(--pico-secondary-hover-backgro=
und);--pico-secondary-hover-underline:var(--pico-secondary-hover);--pico-se=
condary-focus:rgba(93, 107, 137, 0.25);--pico-secondary-inverse:#fff;--pico=
-contrast:#181c25;--pico-contrast-background:#181c25;--pico-contrast-border=
:var(--pico-contrast-background);--pico-contrast-underline:rgba(24, 28, 37,=
 0.5);--pico-contrast-hover:#000;--pico-contrast-hover-background:#000;--pi=
co-contrast-hover-border:var(--pico-contrast-hover-background);--pico-contr=
ast-hover-underline:var(--pico-secondary-hover);--pico-contrast-focus:rgba(=
93, 107, 137, 0.25);--pico-contrast-inverse:#fff;--pico-box-shadow:0.0145re=
m 0.029rem 0.174rem rgba(129, 145, 181, 0.01698),0.0335rem 0.067rem 0.402re=
m rgba(129, 145, 181, 0.024),0.0625rem 0.125rem 0.75rem rgba(129, 145, 181,=
 0.03),0.1125rem 0.225rem 1.35rem rgba(129, 145, 181, 0.036),0.2085rem 0.41=
7rem 2.502rem rgba(129, 145, 181, 0.04302),0.5rem 1rem 6rem rgba(129, 145, =
181, 0.06),0 0 0 0.0625rem rgba(129, 145, 181, 0.015);--pico-h1-color:#2d31=
38;--pico-h2-color:#373c44;--pico-h3-color:#424751;--pico-h4-color:#4d535e;=
--pico-h5-color:#5c6370;--pico-h6-color:#646b79;--pico-mark-background-colo=
r:rgb(252.5, 230.5, 191.5);--pico-mark-color:#0f1114;--pico-ins-color:rgb(2=
8.5, 105.5, 84);--pico-del-color:rgb(136, 56.5, 53);--pico-blockquote-borde=
r-color:var(--pico-muted-border-color);--pico-blockquote-footer-color:var(-=
-pico-muted-color);--pico-button-box-shadow:0 0 0 rgba(0, 0, 0, 0);--pico-b=
utton-hover-box-shadow:0 0 0 rgba(0, 0, 0, 0);--pico-table-border-color:var=
(--pico-muted-border-color);--pico-table-row-stripped-background-color:rgba=
(111, 120, 135, 0.0375);--pico-code-background-color:rgb(243, 244.5, 246.75=
);--pico-code-color:#646b79;--pico-code-kbd-background-color:var(--pico-col=
or);--pico-code-kbd-color:var(--pico-background-color);--pico-form-element-=
background-color:rgb(251, 251.5, 252.25);--pico-form-element-selected-backg=
round-color:#dfe3eb;--pico-form-element-border-color:#cfd5e2;--pico-form-el=
ement-color:#23262c;--pico-form-element-placeholder-color:var(--pico-muted-=
color);--pico-form-element-active-background-color:#fff;--pico-form-element=
-active-border-color:var(--pico-primary-border);--pico-form-element-focus-c=
olor:var(--pico-primary-border);--pico-form-element-disabled-opacity:0.5;--=
pico-form-element-invalid-border-color:rgb(183.5, 105.5, 106.5);--pico-form=
-element-invalid-active-border-color:rgb(200.25, 79.25, 72.25);--pico-form-=
element-invalid-focus-color:var(--pico-form-element-invalid-active-border-c=
olor);--pico-form-element-valid-border-color:rgb(76, 154.5, 137.5);--pico-f=
orm-element-valid-active-border-color:rgb(39, 152.75, 118.75);--pico-form-e=
lement-valid-focus-color:var(--pico-form-element-valid-active-border-color)=
;--pico-switch-background-color:#bfc7d9;--pico-switch-checked-background-co=
lor:var(--pico-primary-background);--pico-switch-color:#fff;--pico-switch-t=
humb-box-shadow:0 0 0 rgba(0, 0, 0, 0);--pico-range-border-color:#dfe3eb;--=
pico-range-active-border-color:#bfc7d9;--pico-range-thumb-border-color:var(=
--pico-background-color);--pico-range-thumb-color:var(--pico-secondary-back=
ground);--pico-range-thumb-active-color:var(--pico-primary-background);--pi=
co-accordion-border-color:var(--pico-muted-border-color);--pico-accordion-a=
ctive-summary-color:var(--pico-primary-hover);--pico-accordion-close-summar=
y-color:var(--pico-color);--pico-accordion-open-summary-color:var(--pico-mu=
ted-color);--pico-card-background-color:var(--pico-background-color);--pico=
-card-border-color:var(--pico-muted-border-color);--pico-card-box-shadow:va=
r(--pico-box-shadow);--pico-card-sectioning-background-color:rgb(251, 251.5=
, 252.25);--pico-loading-spinner-opacity:0.5;--pico-modal-overlay-backgroun=
d-color:rgba(232, 234, 237, 0.75);--pico-progress-background-color:#dfe3eb;=
--pico-progress-color:var(--pico-primary-background);--pico-tooltip-backgro=
und-color:var(--pico-contrast-background);--pico-tooltip-color:var(--pico-c=
ontrast-inverse);--pico-icon-valid:url("data:image/svg+xml,%3Csvg xmlns=3D'=
http://www.w3.org/2000/svg' width=3D'24' height=3D'24' viewBox=3D'0 0 24 24=
' fill=3D'none' stroke=3D'rgb(76, 154.5, 137.5)' stroke-width=3D'2' stroke-=
linecap=3D'round' stroke-linejoin=3D'round'%3E%3Cpolyline points=3D'20 6 9 =
17 4 12'%3E%3C/polyline%3E%3C/svg%3E");--pico-icon-invalid:url("data:image/=
svg+xml,%3Csvg xmlns=3D'http://www.w3.org/2000/svg' width=3D'24' height=3D'=
24' viewBox=3D'0 0 24 24' fill=3D'none' stroke=3D'rgb(200.25, 79.25, 72.25)=
' stroke-width=3D'2' stroke-linecap=3D'round' stroke-linejoin=3D'round'%3E%=
3Ccircle cx=3D'12' cy=3D'12' r=3D'10'%3E%3C/circle%3E%3Cline x1=3D'12' y1=
=3D'8' x2=3D'12' y2=3D'12'%3E%3C/line%3E%3Cline x1=3D'12' y1=3D'16' x2=3D'1=
2.01' y2=3D'16'%3E%3C/line%3E%3C/svg%3E")}:host(:not([data-theme=3Ddark])) =
input:is([type=3Dsubmit],[type=3Dbutton],[type=3Dreset],[type=3Dcheckbox],[=
type=3Dradio],[type=3Dfile]),:root:not([data-theme=3Ddark]) input:is([type=
=3Dsubmit],[type=3Dbutton],[type=3Dreset],[type=3Dcheckbox],[type=3Dradio],=
[type=3Dfile]),[data-theme=3Dlight] input:is([type=3Dsubmit],[type=3Dbutton=
],[type=3Dreset],[type=3Dcheckbox],[type=3Dradio],[type=3Dfile]){--pico-for=
m-element-focus-color:var(--pico-primary-focus)}@media only screen and (pre=
fers-color-scheme:dark){:host(:not([data-theme])),:root:not([data-theme]){c=
olor-scheme:dark;--pico-background-color:rgb(19, 22.5, 30.5);--pico-color:#=
c2c7d0;--pico-text-selection-color:rgba(1, 170, 255, 0.1875);--pico-muted-c=
olor:#7b8495;--pico-muted-border-color:#202632;--pico-primary:#01aaff;--pic=
o-primary-background:#0172ad;--pico-primary-border:var(--pico-primary-backg=
round);--pico-primary-underline:rgba(1, 170, 255, 0.5);--pico-primary-hover=
:#79c0ff;--pico-primary-hover-background:#017fc0;--pico-primary-hover-borde=
r:var(--pico-primary-hover-background);--pico-primary-hover-underline:var(-=
-pico-primary-hover);--pico-primary-focus:rgba(1, 170, 255, 0.375);--pico-p=
rimary-inverse:#fff;--pico-secondary:#969eaf;--pico-secondary-background:#5=
25f7a;--pico-secondary-border:var(--pico-secondary-background);--pico-secon=
dary-underline:rgba(150, 158, 175, 0.5);--pico-secondary-hover:#b3b9c5;--pi=
co-secondary-hover-background:#5d6b89;--pico-secondary-hover-border:var(--p=
ico-secondary-hover-background);--pico-secondary-hover-underline:var(--pico=
-secondary-hover);--pico-secondary-focus:rgba(144, 158, 190, 0.25);--pico-s=
econdary-inverse:#fff;--pico-contrast:#dfe3eb;--pico-contrast-background:#e=
ff1f4;--pico-contrast-border:var(--pico-contrast-background);--pico-contras=
t-underline:rgba(223, 227, 235, 0.5);--pico-contrast-hover:#fff;--pico-cont=
rast-hover-background:#fff;--pico-contrast-hover-border:var(--pico-contrast=
-hover-background);--pico-contrast-hover-underline:var(--pico-contrast-hove=
r);--pico-contrast-focus:rgba(207, 213, 226, 0.25);--pico-contrast-inverse:=
#000;--pico-box-shadow:0.0145rem 0.029rem 0.174rem rgba(7, 8.5, 12, 0.01698=
),0.0335rem 0.067rem 0.402rem rgba(7, 8.5, 12, 0.024),0.0625rem 0.125rem 0.=
75rem rgba(7, 8.5, 12, 0.03),0.1125rem 0.225rem 1.35rem rgba(7, 8.5, 12, 0.=
036),0.2085rem 0.417rem 2.502rem rgba(7, 8.5, 12, 0.04302),0.5rem 1rem 6rem=
 rgba(7, 8.5, 12, 0.06),0 0 0 0.0625rem rgba(7, 8.5, 12, 0.015);--pico-h1-c=
olor:#f0f1f3;--pico-h2-color:#e0e3e7;--pico-h3-color:#c2c7d0;--pico-h4-colo=
r:#b3b9c5;--pico-h5-color:#a4acba;--pico-h6-color:#8891a4;--pico-mark-backg=
round-color:#014063;--pico-mark-color:#fff;--pico-ins-color:#62af9a;--pico-=
del-color:rgb(205.5, 126, 123);--pico-blockquote-border-color:var(--pico-mu=
ted-border-color);--pico-blockquote-footer-color:var(--pico-muted-color);--=
pico-button-box-shadow:0 0 0 rgba(0, 0, 0, 0);--pico-button-hover-box-shado=
w:0 0 0 rgba(0, 0, 0, 0);--pico-table-border-color:var(--pico-muted-border-=
color);--pico-table-row-stripped-background-color:rgba(111, 120, 135, 0.037=
5);--pico-code-background-color:rgb(26, 30.5, 40.25);--pico-code-color:#889=
1a4;--pico-code-kbd-background-color:var(--pico-color);--pico-code-kbd-colo=
r:var(--pico-background-color);--pico-form-element-background-color:rgb(28,=
 33, 43.5);--pico-form-element-selected-background-color:#2a3140;--pico-for=
m-element-border-color:#2a3140;--pico-form-element-color:#e0e3e7;--pico-for=
m-element-placeholder-color:#8891a4;--pico-form-element-active-background-c=
olor:rgb(26, 30.5, 40.25);--pico-form-element-active-border-color:var(--pic=
o-primary-border);--pico-form-element-focus-color:var(--pico-primary-border=
);--pico-form-element-disabled-opacity:0.5;--pico-form-element-invalid-bord=
er-color:rgb(149.5, 74, 80);--pico-form-element-invalid-active-border-color=
:rgb(183.25, 63.5, 59);--pico-form-element-invalid-focus-color:var(--pico-f=
orm-element-invalid-active-border-color);--pico-form-element-valid-border-c=
olor:#2a7b6f;--pico-form-element-valid-active-border-color:rgb(22, 137, 105=
.5);--pico-form-element-valid-focus-color:var(--pico-form-element-valid-act=
ive-border-color);--pico-switch-background-color:#333c4e;--pico-switch-chec=
ked-background-color:var(--pico-primary-background);--pico-switch-color:#ff=
f;--pico-switch-thumb-box-shadow:0 0 0 rgba(0, 0, 0, 0);--pico-range-border=
-color:#202632;--pico-range-active-border-color:#2a3140;--pico-range-thumb-=
border-color:var(--pico-background-color);--pico-range-thumb-color:var(--pi=
co-secondary-background);--pico-range-thumb-active-color:var(--pico-primary=
-background);--pico-accordion-border-color:var(--pico-muted-border-color);-=
-pico-accordion-active-summary-color:var(--pico-primary-hover);--pico-accor=
dion-close-summary-color:var(--pico-color);--pico-accordion-open-summary-co=
lor:var(--pico-muted-color);--pico-card-background-color:#181c25;--pico-car=
d-border-color:var(--pico-card-background-color);--pico-card-box-shadow:var=
(--pico-box-shadow);--pico-card-sectioning-background-color:rgb(26, 30.5, 4=
0.25);--pico-loading-spinner-opacity:0.5;--pico-modal-overlay-background-co=
lor:rgba(7.5, 8.5, 10, 0.75);--pico-progress-background-color:#202632;--pic=
o-progress-color:var(--pico-primary-background);--pico-tooltip-background-c=
olor:var(--pico-contrast-background);--pico-tooltip-color:var(--pico-contra=
st-inverse);--pico-icon-valid:url("data:image/svg+xml,%3Csvg xmlns=3D'http:=
//www.w3.org/2000/svg' width=3D'24' height=3D'24' viewBox=3D'0 0 24 24' fil=
l=3D'none' stroke=3D'rgb(42, 123, 111)' stroke-width=3D'2' stroke-linecap=
=3D'round' stroke-linejoin=3D'round'%3E%3Cpolyline points=3D'20 6 9 17 4 12=
'%3E%3C/polyline%3E%3C/svg%3E");--pico-icon-invalid:url("data:image/svg+xml=
,%3Csvg xmlns=3D'http://www.w3.org/2000/svg' width=3D'24' height=3D'24' vie=
wBox=3D'0 0 24 24' fill=3D'none' stroke=3D'rgb(149.5, 74, 80)' stroke-width=
=3D'2' stroke-linecap=3D'round' stroke-linejoin=3D'round'%3E%3Ccircle cx=3D=
'12' cy=3D'12' r=3D'10'%3E%3C/circle%3E%3Cline x1=3D'12' y1=3D'8' x2=3D'12'=
 y2=3D'12'%3E%3C/line%3E%3Cline x1=3D'12' y1=3D'16' x2=3D'12.01' y2=3D'16'%=
3E%3C/line%3E%3C/svg%3E")}:host(:not([data-theme])) input:is([type=3Dsubmit=
],[type=3Dbutton],[type=3Dreset],[type=3Dcheckbox],[type=3Dradio],[type=3Df=
ile]),:root:not([data-theme]) input:is([type=3Dsubmit],[type=3Dbutton],[typ=
e=3Dreset],[type=3Dcheckbox],[type=3Dradio],[type=3Dfile]){--pico-form-elem=
ent-focus-color:var(--pico-primary-focus)}}[data-theme=3Ddark]{color-scheme=
:dark;--pico-background-color:rgb(19, 22.5, 30.5);--pico-color:#c2c7d0;--pi=
co-text-selection-color:rgba(1, 170, 255, 0.1875);--pico-muted-color:#7b849=
5;--pico-muted-border-color:#202632;--pico-primary:#01aaff;--pico-primary-b=
ackground:#0172ad;--pico-primary-border:var(--pico-primary-background);--pi=
co-primary-underline:rgba(1, 170, 255, 0.5);--pico-primary-hover:#79c0ff;--=
pico-primary-hover-background:#017fc0;--pico-primary-hover-border:var(--pic=
o-primary-hover-background);--pico-primary-hover-underline:var(--pico-prima=
ry-hover);--pico-primary-focus:rgba(1, 170, 255, 0.375);--pico-primary-inve=
rse:#fff;--pico-secondary:#969eaf;--pico-secondary-background:#525f7a;--pic=
o-secondary-border:var(--pico-secondary-background);--pico-secondary-underl=
ine:rgba(150, 158, 175, 0.5);--pico-secondary-hover:#b3b9c5;--pico-secondar=
y-hover-background:#5d6b89;--pico-secondary-hover-border:var(--pico-seconda=
ry-hover-background);--pico-secondary-hover-underline:var(--pico-secondary-=
hover);--pico-secondary-focus:rgba(144, 158, 190, 0.25);--pico-secondary-in=
verse:#fff;--pico-contrast:#dfe3eb;--pico-contrast-background:#eff1f4;--pic=
o-contrast-border:var(--pico-contrast-background);--pico-contrast-underline=
:rgba(223, 227, 235, 0.5);--pico-contrast-hover:#fff;--pico-contrast-hover-=
background:#fff;--pico-contrast-hover-border:var(--pico-contrast-hover-back=
ground);--pico-contrast-hover-underline:var(--pico-contrast-hover);--pico-c=
ontrast-focus:rgba(207, 213, 226, 0.25);--pico-contrast-inverse:#000;--pico=
-box-shadow:0.0145rem 0.029rem 0.174rem rgba(7, 8.5, 12, 0.01698),0.0335rem=
 0.067rem 0.402rem rgba(7, 8.5, 12, 0.024),0.0625rem 0.125rem 0.75rem rgba(=
7, 8.5, 12, 0.03),0.1125rem 0.225rem 1.35rem rgba(7, 8.5, 12, 0.036),0.2085=
rem 0.417rem 2.502rem rgba(7, 8.5, 12, 0.04302),0.5rem 1rem 6rem rgba(7, 8.=
5, 12, 0.06),0 0 0 0.0625rem rgba(7, 8.5, 12, 0.015);--pico-h1-color:#f0f1f=
3;--pico-h2-color:#e0e3e7;--pico-h3-color:#c2c7d0;--pico-h4-color:#b3b9c5;-=
-pico-h5-color:#a4acba;--pico-h6-color:#8891a4;--pico-mark-background-color=
:#014063;--pico-mark-color:#fff;--pico-ins-color:#62af9a;--pico-del-color:r=
gb(205.5, 126, 123);--pico-blockquote-border-color:var(--pico-muted-border-=
color);--pico-blockquote-footer-color:var(--pico-muted-color);--pico-button=
-box-shadow:0 0 0 rgba(0, 0, 0, 0);--pico-button-hover-box-shadow:0 0 0 rgb=
a(0, 0, 0, 0);--pico-table-border-color:var(--pico-muted-border-color);--pi=
co-table-row-stripped-background-color:rgba(111, 120, 135, 0.0375);--pico-c=
ode-background-color:rgb(26, 30.5, 40.25);--pico-code-color:#8891a4;--pico-=
code-kbd-background-color:var(--pico-color);--pico-code-kbd-color:var(--pic=
o-background-color);--pico-form-element-background-color:rgb(28, 33, 43.5);=
--pico-form-element-selected-background-color:#2a3140;--pico-form-element-b=
order-color:#2a3140;--pico-form-element-color:#e0e3e7;--pico-form-element-p=
laceholder-color:#8891a4;--pico-form-element-active-background-color:rgb(26=
, 30.5, 40.25);--pico-form-element-active-border-color:var(--pico-primary-b=
order);--pico-form-element-focus-color:var(--pico-primary-border);--pico-fo=
rm-element-disabled-opacity:0.5;--pico-form-element-invalid-border-color:rg=
b(149.5, 74, 80);--pico-form-element-invalid-active-border-color:rgb(183.25=
, 63.5, 59);--pico-form-element-invalid-focus-color:var(--pico-form-element=
-invalid-active-border-color);--pico-form-element-valid-border-color:#2a7b6=
f;--pico-form-element-valid-active-border-color:rgb(22, 137, 105.5);--pico-=
form-element-valid-focus-color:var(--pico-form-element-valid-active-border-=
color);--pico-switch-background-color:#333c4e;--pico-switch-checked-backgro=
und-color:var(--pico-primary-background);--pico-switch-color:#fff;--pico-sw=
itch-thumb-box-shadow:0 0 0 rgba(0, 0, 0, 0);--pico-range-border-color:#202=
632;--pico-range-active-border-color:#2a3140;--pico-range-thumb-border-colo=
r:var(--pico-background-color);--pico-range-thumb-color:var(--pico-secondar=
y-background);--pico-range-thumb-active-color:var(--pico-primary-background=
);--pico-accordion-border-color:var(--pico-muted-border-color);--pico-accor=
dion-active-summary-color:var(--pico-primary-hover);--pico-accordion-close-=
summary-color:var(--pico-color);--pico-accordion-open-summary-color:var(--p=
ico-muted-color);--pico-card-background-color:#181c25;--pico-card-border-co=
lor:var(--pico-card-background-color);--pico-card-box-shadow:var(--pico-box=
-shadow);--pico-card-sectioning-background-color:rgb(26, 30.5, 40.25);--pic=
o-loading-spinner-opacity:0.5;--pico-modal-overlay-background-color:rgba(7.=
5, 8.5, 10, 0.75);--pico-progress-background-color:#202632;--pico-progress-=
color:var(--pico-primary-background);--pico-tooltip-background-color:var(--=
pico-contrast-background);--pico-tooltip-color:var(--pico-contrast-inverse)=
;--pico-icon-valid:url("data:image/svg+xml,%3Csvg xmlns=3D'http://www.w3.or=
g/2000/svg' width=3D'24' height=3D'24' viewBox=3D'0 0 24 24' fill=3D'none' =
stroke=3D'rgb(42, 123, 111)' stroke-width=3D'2' stroke-linecap=3D'round' st=
roke-linejoin=3D'round'%3E%3Cpolyline points=3D'20 6 9 17 4 12'%3E%3C/polyl=
ine%3E%3C/svg%3E");--pico-icon-invalid:url("data:image/svg+xml,%3Csvg xmlns=
=3D'http://www.w3.org/2000/svg' width=3D'24' height=3D'24' viewBox=3D'0 0 2=
4 24' fill=3D'none' stroke=3D'rgb(149.5, 74, 80)' stroke-width=3D'2' stroke=
-linecap=3D'round' stroke-linejoin=3D'round'%3E%3Ccircle cx=3D'12' cy=3D'12=
' r=3D'10'%3E%3C/circle%3E%3Cline x1=3D'12' y1=3D'8' x2=3D'12' y2=3D'12'%3E=
%3C/line%3E%3Cline x1=3D'12' y1=3D'16' x2=3D'12.01' y2=3D'16'%3E%3C/line%3E=
%3C/svg%3E")}[data-theme=3Ddark] input:is([type=3Dsubmit],[type=3Dbutton],[=
type=3Dreset],[type=3Dcheckbox],[type=3Dradio],[type=3Dfile]){--pico-form-e=
lement-focus-color:var(--pico-primary-focus)}[type=3Dcheckbox],[type=3Dradi=
o],[type=3Drange],progress{accent-color:var(--pico-primary)}*,::after,::bef=
ore{box-sizing:border-box;background-repeat:no-repeat}::after,::before{text=
-decoration:inherit;vertical-align:inherit}:where(:host),:where(:root){-web=
kit-tap-highlight-color:transparent;-webkit-text-size-adjust:100%;-moz-text=
-size-adjust:100%;text-size-adjust:100%;background-color:var(--pico-backgro=
und-color);color:var(--pico-color);font-weight:var(--pico-font-weight);font=
-size:var(--pico-font-size);line-height:var(--pico-line-height);font-family=
:var(--pico-font-family);text-underline-offset:var(--pico-text-underline-of=
fset);text-rendering:optimizeLegibility;overflow-wrap:break-word;-moz-tab-s=
ize:4;-o-tab-size:4;tab-size:4}body{width:100%;margin:0}main{display:block}=
body>footer,body>header,body>main{width:100%;margin-right:auto;margin-left:=
auto;padding:var(--pico-block-spacing-vertical) var(--pico-block-spacing-ho=
rizontal)}section{margin-bottom:var(--pico-block-spacing-vertical)}b,strong=
{font-weight:bolder}sub,sup{position:relative;font-size:.75em;line-height:0=
;vertical-align:baseline}sub{bottom:-.25em}sup{top:-.5em}address,blockquote=
,dl,ol,p,pre,table,ul{margin-top:0;margin-bottom:var(--pico-typography-spac=
ing-vertical);color:var(--pico-color);font-style:normal;font-weight:var(--p=
ico-font-weight)}h1,h2,h3,h4,h5,h6{margin-top:0;margin-bottom:var(--pico-ty=
pography-spacing-vertical);color:var(--pico-color);font-weight:var(--pico-f=
ont-weight);font-size:var(--pico-font-size);line-height:var(--pico-line-hei=
ght);font-family:var(--pico-font-family)}h1{--pico-color:var(--pico-h1-colo=
r)}h2{--pico-color:var(--pico-h2-color)}h3{--pico-color:var(--pico-h3-color=
)}h4{--pico-color:var(--pico-h4-color)}h5{--pico-color:var(--pico-h5-color)=
}h6{--pico-color:var(--pico-h6-color)}:where(article,address,blockquote,dl,=
figure,form,ol,p,pre,table,ul)~:is(h1,h2,h3,h4,h5,h6){margin-top:var(--pico=
-typography-spacing-top)}p{margin-bottom:var(--pico-typography-spacing-vert=
ical)}hgroup{margin-bottom:var(--pico-typography-spacing-vertical)}hgroup>*=
{margin-top:0;margin-bottom:0}hgroup>:not(:first-child):last-child{--pico-c=
olor:var(--pico-muted-color);--pico-font-weight:unset;font-size:1rem}:where=
(ol,ul) li{margin-bottom:calc(var(--pico-typography-spacing-vertical) * .25=
)}:where(dl,ol,ul) :where(dl,ol,ul){margin:0;margin-top:calc(var(--pico-typ=
ography-spacing-vertical) * .25)}ul li{list-style:square}mark{padding:.125r=
em .25rem;background-color:var(--pico-mark-background-color);color:var(--pi=
co-mark-color);vertical-align:baseline}blockquote{display:block;margin:var(=
--pico-typography-spacing-vertical) 0;padding:var(--pico-spacing);border-ri=
ght:none;border-left:.25rem solid var(--pico-blockquote-border-color);borde=
r-inline-start:0.25rem solid var(--pico-blockquote-border-color);border-inl=
ine-end:none}blockquote footer{margin-top:calc(var(--pico-typography-spacin=
g-vertical) * .5);color:var(--pico-blockquote-footer-color)}abbr[title]{bor=
der-bottom:1px dotted;text-decoration:none;cursor:help}ins{color:var(--pico=
-ins-color);text-decoration:none}del{color:var(--pico-del-color)}::-moz-sel=
ection{background-color:var(--pico-text-selection-color)}::selection{backgr=
ound-color:var(--pico-text-selection-color)}:where(a:not([role=3Dbutton])),=
[role=3Dlink]{--pico-color:var(--pico-primary);--pico-background-color:tran=
sparent;--pico-underline:var(--pico-primary-underline);outline:0;background=
-color:var(--pico-background-color);color:var(--pico-color);-webkit-text-de=
coration:var(--pico-text-decoration);text-decoration:var(--pico-text-decora=
tion);text-decoration-color:var(--pico-underline);text-underline-offset:0.1=
25em;transition:background-color var(--pico-transition),color var(--pico-tr=
ansition),box-shadow var(--pico-transition),-webkit-text-decoration var(--p=
ico-transition);transition:background-color var(--pico-transition),color va=
r(--pico-transition),text-decoration var(--pico-transition),box-shadow var(=
--pico-transition);transition:background-color var(--pico-transition),color=
 var(--pico-transition),text-decoration var(--pico-transition),box-shadow v=
ar(--pico-transition),-webkit-text-decoration var(--pico-transition)}:where=
(a:not([role=3Dbutton])):is([aria-current]:not([aria-current=3Dfalse]),:hov=
er,:active,:focus),[role=3Dlink]:is([aria-current]:not([aria-current=3Dfals=
e]),:hover,:active,:focus){--pico-color:var(--pico-primary-hover);--pico-un=
derline:var(--pico-primary-hover-underline);--pico-text-decoration:underlin=
e}:where(a:not([role=3Dbutton])):focus-visible,[role=3Dlink]:focus-visible{=
box-shadow:0 0 0 var(--pico-outline-width) var(--pico-primary-focus)}a[role=
=3Dbutton]{display:inline-block}button{margin:0;overflow:visible;font-famil=
y:inherit;text-transform:none}[type=3Dbutton],[type=3Dreset],[type=3Dsubmit=
],button{-webkit-appearance:button}[role=3Dbutton],[type=3Dbutton],[type=3D=
file]::file-selector-button,[type=3Dreset],[type=3Dsubmit],button{--pico-ba=
ckground-color:var(--pico-primary-background);--pico-border-color:var(--pic=
o-primary-border);--pico-color:var(--pico-primary-inverse);--pico-box-shado=
w:var(--pico-button-box-shadow, 0 0 0 rgba(0, 0, 0, 0));padding:var(--pico-=
form-element-spacing-vertical) var(--pico-form-element-spacing-horizontal);=
border:var(--pico-border-width) solid var(--pico-border-color);border-radiu=
s:var(--pico-border-radius);outline:0;background-color:var(--pico-backgroun=
d-color);box-shadow:var(--pico-box-shadow);color:var(--pico-color);font-wei=
ght:var(--pico-font-weight);font-size:1rem;line-height:var(--pico-line-heig=
ht);text-align:center;text-decoration:none;cursor:pointer;-webkit-user-sele=
ct:none;-moz-user-select:none;user-select:none;transition:background-color =
var(--pico-transition),border-color var(--pico-transition),color var(--pico=
-transition),box-shadow var(--pico-transition)}[role=3Dbutton]:is(:hover,:a=
ctive,:focus),[role=3Dbutton]:is([aria-current]:not([aria-current=3Dfalse])=
),[type=3Dbutton]:is(:hover,:active,:focus),[type=3Dbutton]:is([aria-curren=
t]:not([aria-current=3Dfalse])),[type=3Dfile]::file-selector-button:is(:hov=
er,:active,:focus),[type=3Dfile]::file-selector-button:is([aria-current]:no=
t([aria-current=3Dfalse])),[type=3Dreset]:is(:hover,:active,:focus),[type=
=3Dreset]:is([aria-current]:not([aria-current=3Dfalse])),[type=3Dsubmit]:is=
(:hover,:active,:focus),[type=3Dsubmit]:is([aria-current]:not([aria-current=
=3Dfalse])),button:is(:hover,:active,:focus),button:is([aria-current]:not([=
aria-current=3Dfalse])){--pico-background-color:var(--pico-primary-hover-ba=
ckground);--pico-border-color:var(--pico-primary-hover-border);--pico-box-s=
hadow:var(--pico-button-hover-box-shadow, 0 0 0 rgba(0, 0, 0, 0));--pico-co=
lor:var(--pico-primary-inverse)}[role=3Dbutton]:focus,[role=3Dbutton]:is([a=
ria-current]:not([aria-current=3Dfalse])):focus,[type=3Dbutton]:focus,[type=
=3Dbutton]:is([aria-current]:not([aria-current=3Dfalse])):focus,[type=3Dfil=
e]::file-selector-button:focus,[type=3Dfile]::file-selector-button:is([aria=
-current]:not([aria-current=3Dfalse])):focus,[type=3Dreset]:focus,[type=3Dr=
eset]:is([aria-current]:not([aria-current=3Dfalse])):focus,[type=3Dsubmit]:=
focus,[type=3Dsubmit]:is([aria-current]:not([aria-current=3Dfalse])):focus,=
button:focus,button:is([aria-current]:not([aria-current=3Dfalse])):focus{--=
pico-box-shadow:var(--pico-button-hover-box-shadow, 0 0 0 rgba(0, 0, 0, 0))=
,0 0 0 var(--pico-outline-width) var(--pico-primary-focus)}[type=3Dbutton],=
[type=3Dreset],[type=3Dsubmit]{margin-bottom:var(--pico-spacing)}[type=3Dfi=
le]::file-selector-button,[type=3Dreset]{--pico-background-color:var(--pico=
-secondary-background);--pico-border-color:var(--pico-secondary-border);--p=
ico-color:var(--pico-secondary-inverse);cursor:pointer}[type=3Dfile]::file-=
selector-button:is([aria-current]:not([aria-current=3Dfalse]),:hover,:activ=
e,:focus),[type=3Dreset]:is([aria-current]:not([aria-current=3Dfalse]),:hov=
er,:active,:focus){--pico-background-color:var(--pico-secondary-hover-backg=
round);--pico-border-color:var(--pico-secondary-hover-border);--pico-color:=
var(--pico-secondary-inverse)}[type=3Dfile]::file-selector-button:focus,[ty=
pe=3Dreset]:focus{--pico-box-shadow:var(--pico-button-hover-box-shadow, 0 0=
 0 rgba(0, 0, 0, 0)),0 0 0 var(--pico-outline-width) var(--pico-secondary-f=
ocus)}:where(button,[type=3Dsubmit],[type=3Dreset],[type=3Dbutton],[role=3D=
button])[disabled],:where(fieldset[disabled]) :is(button,[type=3Dsubmit],[t=
ype=3Dbutton],[type=3Dreset],[role=3Dbutton]){opacity:.5;pointer-events:non=
e}:where(table){width:100%;border-collapse:collapse;border-spacing:0;text-i=
ndent:0}td,th{padding:calc(var(--pico-spacing)/ 2) var(--pico-spacing);bord=
er-bottom:var(--pico-border-width) solid var(--pico-table-border-color);bac=
kground-color:var(--pico-background-color);color:var(--pico-color);font-wei=
ght:var(--pico-font-weight);text-align:left;text-align:start}tfoot td,tfoot=
 th{border-top:var(--pico-border-width) solid var(--pico-table-border-color=
);border-bottom:0}table.striped tbody tr:nth-child(odd) td,table.striped tb=
ody tr:nth-child(odd) th{background-color:var(--pico-table-row-stripped-bac=
kground-color)}:where(audio,canvas,iframe,img,svg,video){vertical-align:mid=
dle}audio,video{display:inline-block}audio:not([controls]){display:none;hei=
ght:0}:where(iframe){border-style:none}img{max-width:100%;height:auto;borde=
r-style:none}:where(svg:not([fill])){fill:currentColor}svg:not(:host),svg:n=
ot(:root){overflow:hidden}code,kbd,pre,samp{font-size:.875em;font-family:va=
r(--pico-font-family)}pre code,pre samp{font-size:inherit;font-family:inher=
it}pre{-ms-overflow-style:scrollbar;overflow:auto}code,kbd,pre,samp{border-=
radius:var(--pico-border-radius);background:var(--pico-code-background-colo=
r);color:var(--pico-code-color);font-weight:var(--pico-font-weight);line-he=
ight:initial}code,kbd,samp{display:inline-block;padding:.375rem}pre{display=
:block;margin-bottom:var(--pico-spacing);overflow-x:auto}pre>code,pre>samp{=
display:block;padding:var(--pico-spacing);background:0 0;line-height:var(--=
pico-line-height)}kbd{background-color:var(--pico-code-kbd-background-color=
);color:var(--pico-code-kbd-color);vertical-align:baseline}figure{display:b=
lock;margin:0;padding:0}figure figcaption{padding:calc(var(--pico-spacing) =
* .5) 0;color:var(--pico-muted-color)}hr{height:0;margin:var(--pico-typogra=
phy-spacing-vertical) 0;border:0;border-top:1px solid var(--pico-muted-bord=
er-color);color:inherit}[hidden],template{display:none!important}canvas{dis=
play:inline-block}input,optgroup,select,textarea{margin:0;font-size:1rem;li=
ne-height:var(--pico-line-height);font-family:inherit;letter-spacing:inheri=
t}input{overflow:visible}select{text-transform:none}legend{max-width:100%;p=
adding:0;color:inherit;white-space:normal}textarea{overflow:auto}[type=3Dch=
eckbox],[type=3Dradio]{padding:0}::-webkit-inner-spin-button,::-webkit-oute=
r-spin-button{height:auto}[type=3Dsearch]{-webkit-appearance:textfield;outl=
ine-offset:-2px}[type=3Dsearch]::-webkit-search-decoration{-webkit-appearan=
ce:none}::-webkit-file-upload-button{-webkit-appearance:button;font:inherit=
}::-moz-focus-inner{padding:0;border-style:none}:-moz-focusring{outline:0}:=
-moz-ui-invalid{box-shadow:none}::-ms-expand{display:none}[type=3Dfile],[ty=
pe=3Drange]{padding:0;border-width:0}input:not([type=3Dcheckbox],[type=3Dra=
dio],[type=3Drange]){height:calc(1rem * var(--pico-line-height) + var(--pic=
o-form-element-spacing-vertical) * 2 + var(--pico-border-width) * 2)}fields=
et{width:100%;margin:0;margin-bottom:var(--pico-spacing);padding:0;border:0=
}fieldset legend,label{display:block;margin-bottom:calc(var(--pico-spacing)=
 * .375);color:var(--pico-color);font-weight:var(--pico-form-label-font-wei=
ght,var(--pico-font-weight))}fieldset legend{margin-bottom:calc(var(--pico-=
spacing) * .5)}button[type=3Dsubmit],input:not([type=3Dcheckbox],[type=3Dra=
dio]),select,textarea{width:100%}input:not([type=3Dcheckbox],[type=3Dradio]=
,[type=3Drange],[type=3Dfile]),select,textarea{-webkit-appearance:none;-moz=
-appearance:none;appearance:none;padding:var(--pico-form-element-spacing-ve=
rtical) var(--pico-form-element-spacing-horizontal)}input,select,textarea{-=
-pico-background-color:var(--pico-form-element-background-color);--pico-bor=
der-color:var(--pico-form-element-border-color);--pico-color:var(--pico-for=
m-element-color);--pico-box-shadow:none;border:var(--pico-border-width) sol=
id var(--pico-border-color);border-radius:var(--pico-border-radius);outline=
:0;background-color:var(--pico-background-color);box-shadow:var(--pico-box-=
shadow);color:var(--pico-color);font-weight:var(--pico-font-weight);transit=
ion:background-color var(--pico-transition),border-color var(--pico-transit=
ion),color var(--pico-transition),box-shadow var(--pico-transition)}:where(=
select,textarea):not([readonly]):is(:active,:focus),input:not([type=3Dsubmi=
t],[type=3Dbutton],[type=3Dreset],[type=3Dcheckbox],[type=3Dradio],[readonl=
y]):is(:active,:focus){--pico-background-color:var(--pico-form-element-acti=
ve-background-color)}:where(select,textarea):not([readonly]):is(:active,:fo=
cus),input:not([type=3Dsubmit],[type=3Dbutton],[type=3Dreset],[role=3Dswitc=
h],[readonly]):is(:active,:focus){--pico-border-color:var(--pico-form-eleme=
nt-active-border-color)}:where(select,textarea):not([readonly]):focus,input=
:not([type=3Dsubmit],[type=3Dbutton],[type=3Dreset],[type=3Drange],[type=3D=
file],[readonly]):focus{--pico-box-shadow:0 0 0 var(--pico-outline-width) v=
ar(--pico-form-element-focus-color)}:where(fieldset[disabled]) :is(input:no=
t([type=3Dsubmit],[type=3Dbutton],[type=3Dreset]),select,textarea),input:no=
t([type=3Dsubmit],[type=3Dbutton],[type=3Dreset])[disabled],label[aria-disa=
bled=3Dtrue],select[disabled],textarea[disabled]{opacity:var(--pico-form-el=
ement-disabled-opacity);pointer-events:none}label[aria-disabled=3Dtrue] inp=
ut[disabled]{opacity:1}:where(input,select,textarea):not([type=3Dcheckbox],=
[type=3Dradio],[type=3Ddate],[type=3Ddatetime-local],[type=3Dmonth],[type=
=3Dtime],[type=3Dweek],[type=3Drange])[aria-invalid]{padding-right:calc(var=
(--pico-form-element-spacing-horizontal) + 1.5rem)!important;padding-left:v=
ar(--pico-form-element-spacing-horizontal);padding-inline-start:var(--pico-=
form-element-spacing-horizontal)!important;padding-inline-end:calc(var(--pi=
co-form-element-spacing-horizontal) + 1.5rem)!important;background-position=
:center right .75rem;background-size:1rem auto;background-repeat:no-repeat}=
:where(input,select,textarea):not([type=3Dcheckbox],[type=3Dradio],[type=3D=
date],[type=3Ddatetime-local],[type=3Dmonth],[type=3Dtime],[type=3Dweek],[t=
ype=3Drange])[aria-invalid=3Dfalse]:not(select){background-image:var(--pico=
-icon-valid)}:where(input,select,textarea):not([type=3Dcheckbox],[type=3Dra=
dio],[type=3Ddate],[type=3Ddatetime-local],[type=3Dmonth],[type=3Dtime],[ty=
pe=3Dweek],[type=3Drange])[aria-invalid=3Dtrue]:not(select){background-imag=
e:var(--pico-icon-invalid)}:where(input,select,textarea)[aria-invalid=3Dfal=
se]{--pico-border-color:var(--pico-form-element-valid-border-color)}:where(=
input,select,textarea)[aria-invalid=3Dfalse]:is(:active,:focus){--pico-bord=
er-color:var(--pico-form-element-valid-active-border-color)!important}:wher=
e(input,select,textarea)[aria-invalid=3Dfalse]:is(:active,:focus):not([type=
=3Dcheckbox],[type=3Dradio]){--pico-box-shadow:0 0 0 var(--pico-outline-wid=
th) var(--pico-form-element-valid-focus-color)!important}:where(input,selec=
t,textarea)[aria-invalid=3Dtrue]{--pico-border-color:var(--pico-form-elemen=
t-invalid-border-color)}:where(input,select,textarea)[aria-invalid=3Dtrue]:=
is(:active,:focus){--pico-border-color:var(--pico-form-element-invalid-acti=
ve-border-color)!important}:where(input,select,textarea)[aria-invalid=3Dtru=
e]:is(:active,:focus):not([type=3Dcheckbox],[type=3Dradio]){--pico-box-shad=
ow:0 0 0 var(--pico-outline-width) var(--pico-form-element-invalid-focus-co=
lor)!important}[dir=3Drtl] :where(input,select,textarea):not([type=3Dcheckb=
ox],[type=3Dradio]):is([aria-invalid],[aria-invalid=3Dtrue],[aria-invalid=
=3Dfalse]){background-position:center left .75rem}input::-webkit-input-plac=
eholder,input::placeholder,select:invalid,textarea::-webkit-input-placehold=
er,textarea::placeholder{color:var(--pico-form-element-placeholder-color);o=
pacity:1}input:not([type=3Dcheckbox],[type=3Dradio]),select,textarea{margin=
-bottom:var(--pico-spacing)}select::-ms-expand{border:0;background-color:tr=
ansparent}select:not([multiple],[size]){padding-right:calc(var(--pico-form-=
element-spacing-horizontal) + 1.5rem);padding-left:var(--pico-form-element-=
spacing-horizontal);padding-inline-start:var(--pico-form-element-spacing-ho=
rizontal);padding-inline-end:calc(var(--pico-form-element-spacing-horizonta=
l) + 1.5rem);background-image:var(--pico-icon-chevron);background-position:=
center right .75rem;background-size:1rem auto;background-repeat:no-repeat}s=
elect[multiple] option:checked{background:var(--pico-form-element-selected-=
background-color);color:var(--pico-form-element-color)}[dir=3Drtl] select:n=
ot([multiple],[size]){background-position:center left .75rem}textarea{displ=
ay:block;resize:vertical}textarea[aria-invalid]{--pico-icon-height:calc(1re=
m * var(--pico-line-height) + var(--pico-form-element-spacing-vertical) * 2=
 + var(--pico-border-width) * 2);background-position:top right .75rem!impor=
tant;background-size:1rem var(--pico-icon-height)!important}:where(input,se=
lect,textarea,fieldset)+small{display:block;width:100%;margin-top:calc(var(=
--pico-spacing) * -.75);margin-bottom:var(--pico-spacing);color:var(--pico-=
muted-color)}:where(input,select,textarea,fieldset)[aria-invalid=3Dfalse]+s=
mall{color:var(--pico-ins-color)}:where(input,select,textarea,fieldset)[ari=
a-invalid=3Dtrue]+small{color:var(--pico-del-color)}label>:where(input,sele=
ct,textarea){margin-top:calc(var(--pico-spacing) * .25)}label:has([type=3Dc=
heckbox],[type=3Dradio]){width:-moz-fit-content;width:fit-content;cursor:po=
inter}[type=3Dcheckbox],[type=3Dradio]{-webkit-appearance:none;-moz-appeara=
nce:none;appearance:none;width:1.25em;height:1.25em;margin-top:-.125em;marg=
in-inline-end:.5em;border-width:var(--pico-border-width);vertical-align:mid=
dle;cursor:pointer}[type=3Dcheckbox]::-ms-check,[type=3Dradio]::-ms-check{d=
isplay:none}[type=3Dcheckbox]:checked,[type=3Dcheckbox]:checked:active,[typ=
e=3Dcheckbox]:checked:focus,[type=3Dradio]:checked,[type=3Dradio]:checked:a=
ctive,[type=3Dradio]:checked:focus{--pico-background-color:var(--pico-prima=
ry-background);--pico-border-color:var(--pico-primary-border);background-im=
age:var(--pico-icon-checkbox);background-position:center;background-size:.7=
5em auto;background-repeat:no-repeat}[type=3Dcheckbox]~label,[type=3Dradio]=
~label{display:inline-block;margin-bottom:0;cursor:pointer}[type=3Dcheckbox=
]~label:not(:last-of-type),[type=3Dradio]~label:not(:last-of-type){margin-i=
nline-end:1em}[type=3Dcheckbox]:indeterminate{--pico-background-color:var(-=
-pico-primary-background);--pico-border-color:var(--pico-primary-border);ba=
ckground-image:var(--pico-icon-minus);background-position:center;background=
-size:.75em auto;background-repeat:no-repeat}[type=3Dradio]{border-radius:5=
0%}[type=3Dradio]:checked,[type=3Dradio]:checked:active,[type=3Dradio]:chec=
ked:focus{--pico-background-color:var(--pico-primary-inverse);border-width:=
.35em;background-image:none}[type=3Dcheckbox][role=3Dswitch]{--pico-backgro=
und-color:var(--pico-switch-background-color);--pico-color:var(--pico-switc=
h-color);width:2.25em;height:1.25em;border:var(--pico-border-width) solid v=
ar(--pico-border-color);border-radius:1.25em;background-color:var(--pico-ba=
ckground-color);line-height:1.25em}[type=3Dcheckbox][role=3Dswitch]:not([ar=
ia-invalid]){--pico-border-color:var(--pico-switch-background-color)}[type=
=3Dcheckbox][role=3Dswitch]:before{display:block;aspect-ratio:1;height:100%=
;border-radius:50%;background-color:var(--pico-color);box-shadow:var(--pico=
-switch-thumb-box-shadow);content:"";transition:margin .1s ease-in-out}[typ=
e=3Dcheckbox][role=3Dswitch]:focus{--pico-background-color:var(--pico-switc=
h-background-color);--pico-border-color:var(--pico-switch-background-color)=
}[type=3Dcheckbox][role=3Dswitch]:checked{--pico-background-color:var(--pic=
o-switch-checked-background-color);--pico-border-color:var(--pico-switch-ch=
ecked-background-color);background-image:none}[type=3Dcheckbox][role=3Dswit=
ch]:checked::before{margin-inline-start:calc(2.25em - 1.25em)}[type=3Dcheck=
box][role=3Dswitch][disabled]{--pico-background-color:var(--pico-border-col=
or)}[type=3Dcheckbox][aria-invalid=3Dfalse]:checked,[type=3Dcheckbox][aria-=
invalid=3Dfalse]:checked:active,[type=3Dcheckbox][aria-invalid=3Dfalse]:che=
cked:focus,[type=3Dcheckbox][role=3Dswitch][aria-invalid=3Dfalse]:checked,[=
type=3Dcheckbox][role=3Dswitch][aria-invalid=3Dfalse]:checked:active,[type=
=3Dcheckbox][role=3Dswitch][aria-invalid=3Dfalse]:checked:focus{--pico-back=
ground-color:var(--pico-form-element-valid-border-color)}[type=3Dcheckbox]:=
checked:active[aria-invalid=3Dtrue],[type=3Dcheckbox]:checked:focus[aria-in=
valid=3Dtrue],[type=3Dcheckbox]:checked[aria-invalid=3Dtrue],[type=3Dcheckb=
ox][role=3Dswitch]:checked:active[aria-invalid=3Dtrue],[type=3Dcheckbox][ro=
le=3Dswitch]:checked:focus[aria-invalid=3Dtrue],[type=3Dcheckbox][role=3Dsw=
itch]:checked[aria-invalid=3Dtrue]{--pico-background-color:var(--pico-form-=
element-invalid-border-color)}[type=3Dcheckbox][aria-invalid=3Dfalse]:check=
ed,[type=3Dcheckbox][aria-invalid=3Dfalse]:checked:active,[type=3Dcheckbox]=
[aria-invalid=3Dfalse]:checked:focus,[type=3Dcheckbox][role=3Dswitch][aria-=
invalid=3Dfalse]:checked,[type=3Dcheckbox][role=3Dswitch][aria-invalid=3Dfa=
lse]:checked:active,[type=3Dcheckbox][role=3Dswitch][aria-invalid=3Dfalse]:=
checked:focus,[type=3Dradio][aria-invalid=3Dfalse]:checked,[type=3Dradio][a=
ria-invalid=3Dfalse]:checked:active,[type=3Dradio][aria-invalid=3Dfalse]:ch=
ecked:focus{--pico-border-color:var(--pico-form-element-valid-border-color)=
}[type=3Dcheckbox]:checked:active[aria-invalid=3Dtrue],[type=3Dcheckbox]:ch=
ecked:focus[aria-invalid=3Dtrue],[type=3Dcheckbox]:checked[aria-invalid=3Dt=
rue],[type=3Dcheckbox][role=3Dswitch]:checked:active[aria-invalid=3Dtrue],[=
type=3Dcheckbox][role=3Dswitch]:checked:focus[aria-invalid=3Dtrue],[type=3D=
checkbox][role=3Dswitch]:checked[aria-invalid=3Dtrue],[type=3Dradio]:checke=
d:active[aria-invalid=3Dtrue],[type=3Dradio]:checked:focus[aria-invalid=3Dt=
rue],[type=3Dradio]:checked[aria-invalid=3Dtrue]{--pico-border-color:var(--=
pico-form-element-invalid-border-color)}[type=3Dcolor]::-webkit-color-swatc=
h-wrapper{padding:0}[type=3Dcolor]::-moz-focus-inner{padding:0}[type=3Dcolo=
r]::-webkit-color-swatch{border:0;border-radius:calc(var(--pico-border-radi=
us) * .5)}[type=3Dcolor]::-moz-color-swatch{border:0;border-radius:calc(var=
(--pico-border-radius) * .5)}input:not([type=3Dcheckbox],[type=3Dradio],[ty=
pe=3Drange],[type=3Dfile]):is([type=3Ddate],[type=3Ddatetime-local],[type=
=3Dmonth],[type=3Dtime],[type=3Dweek]){--pico-icon-position:0.75rem;--pico-=
icon-width:1rem;padding-right:calc(var(--pico-icon-width) + var(--pico-icon=
-position));background-image:var(--pico-icon-date);background-position:cent=
er right var(--pico-icon-position);background-size:var(--pico-icon-width) a=
uto;background-repeat:no-repeat}input:not([type=3Dcheckbox],[type=3Dradio],=
[type=3Drange],[type=3Dfile])[type=3Dtime]{background-image:var(--pico-icon=
-time)}[type=3Ddate]::-webkit-calendar-picker-indicator,[type=3Ddatetime-lo=
cal]::-webkit-calendar-picker-indicator,[type=3Dmonth]::-webkit-calendar-pi=
cker-indicator,[type=3Dtime]::-webkit-calendar-picker-indicator,[type=3Dwee=
k]::-webkit-calendar-picker-indicator{width:var(--pico-icon-width);margin-r=
ight:calc(var(--pico-icon-width) * -1);margin-left:var(--pico-icon-position=
);opacity:0}@-moz-document url-prefix(){[type=3Ddate],[type=3Ddatetime-loca=
l],[type=3Dmonth],[type=3Dtime],[type=3Dweek]{padding-right:var(--pico-form=
-element-spacing-horizontal)!important;background-image:none!important}}[di=
r=3Drtl] :is([type=3Ddate],[type=3Ddatetime-local],[type=3Dmonth],[type=3Dt=
ime],[type=3Dweek]){text-align:right}[type=3Dfile]{--pico-color:var(--pico-=
muted-color);margin-left:calc(var(--pico-outline-width) * -1);padding:calc(=
var(--pico-form-element-spacing-vertical) * .5) 0;padding-left:var(--pico-o=
utline-width);border:0;border-radius:0;background:0 0}[type=3Dfile]::file-s=
elector-button{margin-right:calc(var(--pico-spacing)/ 2);padding:calc(var(-=
-pico-form-element-spacing-vertical) * .5) var(--pico-form-element-spacing-=
horizontal)}[type=3Dfile]:is(:hover,:active,:focus)::file-selector-button{-=
-pico-background-color:var(--pico-secondary-hover-background);--pico-border=
-color:var(--pico-secondary-hover-border)}[type=3Dfile]:focus::file-selecto=
r-button{--pico-box-shadow:var(--pico-button-hover-box-shadow, 0 0 0 rgba(0=
, 0, 0, 0)),0 0 0 var(--pico-outline-width) var(--pico-secondary-focus)}[ty=
pe=3Drange]{-webkit-appearance:none;-moz-appearance:none;appearance:none;wi=
dth:100%;height:1.25rem;background:0 0}[type=3Drange]::-webkit-slider-runna=
ble-track{width:100%;height:.375rem;border-radius:var(--pico-border-radius)=
;background-color:var(--pico-range-border-color);-webkit-transition:backgro=
und-color var(--pico-transition),box-shadow var(--pico-transition);transiti=
on:background-color var(--pico-transition),box-shadow var(--pico-transition=
)}[type=3Drange]::-moz-range-track{width:100%;height:.375rem;border-radius:=
var(--pico-border-radius);background-color:var(--pico-range-border-color);-=
moz-transition:background-color var(--pico-transition),box-shadow var(--pic=
o-transition);transition:background-color var(--pico-transition),box-shadow=
 var(--pico-transition)}[type=3Drange]::-ms-track{width:100%;height:.375rem=
;border-radius:var(--pico-border-radius);background-color:var(--pico-range-=
border-color);-ms-transition:background-color var(--pico-transition),box-sh=
adow var(--pico-transition);transition:background-color var(--pico-transiti=
on),box-shadow var(--pico-transition)}[type=3Drange]::-webkit-slider-thumb{=
-webkit-appearance:none;width:1.25rem;height:1.25rem;margin-top:-.4375rem;b=
order:2px solid var(--pico-range-thumb-border-color);border-radius:50%;back=
ground-color:var(--pico-range-thumb-color);cursor:pointer;-webkit-transitio=
n:background-color var(--pico-transition),transform var(--pico-transition);=
transition:background-color var(--pico-transition),transform var(--pico-tra=
nsition)}[type=3Drange]::-moz-range-thumb{-webkit-appearance:none;width:1.2=
5rem;height:1.25rem;margin-top:-.4375rem;border:2px solid var(--pico-range-=
thumb-border-color);border-radius:50%;background-color:var(--pico-range-thu=
mb-color);cursor:pointer;-moz-transition:background-color var(--pico-transi=
tion),transform var(--pico-transition);transition:background-color var(--pi=
co-transition),transform var(--pico-transition)}[type=3Drange]::-ms-thumb{-=
webkit-appearance:none;width:1.25rem;height:1.25rem;margin-top:-.4375rem;bo=
rder:2px solid var(--pico-range-thumb-border-color);border-radius:50%;backg=
round-color:var(--pico-range-thumb-color);cursor:pointer;-ms-transition:bac=
kground-color var(--pico-transition),transform var(--pico-transition);trans=
ition:background-color var(--pico-transition),transform var(--pico-transiti=
on)}[type=3Drange]:active,[type=3Drange]:focus-within{--pico-range-border-c=
olor:var(--pico-range-active-border-color);--pico-range-thumb-color:var(--p=
ico-range-thumb-active-color)}[type=3Drange]:active::-webkit-slider-thumb{t=
ransform:scale(1.25)}[type=3Drange]:active::-moz-range-thumb{transform:scal=
e(1.25)}[type=3Drange]:active::-ms-thumb{transform:scale(1.25)}input:not([t=
ype=3Dcheckbox],[type=3Dradio],[type=3Drange],[type=3Dfile])[type=3Dsearch]=
{padding-inline-start:calc(var(--pico-form-element-spacing-horizontal) + 1.=
75rem);background-image:var(--pico-icon-search);background-position:center =
left calc(var(--pico-form-element-spacing-horizontal) + .125rem);background=
-size:1rem auto;background-repeat:no-repeat}input:not([type=3Dcheckbox],[ty=
pe=3Dradio],[type=3Drange],[type=3Dfile])[type=3Dsearch][aria-invalid]{padd=
ing-inline-start:calc(var(--pico-form-element-spacing-horizontal) + 1.75rem=
)!important;background-position:center left 1.125rem,center right .75rem}in=
put:not([type=3Dcheckbox],[type=3Dradio],[type=3Drange],[type=3Dfile])[type=
=3Dsearch][aria-invalid=3Dfalse]{background-image:var(--pico-icon-search),v=
ar(--pico-icon-valid)}input:not([type=3Dcheckbox],[type=3Dradio],[type=3Dra=
nge],[type=3Dfile])[type=3Dsearch][aria-invalid=3Dtrue]{background-image:va=
r(--pico-icon-search),var(--pico-icon-invalid)}[dir=3Drtl] :where(input):no=
t([type=3Dcheckbox],[type=3Dradio],[type=3Drange],[type=3Dfile])[type=3Dsea=
rch]{background-position:center right 1.125rem}[dir=3Drtl] :where(input):no=
t([type=3Dcheckbox],[type=3Dradio],[type=3Drange],[type=3Dfile])[type=3Dsea=
rch][aria-invalid]{background-position:center right 1.125rem,center left .7=
5rem}details{display:block;margin-bottom:var(--pico-spacing)}details summar=
y{line-height:1rem;list-style-type:none;cursor:pointer;transition:color var=
(--pico-transition)}details summary:not([role]){color:var(--pico-accordion-=
close-summary-color)}details summary::-webkit-details-marker{display:none}d=
etails summary::marker{display:none}details summary::-moz-list-bullet{list-=
style-type:none}details summary::after{display:block;width:1rem;height:1rem=
;margin-inline-start:calc(var(--pico-spacing,1rem) * .5);float:right;transf=
orm:rotate(-90deg);background-image:var(--pico-icon-chevron);background-pos=
ition:right center;background-size:1rem auto;background-repeat:no-repeat;co=
ntent:"";transition:transform var(--pico-transition)}details summary:focus{=
outline:0}details summary:focus:not([role]){color:var(--pico-accordion-acti=
ve-summary-color)}details summary:focus-visible:not([role]){outline:var(--p=
ico-outline-width) solid var(--pico-primary-focus);outline-offset:calc(var(=
--pico-spacing,1rem) * 0.5);color:var(--pico-primary)}details summary[role=
=3Dbutton]{width:100%;text-align:left}details summary[role=3Dbutton]::after=
{height:calc(1rem * var(--pico-line-height,1.5))}details[open]>summary{marg=
in-bottom:var(--pico-spacing)}details[open]>summary:not([role]):not(:focus)=
{color:var(--pico-accordion-open-summary-color)}details[open]>summary::afte=
r{transform:rotate(0)}[dir=3Drtl] details summary{text-align:right}[dir=3Dr=
tl] details summary::after{float:left;background-position:left center}artic=
le{margin-bottom:var(--pico-block-spacing-vertical);padding:var(--pico-bloc=
k-spacing-vertical) var(--pico-block-spacing-horizontal);border-radius:var(=
--pico-border-radius);background:var(--pico-card-background-color);box-shad=
ow:var(--pico-card-box-shadow)}article>footer,article>header{margin-right:c=
alc(var(--pico-block-spacing-horizontal) * -1);margin-left:calc(var(--pico-=
block-spacing-horizontal) * -1);padding:calc(var(--pico-block-spacing-verti=
cal) * .66) var(--pico-block-spacing-horizontal);background-color:var(--pic=
o-card-sectioning-background-color)}article>header{margin-top:calc(var(--pi=
co-block-spacing-vertical) * -1);margin-bottom:var(--pico-block-spacing-ver=
tical);border-bottom:var(--pico-border-width) solid var(--pico-card-border-=
color);border-top-right-radius:var(--pico-border-radius);border-top-left-ra=
dius:var(--pico-border-radius)}article>footer{margin-top:var(--pico-block-s=
pacing-vertical);margin-bottom:calc(var(--pico-block-spacing-vertical) * -1=
);border-top:var(--pico-border-width) solid var(--pico-card-border-color);b=
order-bottom-right-radius:var(--pico-border-radius);border-bottom-left-radi=
us:var(--pico-border-radius)}[role=3Dgroup],[role=3Dsearch]{display:inline-=
flex;position:relative;width:100%;margin-bottom:var(--pico-spacing);border-=
radius:var(--pico-border-radius);box-shadow:var(--pico-group-box-shadow,0 0=
 0 transparent);vertical-align:middle;transition:box-shadow var(--pico-tran=
sition)}[role=3Dgroup] input:not([type=3Dcheckbox],[type=3Dradio]),[role=3D=
group] select,[role=3Dgroup]>*,[role=3Dsearch] input:not([type=3Dcheckbox],=
[type=3Dradio]),[role=3Dsearch] select,[role=3Dsearch]>*{position:relative;=
flex:1 1 auto;margin-bottom:0}[role=3Dgroup] input:not([type=3Dcheckbox],[t=
ype=3Dradio]):not(:first-child),[role=3Dgroup] select:not(:first-child),[ro=
le=3Dgroup]>:not(:first-child),[role=3Dsearch] input:not([type=3Dcheckbox],=
[type=3Dradio]):not(:first-child),[role=3Dsearch] select:not(:first-child),=
[role=3Dsearch]>:not(:first-child){margin-left:0;border-top-left-radius:0;b=
order-bottom-left-radius:0}[role=3Dgroup] input:not([type=3Dcheckbox],[type=
=3Dradio]):not(:last-child),[role=3Dgroup] select:not(:last-child),[role=3D=
group]>:not(:last-child),[role=3Dsearch] input:not([type=3Dcheckbox],[type=
=3Dradio]):not(:last-child),[role=3Dsearch] select:not(:last-child),[role=
=3Dsearch]>:not(:last-child){border-top-right-radius:0;border-bottom-right-=
radius:0}[role=3Dgroup] input:not([type=3Dcheckbox],[type=3Dradio]):focus,[=
role=3Dgroup] select:focus,[role=3Dgroup]>:focus,[role=3Dsearch] input:not(=
[type=3Dcheckbox],[type=3Dradio]):focus,[role=3Dsearch] select:focus,[role=
=3Dsearch]>:focus{z-index:2}[role=3Dgroup] [role=3Dbutton]:not(:first-child=
),[role=3Dgroup] [type=3Dbutton]:not(:first-child),[role=3Dgroup] [type=3Dr=
eset]:not(:first-child),[role=3Dgroup] [type=3Dsubmit]:not(:first-child),[r=
ole=3Dgroup] button:not(:first-child),[role=3Dgroup] input:not([type=3Dchec=
kbox],[type=3Dradio]):not(:first-child),[role=3Dgroup] select:not(:first-ch=
ild),[role=3Dsearch] [role=3Dbutton]:not(:first-child),[role=3Dsearch] [typ=
e=3Dbutton]:not(:first-child),[role=3Dsearch] [type=3Dreset]:not(:first-chi=
ld),[role=3Dsearch] [type=3Dsubmit]:not(:first-child),[role=3Dsearch] butto=
n:not(:first-child),[role=3Dsearch] input:not([type=3Dcheckbox],[type=3Drad=
io]):not(:first-child),[role=3Dsearch] select:not(:first-child){margin-left=
:calc(var(--pico-border-width) * -1)}[role=3Dgroup] [role=3Dbutton],[role=
=3Dgroup] [type=3Dbutton],[role=3Dgroup] [type=3Dreset],[role=3Dgroup] [typ=
e=3Dsubmit],[role=3Dgroup] button,[role=3Dsearch] [role=3Dbutton],[role=3Ds=
earch] [type=3Dbutton],[role=3Dsearch] [type=3Dreset],[role=3Dsearch] [type=
=3Dsubmit],[role=3Dsearch] button{width:auto}@supports selector(:has(*)){[r=
ole=3Dgroup]:has(button:focus,[type=3Dsubmit]:focus,[type=3Dbutton]:focus,[=
role=3Dbutton]:focus),[role=3Dsearch]:has(button:focus,[type=3Dsubmit]:focu=
s,[type=3Dbutton]:focus,[role=3Dbutton]:focus){--pico-group-box-shadow:var(=
--pico-group-box-shadow-focus-with-button)}[role=3Dgroup]:has(button:focus,=
[type=3Dsubmit]:focus,[type=3Dbutton]:focus,[role=3Dbutton]:focus) input:no=
t([type=3Dcheckbox],[type=3Dradio]),[role=3Dgroup]:has(button:focus,[type=
=3Dsubmit]:focus,[type=3Dbutton]:focus,[role=3Dbutton]:focus) select,[role=
=3Dsearch]:has(button:focus,[type=3Dsubmit]:focus,[type=3Dbutton]:focus,[ro=
le=3Dbutton]:focus) input:not([type=3Dcheckbox],[type=3Dradio]),[role=3Dsea=
rch]:has(button:focus,[type=3Dsubmit]:focus,[type=3Dbutton]:focus,[role=3Db=
utton]:focus) select{border-color:transparent}[role=3Dgroup]:has(input:not(=
[type=3Dsubmit],[type=3Dbutton]):focus,select:focus),[role=3Dsearch]:has(in=
put:not([type=3Dsubmit],[type=3Dbutton]):focus,select:focus){--pico-group-b=
ox-shadow:var(--pico-group-box-shadow-focus-with-input)}[role=3Dgroup]:has(=
input:not([type=3Dsubmit],[type=3Dbutton]):focus,select:focus) [role=3Dbutt=
on],[role=3Dgroup]:has(input:not([type=3Dsubmit],[type=3Dbutton]):focus,sel=
ect:focus) [type=3Dbutton],[role=3Dgroup]:has(input:not([type=3Dsubmit],[ty=
pe=3Dbutton]):focus,select:focus) [type=3Dsubmit],[role=3Dgroup]:has(input:=
not([type=3Dsubmit],[type=3Dbutton]):focus,select:focus) button,[role=3Dsea=
rch]:has(input:not([type=3Dsubmit],[type=3Dbutton]):focus,select:focus) [ro=
le=3Dbutton],[role=3Dsearch]:has(input:not([type=3Dsubmit],[type=3Dbutton])=
:focus,select:focus) [type=3Dbutton],[role=3Dsearch]:has(input:not([type=3D=
submit],[type=3Dbutton]):focus,select:focus) [type=3Dsubmit],[role=3Dsearch=
]:has(input:not([type=3Dsubmit],[type=3Dbutton]):focus,select:focus) button=
{--pico-button-box-shadow:0 0 0 var(--pico-border-width) var(--pico-primary=
-border);--pico-button-hover-box-shadow:0 0 0 var(--pico-border-width) var(=
--pico-primary-hover-border)}[role=3Dgroup] [role=3Dbutton]:focus,[role=3Dg=
roup] [type=3Dbutton]:focus,[role=3Dgroup] [type=3Dreset]:focus,[role=3Dgro=
up] [type=3Dsubmit]:focus,[role=3Dgroup] button:focus,[role=3Dsearch] [role=
=3Dbutton]:focus,[role=3Dsearch] [type=3Dbutton]:focus,[role=3Dsearch] [typ=
e=3Dreset]:focus,[role=3Dsearch] [type=3Dsubmit]:focus,[role=3Dsearch] butt=
on:focus{box-shadow:none}}[role=3Dsearch]>:first-child{border-top-left-radi=
us:5rem;border-bottom-left-radius:5rem}[role=3Dsearch]>:last-child{border-t=
op-right-radius:5rem;border-bottom-right-radius:5rem}[aria-busy=3Dtrue]:not=
(input,select,textarea,html,form){white-space:nowrap}[aria-busy=3Dtrue]:not=
(input,select,textarea,html,form)::before{display:inline-block;width:1em;he=
ight:1em;background-image:var(--pico-icon-loading);background-size:1em auto=
;background-repeat:no-repeat;content:"";vertical-align:-.125em}[aria-busy=
=3Dtrue]:not(input,select,textarea,html,form):not(:empty)::before{margin-in=
line-end:calc(var(--pico-spacing) * .5)}[aria-busy=3Dtrue]:not(input,select=
,textarea,html,form):empty{text-align:center}[role=3Dbutton][aria-busy=3Dtr=
ue],[type=3Dbutton][aria-busy=3Dtrue],[type=3Dreset][aria-busy=3Dtrue],[typ=
e=3Dsubmit][aria-busy=3Dtrue],a[aria-busy=3Dtrue],button[aria-busy=3Dtrue]{=
pointer-events:none}:host,:root{--pico-scrollbar-width:0px}dialog{display:f=
lex;z-index:999;position:fixed;top:0;right:0;bottom:0;left:0;align-items:ce=
nter;justify-content:center;width:inherit;min-width:100%;height:inherit;min=
-height:100%;padding:0;border:0;-webkit-backdrop-filter:var(--pico-modal-ov=
erlay-backdrop-filter);backdrop-filter:var(--pico-modal-overlay-backdrop-fi=
lter);background-color:var(--pico-modal-overlay-background-color);color:var=
(--pico-color)}dialog>article{width:100%;max-height:calc(100vh - var(--pico=
-spacing) * 2);margin:var(--pico-spacing);overflow:auto}@media (min-width:5=
76px){dialog>article{max-width:510px}}@media (min-width:768px){dialog>artic=
le{max-width:700px}}dialog>article>header>*{margin-bottom:0}dialog>article>=
header :is(a,button)[rel=3Dprev]{margin:0;margin-left:var(--pico-spacing);p=
adding:0;float:right}dialog>article>footer{text-align:right}dialog>article>=
footer [role=3Dbutton],dialog>article>footer button{margin-bottom:0}dialog>=
article>footer [role=3Dbutton]:not(:first-of-type),dialog>article>footer bu=
tton:not(:first-of-type){margin-left:calc(var(--pico-spacing) * .5)}dialog>=
article :is(a,button)[rel=3Dprev]{display:block;width:1rem;height:1rem;marg=
in-top:calc(var(--pico-spacing) * -1);margin-bottom:var(--pico-spacing);mar=
gin-left:auto;border:none;background-image:var(--pico-icon-close);backgroun=
d-position:center;background-size:auto 1rem;background-repeat:no-repeat;bac=
kground-color:transparent;opacity:.5;transition:opacity var(--pico-transiti=
on)}dialog>article :is(a,button)[rel=3Dprev]:is([aria-current]:not([aria-cu=
rrent=3Dfalse]),:hover,:active,:focus){opacity:1}dialog:not([open]),dialog[=
open=3Dfalse]{display:none}:where(nav li)::before{float:left;content:"=E2=
=80=8B"}nav,nav ul{display:flex}nav{justify-content:space-between;overflow:=
visible}nav ol,nav ul{align-items:center;margin-bottom:0;padding:0;list-sty=
le:none}nav ol:first-of-type,nav ul:first-of-type{margin-left:calc(var(--pi=
co-nav-element-spacing-horizontal) * -1)}nav ol:last-of-type,nav ul:last-of=
-type{margin-right:calc(var(--pico-nav-element-spacing-horizontal) * -1)}na=
v li{display:inline-block;margin:0;padding:var(--pico-nav-element-spacing-v=
ertical) var(--pico-nav-element-spacing-horizontal)}nav li :where(a,[role=
=3Dlink]){display:inline-block;margin:calc(var(--pico-nav-link-spacing-vert=
ical) * -1) calc(var(--pico-nav-link-spacing-horizontal) * -1);padding:var(=
--pico-nav-link-spacing-vertical) var(--pico-nav-link-spacing-horizontal);b=
order-radius:var(--pico-border-radius)}nav li :where(a,[role=3Dlink]):not(:=
hover){text-decoration:none}nav li [role=3Dbutton],nav li [type=3Dbutton],n=
av li button,nav li input:not([type=3Dcheckbox],[type=3Dradio],[type=3Drang=
e],[type=3Dfile]),nav li select{height:auto;margin-right:inherit;margin-bot=
tom:0;margin-left:inherit;padding:calc(var(--pico-nav-link-spacing-vertical=
) - var(--pico-border-width) * 2) var(--pico-nav-link-spacing-horizontal)}n=
av[aria-label=3Dbreadcrumb]{align-items:center;justify-content:start}nav[ar=
ia-label=3Dbreadcrumb] ul li:not(:first-child){margin-inline-start:var(--pi=
co-nav-link-spacing-horizontal)}nav[aria-label=3Dbreadcrumb] ul li a{margin=
:calc(var(--pico-nav-link-spacing-vertical) * -1) 0;margin-inline-start:cal=
c(var(--pico-nav-link-spacing-horizontal) * -1)}nav[aria-label=3Dbreadcrumb=
] ul li:not(:last-child)::after{display:inline-block;position:absolute;widt=
h:calc(var(--pico-nav-link-spacing-horizontal) * 4);margin:0 calc(var(--pic=
o-nav-link-spacing-horizontal) * -1);content:var(--pico-nav-breadcrumb-divi=
der);color:var(--pico-muted-color);text-align:center;text-decoration:none;w=
hite-space:nowrap}nav[aria-label=3Dbreadcrumb] a[aria-current]:not([aria-cu=
rrent=3Dfalse]){background-color:transparent;color:inherit;text-decoration:=
none;pointer-events:none}aside li,aside nav,aside ol,aside ul{display:block=
}aside li{padding:calc(var(--pico-nav-element-spacing-vertical) * .5) var(-=
-pico-nav-element-spacing-horizontal)}aside li a{display:block}aside li [ro=
le=3Dbutton]{margin:inherit}[dir=3Drtl] nav[aria-label=3Dbreadcrumb] ul li:=
not(:last-child) ::after{content:"\\"}progress{display:inline-block;vertica=
l-align:baseline}progress{-webkit-appearance:none;-moz-appearance:none;disp=
lay:inline-block;appearance:none;width:100%;height:.5rem;margin-bottom:calc=
(var(--pico-spacing) * .5);overflow:hidden;border:0;border-radius:var(--pic=
o-border-radius);background-color:var(--pico-progress-background-color);col=
or:var(--pico-progress-color)}progress::-webkit-progress-bar{border-radius:=
var(--pico-border-radius);background:0 0}progress[value]::-webkit-progress-=
value{background-color:var(--pico-progress-color);-webkit-transition:inline=
-size var(--pico-transition);transition:inline-size var(--pico-transition)}=
progress::-moz-progress-bar{background-color:var(--pico-progress-color)}@me=
dia (prefers-reduced-motion:no-preference){progress:indeterminate{backgroun=
d:var(--pico-progress-background-color) linear-gradient(to right,var(--pico=
-progress-color) 30%,var(--pico-progress-background-color) 30%) top left/15=
0% 150% no-repeat;animation:progress-indeterminate 1s linear infinite}progr=
ess:indeterminate[value]::-webkit-progress-value{background-color:transpare=
nt}progress:indeterminate::-moz-progress-bar{background-color:transparent}}=
@media (prefers-reduced-motion:no-preference){[dir=3Drtl] progress:indeterm=
inate{animation-direction:reverse}}@keyframes progress-indeterminate{0%{bac=
kground-position:200% 0}100%{background-position:-200% 0}}[data-tooltip]{po=
sition:relative}[data-tooltip]:not(a,button,input,[role=3Dbutton]){border-b=
ottom:1px dotted;text-decoration:none;cursor:help}[data-tooltip]::after,[da=
ta-tooltip]::before,[data-tooltip][data-placement=3Dtop]::after,[data-toolt=
ip][data-placement=3Dtop]::before{display:block;z-index:99;position:absolut=
e;bottom:100%;left:50%;padding:.25rem .5rem;overflow:hidden;transform:trans=
late(-50%,-.25rem);border-radius:var(--pico-border-radius);background:var(-=
-pico-tooltip-background-color);content:attr(data-tooltip);color:var(--pico=
-tooltip-color);font-style:normal;font-weight:var(--pico-font-weight);font-=
size:.875rem;text-decoration:none;text-overflow:ellipsis;white-space:nowrap=
;opacity:0;pointer-events:none}[data-tooltip]::after,[data-tooltip][data-pl=
acement=3Dtop]::after{padding:0;transform:translate(-50%,0);border-top:.3re=
m solid;border-right:.3rem solid transparent;border-left:.3rem solid transp=
arent;border-radius:0;background-color:transparent;content:"";color:var(--p=
ico-tooltip-background-color)}[data-tooltip][data-placement=3Dbottom]::afte=
r,[data-tooltip][data-placement=3Dbottom]::before{top:100%;bottom:auto;tran=
sform:translate(-50%,.25rem)}[data-tooltip][data-placement=3Dbottom]:after{=
transform:translate(-50%,-.3rem);border:.3rem solid transparent;border-bott=
om:.3rem solid}[data-tooltip][data-placement=3Dleft]::after,[data-tooltip][=
data-placement=3Dleft]::before{top:50%;right:100%;bottom:auto;left:auto;tra=
nsform:translate(-.25rem,-50%)}[data-tooltip][data-placement=3Dleft]:after{=
transform:translate(.3rem,-50%);border:.3rem solid transparent;border-left:=
.3rem solid}[data-tooltip][data-placement=3Dright]::after,[data-tooltip][da=
ta-placement=3Dright]::before{top:50%;right:auto;bottom:auto;left:100%;tran=
sform:translate(.25rem,-50%)}[data-tooltip][data-placement=3Dright]:after{t=
ransform:translate(-.3rem,-50%);border:.3rem solid transparent;border-right=
:.3rem solid}[data-tooltip]:focus::after,[data-tooltip]:focus::before,[data=
-tooltip]:hover::after,[data-tooltip]:hover::before{opacity:1}@media (hover=
:hover) and (pointer:fine){[data-tooltip]:focus::after,[data-tooltip]:focus=
::before,[data-tooltip]:hover::after,[data-tooltip]:hover::before{--pico-to=
oltip-slide-to:translate(-50%, -0.25rem);transform:translate(-50%,.75rem);a=
nimation-duration:.2s;animation-fill-mode:forwards;animation-name:tooltip-s=
lide;opacity:0}[data-tooltip]:focus::after,[data-tooltip]:hover::after{--pi=
co-tooltip-caret-slide-to:translate(-50%, 0rem);transform:translate(-50%,-.=
25rem);animation-name:tooltip-caret-slide}[data-tooltip][data-placement=3Db=
ottom]:focus::after,[data-tooltip][data-placement=3Dbottom]:focus::before,[=
data-tooltip][data-placement=3Dbottom]:hover::after,[data-tooltip][data-pla=
cement=3Dbottom]:hover::before{--pico-tooltip-slide-to:translate(-50%, 0.25=
rem);transform:translate(-50%,-.75rem);animation-name:tooltip-slide}[data-t=
ooltip][data-placement=3Dbottom]:focus::after,[data-tooltip][data-placement=
=3Dbottom]:hover::after{--pico-tooltip-caret-slide-to:translate(-50%, -0.3r=
em);transform:translate(-50%,-.5rem);animation-name:tooltip-caret-slide}[da=
ta-tooltip][data-placement=3Dleft]:focus::after,[data-tooltip][data-placeme=
nt=3Dleft]:focus::before,[data-tooltip][data-placement=3Dleft]:hover::after=
,[data-tooltip][data-placement=3Dleft]:hover::before{--pico-tooltip-slide-t=
o:translate(-0.25rem, -50%);transform:translate(.75rem,-50%);animation-name=
:tooltip-slide}[data-tooltip][data-placement=3Dleft]:focus::after,[data-too=
ltip][data-placement=3Dleft]:hover::after{--pico-tooltip-caret-slide-to:tra=
nslate(0.3rem, -50%);transform:translate(.05rem,-50%);animation-name:toolti=
p-caret-slide}[data-tooltip][data-placement=3Dright]:focus::after,[data-too=
ltip][data-placement=3Dright]:focus::before,[data-tooltip][data-placement=
=3Dright]:hover::after,[data-tooltip][data-placement=3Dright]:hover::before=
{--pico-tooltip-slide-to:translate(0.25rem, -50%);transform:translate(-.75r=
em,-50%);animation-name:tooltip-slide}[data-tooltip][data-placement=3Dright=
]:focus::after,[data-tooltip][data-placement=3Dright]:hover::after{--pico-t=
ooltip-caret-slide-to:translate(-0.3rem, -50%);transform:translate(-.05rem,=
-50%);animation-name:tooltip-caret-slide}}@keyframes tooltip-slide{to{trans=
form:var(--pico-tooltip-slide-to);opacity:1}}@keyframes tooltip-caret-slide=
{50%{opacity:0}to{transform:var(--pico-tooltip-caret-slide-to);opacity:1}}[=
aria-controls]{cursor:pointer}[aria-disabled=3Dtrue],[disabled]{cursor:not-=
allowed}[aria-hidden=3Dfalse][hidden]{display:initial}[aria-hidden=3Dfalse]=
[hidden]:not(:focus){clip:rect(0,0,0,0);position:absolute}[tabindex],a,area=
,button,input,label,select,summary,textarea{-ms-touch-action:manipulation}[=
dir=3Drtl]{direction:rtl}@media (prefers-reduced-motion:reduce){:not([aria-=
busy=3Dtrue]),:not([aria-busy=3Dtrue])::after,:not([aria-busy=3Dtrue])::bef=
ore{background-attachment:initial!important;animation-duration:1ms!importan=
t;animation-delay:-1ms!important;animation-iteration-count:1!important;scro=
ll-behavior:auto!important;transition-delay:0s!important;transition-duratio=
n:0s!important}}
\ No newline at end of file
diff --git a/scripts/dashboard/resources/shared-styles.css b/scripts/dashbo=
ard/resources/shared-styles.css
new file mode 100644
index 0000000..fce74f0
--- /dev/null
+++ b/scripts/dashboard/resources/shared-styles.css
@@ -0,0 +1,75 @@
+/*=20
+
+Shared Styles for various Pico-styled Yocto web properties within this rep=
o:
+
+- Dashboard:                  https://dashboard.yoctoproject.org/
+- BugZilla Stats:             https://dashboard.yoctoproject.org/bugzilla_=
stats.html
+- Bug Triage:                 https://dashboard.yoctoproject.org/bugtriage/
+- Autobuilder Issue Summary:  https://valkyrie.yocto.io/pub/non-release/ab=
int/
+  This lives in `/scripts/abint` and since it lives under a different URL,=
 has its own copy of this file and related assets.
+
+The repo `yocto-metrics` also uses the same/similar styles for these pages:
+
+- Current CVE status for meta-openembedded:    https://valkyrie.yocto.io/p=
ub/non-release/patchmetrics-meta-oe/
+- Patchmetrics:                                https://valkyrie.yocto.io/p=
ub/non-release/patchmetrics/
+
+*/
+
+html {
+  scroll-behavior: smooth;
+  scroll-padding-top: 1em;
+}
+
+main {
+  font-size: 0.9em;
+}
+
+section {
+  max-width: 55rem;
+  margin-inline: 3rem;
+}
+
+.indented {
+  margin-inline: 3rem;
+}
+
+h1.with-logo{
+  position: relative;
+  margin-inline-start: 3rem;
+}
+
+h1.with-logo::before {
+  content: "";
+  background: url(apple-touch-icon.png);
+  width: 1em;
+  height: 1em;
+  display: block;
+  background-size: contain;
+  position: absolute;
+  left: -1.5em;
+  top: 0.05em;
+  border-radius: 10%;
+}
+
+h2 {
+  padding-top: 1em;
+}
+
+.header {
+  display: flex;
+  flex-direction: row;
+  flex-wrap: nowrap;
+  align-items: flex-start;
+  gap: 1em
+}
+
+.logo {
+  height: 2.6em;
+  border-radius: 10%;
+}
+
+.chart-container {
+  /* Apache eCharts like to have a container that already has a height */
+  height: 400px;
+  width: 100%;
+}
\ No newline at end of file
--=20
2.40.1


