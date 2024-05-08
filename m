Return-Path: <ninette@thehoodiefirm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84CCC25B77
	for <webhook@archiver.kernel.org>; Wed,  8 May 2024 15:31:43 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
 by mx.groups.io with SMTP id smtpd.web10.15795.1715182299001424972
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 08 May 2024 08:31:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@thehoodiefirm-com.20230601.gappssmtp.com header.s=20230601 header.b=GDN5uyjC;
 spf=neutral (domain: thehoodiefirm.com, ip: 209.85.218.49, mailfrom: ninette@thehoodiefirm.com)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59ab4f60a6so985934866b.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 08 May 2024 08:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thehoodiefirm-com.20230601.gappssmtp.com; s=20230601; t=1715182297; x=1715787097; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+5P8nTxUJ+jazXDRm3P2ARC74I+oESN6diBymaRMRLw=;
        b=GDN5uyjCz8UyfdLGAjr52HJ+2a5DB1bPMqtXv2jS5z+y57d/rkwvzXU2HZK4DuKXrC
         Bpbxvh1eBpbfVj1V1Zo+q5fvYKN8gmrdL/A7x351+ajOkJUwKdPxkVG9LJYmxQdYNPeL
         aRH+DN7Bl7NWIjDAt8bwmfFvfGTM9hcfH3ThRUyVXYnIpaHJrNdzPbl+PVo6oGgSkz3j
         IHgSigsBZVvr8COxWhpst7nw4egwtg557qxkaq275V/RlrNADfgbL+/mDufyDXXx61Ta
         hTGXtyPi6n2Ng48R5759NM+y/blonp1dgXdloLvd6sIhnDtqTrsCCKHcmXazXixmNbeh
         mB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715182297; x=1715787097;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+5P8nTxUJ+jazXDRm3P2ARC74I+oESN6diBymaRMRLw=;
        b=I7AjL6arGxNmfTz1g9Z5UZ/rFAfFcNmg2efEKvPY54GNx3Nkqvf0ogVyDnajPQozeq
         9Cbk5jl/c1x0jenRJ5zHHp9HoJ/nPFby0xklNelJsKesQC6BEztbk92H8Ypzot1UM9hm
         8QhMTKcJa+RqnR0W9FRQPWMSr7+D1Rw9Gt+A6k3VLnIqqM9gMq8mFS4m+6YEFb2PiwhG
         Qi68A1zDbYztazxOPkEY+S/dILkfC15vg+VNiEQ38X17uFQtXZjpHK45WeXDUO73bd1q
         VaxKCz43yjhSPNr8sdoksEqqCoQtSQkbgBxv08igXoh17WC1/7niBhI4geB+FTC/KeL9
         U7gg==
X-Gm-Message-State: AOJu0Yykt0cagkM7ptckJT0P0M2SoMVzbQLG5XWSVuqIq10+zCAXebo4
	ocX1o9iGkvCfTdxLGVpftfAZI2UjZlgBF641AAK5YZZYp74tpau7dmHPa+1i2qC/t+V+RSDns5G
	9
X-Google-Smtp-Source: AGHT+IEm+r4xqEo2MLtBgDIIr3yT+MVwgLGKGd1DbEysPIvj7I59sIclaxzx7Ptbw6ZNTQjvmi3TfA==
X-Received: by 2002:a17:906:6d51:b0:a59:9a68:7260 with SMTP id a640c23a62f3a-a59fb9c553amr261753166b.62.1715182297376;
        Wed, 08 May 2024 08:31:37 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aeba4.dynamic.kabel-deutschland.de. [95.90.235.164])
        by smtp.gmail.com with ESMTPSA id c17-20020a1709060fd100b00a526a992d82sm7784897ejk.4.2024.05.08.08.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 08:31:37 -0700 (PDT)
From: Ninette Adhikari <ninette@thehoodiefirm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: engineering@neighbourhood.ie,
	Alex Feyerke <hello@alexfeyerke.com>
Subject: [PATCH 03/12] index.html: clean up html and head sections
Date: Wed,  8 May 2024 17:31:18 +0200
Message-ID: <20240508153131.94270-4-ninette@thehoodiefirm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240508153131.94270-1-ninette@thehoodiefirm.com>
References: <20240508153131.94270-1-ninette@thehoodiefirm.com>
Reply-To: engineering@neighbourhood.ie
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 08 May 2024 15:31:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/94

From: Alex Feyerke <hello@alexfeyerke.com>

Adds favicons, language, charset and title declarations according to best practises, also adds missing closing tags.

Signed-off-by: Alex Feyerke <hello@alexfeyerke.com>
---
 patch-status/index.html                     |   9 +++++++++
 patch-status/resources/apple-touch-icon.png | Bin 0 -> 7683 bytes
 patch-status/resources/favicon-16x16.png    | Bin 0 -> 792 bytes
 patch-status/resources/favicon-32x32.png    | Bin 0 -> 1246 bytes
 4 files changed, 9 insertions(+)
 create mode 100644 patch-status/resources/apple-touch-icon.png
 create mode 100644 patch-status/resources/favicon-16x16.png
 create mode 100644 patch-status/resources/favicon-32x32.png

diff --git a/patch-status/index.html b/patch-status/index.html
index a114918e..86a6cf06 100644
--- a/patch-status/index.html
+++ b/patch-status/index.html
@@ -1,11 +1,17 @@
 <!DOCTYPE html>
+<html lang="en">
 <!--
 SPDX-License-Identifier: MIT
 -->
 
 <head>
+  <meta charset="UTF-8">
+  <meta title="Yocto Autobuilder Patch Metrics" <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <script src="resources/echarts.min.js"></script>
   <link rel="stylesheet" href="resources/pico.fluid.classless.min.css">
+  <link rel="apple-touch-icon" sizes="144x144" href="/resources/apple-touch-icon.png">
+  <link rel="icon" type="image/png" sizes="32x32" href="/resources/favicon-32x32.png">
+  <link rel="icon" type="image/png" sizes="16x16" href="/resources/favicon-16x16.png">
   <style>
     h3 {
       margin-left: 60px;
@@ -501,3 +507,6 @@ SPDX-License-Identifier: MIT
       recipeChart.setOption(recipeOption);
     }
   </script>
+</body>
+
+</html>
\ No newline at end of file
diff --git a/patch-status/resources/apple-touch-icon.png b/patch-status/resources/apple-touch-icon.png
new file mode 100644
index 0000000000000000000000000000000000000000..d11f8bd0f9c0d6a765c815986199c36504bdaf20
GIT binary patch
literal 7683
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

literal 0
HcmV?d00001

diff --git a/patch-status/resources/favicon-16x16.png b/patch-status/resources/favicon-16x16.png
new file mode 100644
index 0000000000000000000000000000000000000000..ba9765fb51ae810cab294ca1d695f691c7e18c1a
GIT binary patch
literal 792
zcmeAS@N?(olHy`uVBq!ia0vp^0wB!63?wyl`GbKJOS+@4BLl<6e(pbstU$g(vPY0F
z14ES>14Ba#1H&(%P{RubhEf9thF1v;3|2E37{m+a><Y92O1uj232`;15->6{%E-tl
zEiJXSwr*{0_4D&HG&HQOt-X5ns=mH{c6Rp7n>WM5!yOzPjvP5MW5x_CE32J5cP?47
z#KgqJz`&rmxVX2s_xkng5fKrF2Ktu1Nsj3gO)PATjg7v3{km}BLL(zXE5BsN%&8_8
zw)OS(PoF-GjEpokHrcv$>+<ExO-)T*TwJD4pML4mrI3&iM@Pqv8#kUjc`_v>#mvmi
z)z$U?|Nk#zBd-E|EnX7j7t9iQ>Gz*o8SGK7KIUJ1`s>D<Zw=4i*7K?_vo8iJVNCLN
zckyk=P)G%G*h@TpUD;o-a&Yi+^nElI2MR6qba4!kxa`}{F4W|}<GNT$<3@DYL{U*u
zmg@I=tN(xIIK?&7^Jl(Vy-<ULK}%jiVqAlVNUfrmz-DR1H3>38-y(DrC!Rhvy<zT_
zMOs&*Vi)sFaNE38I#*cIVfEs&>c0mIOy>PznArRB%pCn`+Tshg-pk2tmyKTd>t8{M
zeqlqURs6au%umYdZ8&#}S{#}F?O%4wlE)8UihNk~e`g6Bi{|T>G5bC+W~`H8Irr(a
z7tq0~C9V-ADTyViR>?)FK#IZ0z{o_`z*N`3BE-PL%Fx)#z(U)=z{<cN?xWl}6b-rg
zDVb@NxHagnSylwp5MC7$Q4*9`u24{vpO%@Es!&o{kgAYbP?F5RP%-E6CmxQ%Fb$1U
z{-@7)J`G}ER_4}A<`z~K_MR-lEUe(tU~)KxS$T7a!s#1VP8>ONMCJ(l=?0GlUV03#
X#05(}IhjrcTEXDy>gTe~DWM4fR(cu)

literal 0
HcmV?d00001

diff --git a/patch-status/resources/favicon-32x32.png b/patch-status/resources/favicon-32x32.png
new file mode 100644
index 0000000000000000000000000000000000000000..244edb606d7cfdd1c8bca17416d1911ff06d80f8
GIT binary patch
literal 1246
zcmeAS@N?(olHy`uVBq!ia0vp^3LwnE3?yBabR7dyEa{HEjtmSN`?>!lvVtU&J%W50
z7^>757#dm_7=8hT8eT9klo~KFyh>nTu$sZZAYL$MSD+081LOVxpAc7|0^<P%hK7bl
zMn)zkCf?rOv9Yn1mX^W6!66|bhYlUOd-rZ?YO1ZR?V2@f?%%&(S6Aof=Xd`6`Tzg_
zuUoe+BO~L*ix=O&e{XGVZEtUX{rYuYUY?DO&6zW2JUu;+A3wfz>sEVv`)}XA)z;R2
z{`~pfyLY9frKeAy_VV&FGBPwaGIDly-nVbx{{8!%oSf3r)6HChY$Hm|U4lzWO5VSJ
z|MBC;_3PLF`}fbp%F(rao!_jtZdIF2teqVk9G*RU*3#1AR<Y54_Ivl5?WQ&^+1c4I
zU%s?(3$u%@v+#&CHZk3>VS}*|&}#-378c8vExUN}qQAd?e0==9d-s0+{MpynXKHG?
zcJ11~fByyq1ax+Ge)#a=)2B~OO-<(J=2NFm{q^hD>eZ_q9Ua}=+@?>Te);m{A3uJ$
zxVYT9b!)<e35kh`RaI4HW@efpCk=s7s8tf=7tFvQU3UEazb}`&v>6?a{<#sua{puU
z;RjZwzgNDy^nLI3z}ObnN4%?k>|^^-Sbhhni!sUD-Nj~kR^oXehrPtp*OmPRD+dQJ
z=g)7<jX>#UPZ!4!i_^7}p9VWQiX45fwWy_Y?u}i$HIg1XA3UV@=9u4`cX=ECC5W@8
z#?AFlfA;6woxQ)GF)D}%tl$Vr+SlY9lEuq3E!+9<h80sD3QpvhV8-R`CElx`z;;^0
zjPH@~6NWh)T=P|rWNUn6E}8J8w5`eM@p^47lS}nXdwvTB7kaLIuA!^Fe#Mv74DsuC
zc5R-raq^N~$FdeXF-T{vE&a-JnT`8;gaTVYwea;jPLYnQdAoZOT%xPp)e~7`@4nI7
za$J$2>i3R+jgI*TFMQyTKTuMVbH~i^rDlP}@@461vNZ|oDvRpYlr~1T7Z+w$w(=)z
zdiCfAZ(UeK^!*!8`V;cE9Q_$~<KDsujyLZLf3yFKZ?b>%;l+<9BHm0}p1!I1-{irR
z^8M4RU&k7jHbj4(`}*I*iCzp}UjBS~HESdHC;J1jIkna0+@JRgw)Oj8p6=17cw;-W
zYJ|^(p46#KT1#~%aJ@3wY2(SS5vx8|Jtc*ytLNOLQ_V)3Z1-<h({taVV(ve`|ADmM
z`8}rExtg}X7*Z{9jVMV;EJ?LWE=mPb3`Pb<Cb|Zux&{^@1{PL^##RQF+6D$z1_nRc
zM5|CV<mRVjrd8tB(0O|;s5A+$3W+EQN-S3>D9TUE%t=)!sVqoU$Sf#HW?-n8^Y{}F
zM`4(T#wq{PXFQ(<F)%B0>m_pwD+_y17GV}vaA`0(oWiWUIYi;~jVmXPoH-(Mg#C1b
d#{w@shF9W(C7+y3rvj~D@O1TaS?83{1ORK00eJub

literal 0
HcmV?d00001

-- 
2.39.3 (Apple Git-145)


