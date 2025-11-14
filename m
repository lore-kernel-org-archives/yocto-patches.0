Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B587CCE7AF3
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 11:46:39 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16024.1763120793734492514
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 14 Nov 2025 03:46:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=MBkvcUNJ;
 spf=pass (domain: gmail.com, ip: 209.85.218.50, mailfrom: quaresma.jose@gmail.com)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b714b1290aeso281992266b.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 14 Nov 2025 03:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763120792; x=1763725592; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=STKG5Q4QEWtvRwhcXrYtU6t9Vi4N9yvmsBHZKTZRAkw=;
        b=MBkvcUNJz2XiCK1VYX9DVf8DgqmI4aa8kLugVlzVMpafRO3hf07zqA+95A9QDFAY3E
         ADfOZwQQ4dPE33FqZEHwLF6IO5FSoOWJua3J+YdV9VcnIWWrCK/HFRTHjDg6dCWcDWnT
         EABEoSAa1rrOJ3T+OXFEsS1NcmnV0qFzwBSToBcjdObK0ybr9Q6eRXB5Gen+13TWQGhw
         NcA6ksms5bVgHGxSEXUA7n9zuydkb6IudkdzjQ1PTmAjtqE+bto90zzhAaJRkbbWL0Sh
         +wrN+Vke4HxCtIAIPv55/uFHLJpw8fWwI59SS27lURu+IOJOVa/bgYkKHG52h9xWROnV
         vAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763120792; x=1763725592;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STKG5Q4QEWtvRwhcXrYtU6t9Vi4N9yvmsBHZKTZRAkw=;
        b=ONx2sq7Wb4jtBjLV38Kt9nUXaZQFLBC3NEN0chpyUMOZ53rRaGM3ZxRrXYAfoCCYle
         EEDX3QOxjmC8eG/yWv0cjsctsbfl3Ran3FFy2eVGB7Oh1hsKeJ+oO3uvP3coJtaglqPZ
         17GzfAtY2M3Zo0T8FJEVVJIFtjdoeZ3obBEN8xEJ47yFJcTrm40Ee/7vCNLoPztOVJKH
         Eb8b3bZhAuH8VY0453r6qgL3C1nAwKKsZtU71VsXr54qh0eM79MB0bA13eoW6yeKks7z
         3LYSOsyf7b3CzL+eLIuMWZDtyUDUOzS111g09BNXTJcBxR4e2CNwxpqlqtWnJOB7buhJ
         rkyA==
X-Gm-Message-State: AOJu0Yyb5qUYOXRkkWa1DqZwrPiNBZtpy+oLJgf9MM0/6og4LmpI0ZSO
	jMIPiUZhk5rr33gFWSkf5qf1w22F1NZsJo1Wbv5Ert0YppAxMftPDRL8dW18NK16m5elyUYtgpy
	52iRRJDa7WT0OQIYRJdq0qdv6v4E/NnLfoQqeZpU=
X-Gm-Gg: ASbGncvtyAlsr5sSjN/F6+hUmeT3SIs4rEHh2hV0Rjha99X6yHUgjNZISx8LJEoi/3r
	S8q/1Sa/QFpGp8oTC6ku7TOqFa15TrKmWRlOwl79nuLXsbikFC1vD9jwObXJCAYk9kz1Gg/kkyT
	iNCib5/DeScziPGvzdkHsk46PCnsOrzD8y8jgiHhufxRJlq0376sfoZnfpC5Ph9qR+Inv9c1SLi
	MovASerfxvA018anXWB8UKhoO99dRw3a5ewG+aF0d0Ndc5mXTcdQ5oEyJYw41UeICaobUxW
X-Google-Smtp-Source: AGHT+IHIz4zThpKNS/qNXlFkl4S+LMbikbQ0pkLbsKFLYQYou748RGKve7Y+8+875fKE0oWqtXGHt3vZklOjs3zWmJg=
X-Received: by 2002:a17:907:7246:b0:b73:301c:b158 with SMTP id
 a640c23a62f3a-b73677ed40bmr271863366b.6.1763120791157; Fri, 14 Nov 2025
 03:46:31 -0800 (PST)
MIME-Version: 1.0
References: <20251113125712.18914-1-peter.marko@siemens.com>
In-Reply-To: <20251113125712.18914-1-peter.marko@siemens.com>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Fri, 14 Nov 2025 11:46:19 +0000
X-Gm-Features: AWmQ_bnYD_tWO4QBAAyq0MaP00wo8naWaYbAQFQK51ALZD5Jo18y932mUYxB-EE
Message-ID: <CANPvuR=zdbNg=PJh+D32C=g6euOPCnOC73uVm2hH564O0MB+Rg@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-lts-mixins][scarthgap/go][RFC PATCH 00/34]
 initial scarthgap/go version
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com, jose.quaresma@foundries.io
Content-Type: multipart/alternative; boundary="00000000000074017806438c8c70"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 14 Nov 2025 11:46:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2562

--00000000000074017806438c8c70
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

Very nice work putting all of that in place and much better than the
kirkstone/go.
I will try to help in any way I can with the maintenance of the layer.

Thank you very much for the hard work.

Jose

Peter Marko via lists.yoctoproject.org <peter.marko=3D
siemens.com@lists.yoctoproject.org> escreveu (quinta, 13/11/2025 =C3=A0(s)
12:57):

> Hello everyone,
>
> here is initial draft of meta-lts-mixins scarthgap/go branch.
> Compared to kirkstone/go this now also contains proper testing.
> Functionality is I think equivalent to current kirsktone/go branch.
>
> Note that the testing depends on not-yet-merged series
>   https://lists.openembedded.org/g/openembedded-core/message/226238
>
> Creation notes:
> * base commit copied from kirkstone/go branch
>   * adapted release name and removed obsolete lines from layer.conf
> * all recipe changes from master were picked into this series except thos=
e
> not suitable for scarthgap
>   * 7321cc17ae5483f17fe9cdffea7b62acd9d9c3a2 meta: set S to be in
> UNPACKDIR in recipes that explicitly set
>   * 4ccc3bc8266c327bcc18c9a3faf7536210dfb9f0 classes/recipes: Switch
> virtual/XXX-gcc to virtual/cross-cc (and c++/binutils)
> * all test changes from master were submitted as backports to
> openembedded-core (link above)
> * 3 patches were sent to openembedded master branch upstream based on
> testing and file comparison
>   * https://lists.openembedded.org/g/openembedded-core/message/226226
> oeqa: fix package detection in go sdk tests
>   * https://lists.openembedded.org/g/openembedded-core/message/226231
> go-helloworld: fix license
>   * https://lists.openembedded.org/g/openembedded-core/message/226237
> oeqa: drop unnecessary dependency from go runtime tests
> * class/lib changes between scarthgap and master are following:
>   * $ git log --oneline
> 8f46f60a703defc3e74adad382320c129cef0b06..origin/master -- \
>         meta/classes/go-vendor.bbclass meta/classes-recipe/go.bbclass \
>         meta/classes-recipe/goarch.bbclass
> meta/classes-recipe/go-mod.bbclass \
>         meta/classes-recipe/go-ptest.bbclass
> meta/classes-recipe/go-mod-update-modules.bbclass
>     26368cfb91 go-mod-update-modules.bbclass: Update license finding
>     cfff8e9682 goarch.bbclass: do not leak TUNE_FEATURES into crosssdk
> task signatures
>     0aa406d058 recipetool/create_go: proxy module fetching to
> go-mod-update-modules
>     34bb889ffa classes/go-mod-update-modules: add class to generate modul=
e
> list
>     5f8218c626 go-mod.bbclass: Calculate GO_MOD_CACHE_DIR relative to
> ${UNPACKDIR}
>     374a91204b go: Check if GO_IMPORT is set in recipe and error if not
>     791ab77ac0 go: remove support for GOROOT_FINAL
>     30ea609d33 meta/meta-selftest: Fix variable assignment whitespace
>     6c4e3206b6 classes: go-vendor: Change symlink creation.
>     fc4f589cc7 go-vendor: Fix absolute paths issue
>     114fe16f96 classes/go-vendor: Use UNPACKDIR instead of WORKDIR
>     35496654db go-mod.bbclass: Unpack module dependency license files
>     287daff0bb go-mod.bbclass: Set GO_MOD_CACHE_DIR
>     cc4ec43a2b go: Drop fork of unpack code, mandate GO_SRCURI_DESTSUFFIX
>   * there are mostly changes to directory layout, fetching and style or
> new go-mod-update-modules class
>   * GOROOT_FINAL can be kept as unused variable like in scarthgap
>   * TUNE_FEATURES fix is being backported to scarthgap and kirkstone
> opembedded-core
>
> Peter
>
> ---
>
> Alexander Kanavin (4):
>   go-helloworld: update to latest revision
>   go-helloworld: update to latest revision
>   go-helloworld: update to latest revision
>   meta: remove consecutive blank lines
>
> Gyorgy Sarvari (1):
>   go-helloworld: update to latest revision
>
> Hongxu Jia (4):
>   go: upgrade 1.22.12 -> 1.24.0
>   go: fix buildpath issue for go-runtime
>   go: remove support for GOROOT_FINAL
>   tcmode-default: bump GOVERSION to 1.24.0
>
> Jose Quaresma (1):
>   Revert "go: Drop fork of unpack code, mandate GO_SRCURI_DESTSUFFIX"
>
> Khem Raj (1):
>   go-cross: Disable build with ccache
>
> Osama Abdelkader (1):
>   go-cross-canadian: fix binaries install and GOARCH
>
> Peter Marko (18):
>   Initial commit: add license, readme and layer config
>   go-helloworld: add from openembedded-core scarthgap
>   go: add from openembedded-core scarthgap
>   go-helloworld: fix license
>   go: upgrade 1.24.0 -> 1.24.1
>   go: upgrade 1.24.1 -> 1.24.2
>   go: upgrade 1.24.2 -> 1.24.3
>   go: upgrade 1.24.3 -> 1.24.4
>   go: set status of CVE-2024-3566
>   go: upgrade 1.24.4 -> 1.24.5
>   go: upgrade 1.24.5 -> 1.24.6
>   go: upgrade 1.24.6 -> 1.25.0
>   conf/layer: switch to golang 1.25
>   go: upgrade 1.25.0 -> 1.25.1
>   go: upgrade 1.25.1 -> 1.25.2
>   go: upgrade 1.25.2 -> 1.25.3
>   readme: update to markdown format
>   readme: add QA chapter
>
> Randolph Sapp (1):
>   go: fix sigaction usage on i386 platforms
>
> Richard Purdie (3):
>   go: Drop fork of unpack code, mandate GO_SRCURI_DESTSUFFIX
>   meta/meta-selftest: Fix variable assignment whitespace
>   go: Fix to work without gold on aarch64
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#2515):
> https://lists.yoctoproject.org/g/yocto-patches/message/2515
> Mute This Topic: https://lists.yoctoproject.org/mt/116273402/5052612
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://lists.yoctoproject.org/g/yocto-patches/leave/13170708/5052612/150=
4338242/xyzzy
> [quaresma.jose@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--=20
Best regards,

Jos=C3=A9 Quaresma

--00000000000074017806438c8c70
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Peter,<br><br>Very nice work putting all of that in pla=
ce and much better=C2=A0than the kirkstone/go.<div>I will try to help in an=
y way I can with the maintenance of the layer.<br><br>Thank you very much f=
or the hard work.<br><br>Jose</div></div><br><div class=3D"gmail_quote gmai=
l_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Peter Marko via <a=
 href=3D"http://lists.yoctoproject.org">lists.yoctoproject.org</a> &lt;pete=
r.marko=3D<a href=3D"mailto:siemens.com@lists.yoctoproject.org">siemens.com=
@lists.yoctoproject.org</a>&gt; escreveu (quinta, 13/11/2025 =C3=A0(s) 12:5=
7):<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hello everyo=
ne,<br>
<br>
here is initial draft of meta-lts-mixins scarthgap/go branch.<br>
Compared to kirkstone/go this now also contains proper testing.<br>
Functionality is I think equivalent to current kirsktone/go branch.<br>
<br>
Note that the testing depends on not-yet-merged series<br>
=C2=A0 <a href=3D"https://lists.openembedded.org/g/openembedded-core/messag=
e/226238" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.o=
rg/g/openembedded-core/message/226238</a><br>
<br>
Creation notes:<br>
* base commit copied from kirkstone/go branch<br>
=C2=A0 * adapted release name and removed obsolete lines from layer.conf<br=
>
* all recipe changes from master were picked into this series except those =
not suitable for scarthgap<br>
=C2=A0 * 7321cc17ae5483f17fe9cdffea7b62acd9d9c3a2 meta: set S to be in UNPA=
CKDIR in recipes that explicitly set<br>
=C2=A0 * 4ccc3bc8266c327bcc18c9a3faf7536210dfb9f0 classes/recipes: Switch v=
irtual/XXX-gcc to virtual/cross-cc (and c++/binutils)<br>
* all test changes from master were submitted as backports to openembedded-=
core (link above)<br>
* 3 patches were sent to openembedded master branch upstream based on testi=
ng and file comparison<br>
=C2=A0 * <a href=3D"https://lists.openembedded.org/g/openembedded-core/mess=
age/226226" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded=
.org/g/openembedded-core/message/226226</a> oeqa: fix package detection in =
go sdk tests<br>
=C2=A0 * <a href=3D"https://lists.openembedded.org/g/openembedded-core/mess=
age/226231" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded=
.org/g/openembedded-core/message/226231</a> go-helloworld: fix license<br>
=C2=A0 * <a href=3D"https://lists.openembedded.org/g/openembedded-core/mess=
age/226237" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded=
.org/g/openembedded-core/message/226237</a> oeqa: drop unnecessary dependen=
cy from go runtime tests<br>
* class/lib changes between scarthgap and master are following:<br>
=C2=A0 * $ git log --oneline 8f46f60a703defc3e74adad382320c129cef0b06..orig=
in/master -- \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 meta/classes/go-vendor.bbclass meta/classes-rec=
ipe/go.bbclass \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 meta/classes-recipe/goarch.bbclass meta/classes=
-recipe/go-mod.bbclass \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 meta/classes-recipe/go-ptest.bbclass meta/class=
es-recipe/go-mod-update-modules.bbclass<br>
=C2=A0 =C2=A0 26368cfb91 go-mod-update-modules.bbclass: Update license find=
ing<br>
=C2=A0 =C2=A0 cfff8e9682 goarch.bbclass: do not leak TUNE_FEATURES into cro=
sssdk task signatures<br>
=C2=A0 =C2=A0 0aa406d058 recipetool/create_go: proxy module fetching to go-=
mod-update-modules<br>
=C2=A0 =C2=A0 34bb889ffa classes/go-mod-update-modules: add class to genera=
te module list<br>
=C2=A0 =C2=A0 5f8218c626 go-mod.bbclass: Calculate GO_MOD_CACHE_DIR relativ=
e to ${UNPACKDIR}<br>
=C2=A0 =C2=A0 374a91204b go: Check if GO_IMPORT is set in recipe and error =
if not<br>
=C2=A0 =C2=A0 791ab77ac0 go: remove support for GOROOT_FINAL<br>
=C2=A0 =C2=A0 30ea609d33 meta/meta-selftest: Fix variable assignment whites=
pace<br>
=C2=A0 =C2=A0 6c4e3206b6 classes: go-vendor: Change symlink creation.<br>
=C2=A0 =C2=A0 fc4f589cc7 go-vendor: Fix absolute paths issue<br>
=C2=A0 =C2=A0 114fe16f96 classes/go-vendor: Use UNPACKDIR instead of WORKDI=
R<br>
=C2=A0 =C2=A0 35496654db go-mod.bbclass: Unpack module dependency license f=
iles<br>
=C2=A0 =C2=A0 287daff0bb go-mod.bbclass: Set GO_MOD_CACHE_DIR<br>
=C2=A0 =C2=A0 cc4ec43a2b go: Drop fork of unpack code, mandate GO_SRCURI_DE=
STSUFFIX<br>
=C2=A0 * there are mostly changes to directory layout, fetching and style o=
r new go-mod-update-modules class<br>
=C2=A0 * GOROOT_FINAL can be kept as unused variable like in scarthgap<br>
=C2=A0 * TUNE_FEATURES fix is being backported to scarthgap and kirkstone o=
pembedded-core<br>
<br>
Peter<br>
<br>
---<br>
<br>
Alexander Kanavin (4):<br>
=C2=A0 go-helloworld: update to latest revision<br>
=C2=A0 go-helloworld: update to latest revision<br>
=C2=A0 go-helloworld: update to latest revision<br>
=C2=A0 meta: remove consecutive blank lines<br>
<br>
Gyorgy Sarvari (1):<br>
=C2=A0 go-helloworld: update to latest revision<br>
<br>
Hongxu Jia (4):<br>
=C2=A0 go: upgrade 1.22.12 -&gt; 1.24.0<br>
=C2=A0 go: fix buildpath issue for go-runtime<br>
=C2=A0 go: remove support for GOROOT_FINAL<br>
=C2=A0 tcmode-default: bump GOVERSION to 1.24.0<br>
<br>
Jose Quaresma (1):<br>
=C2=A0 Revert &quot;go: Drop fork of unpack code, mandate GO_SRCURI_DESTSUF=
FIX&quot;<br>
<br>
Khem Raj (1):<br>
=C2=A0 go-cross: Disable build with ccache<br>
<br>
Osama Abdelkader (1):<br>
=C2=A0 go-cross-canadian: fix binaries install and GOARCH<br>
<br>
Peter Marko (18):<br>
=C2=A0 Initial commit: add license, readme and layer config<br>
=C2=A0 go-helloworld: add from openembedded-core scarthgap<br>
=C2=A0 go: add from openembedded-core scarthgap<br>
=C2=A0 go-helloworld: fix license<br>
=C2=A0 go: upgrade 1.24.0 -&gt; 1.24.1<br>
=C2=A0 go: upgrade 1.24.1 -&gt; 1.24.2<br>
=C2=A0 go: upgrade 1.24.2 -&gt; 1.24.3<br>
=C2=A0 go: upgrade 1.24.3 -&gt; 1.24.4<br>
=C2=A0 go: set status of CVE-2024-3566<br>
=C2=A0 go: upgrade 1.24.4 -&gt; 1.24.5<br>
=C2=A0 go: upgrade 1.24.5 -&gt; 1.24.6<br>
=C2=A0 go: upgrade 1.24.6 -&gt; 1.25.0<br>
=C2=A0 conf/layer: switch to golang 1.25<br>
=C2=A0 go: upgrade 1.25.0 -&gt; 1.25.1<br>
=C2=A0 go: upgrade 1.25.1 -&gt; 1.25.2<br>
=C2=A0 go: upgrade 1.25.2 -&gt; 1.25.3<br>
=C2=A0 readme: update to markdown format<br>
=C2=A0 readme: add QA chapter<br>
<br>
Randolph Sapp (1):<br>
=C2=A0 go: fix sigaction usage on i386 platforms<br>
<br>
Richard Purdie (3):<br>
=C2=A0 go: Drop fork of unpack code, mandate GO_SRCURI_DESTSUFFIX<br>
=C2=A0 meta/meta-selftest: Fix variable assignment whitespace<br>
=C2=A0 go: Fix to work without gold on aarch64<br>
<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#2515): <a href=3D"https://lists.yoctoproject.org/g/yoct=
o-patches/message/2515" rel=3D"noreferrer" target=3D"_blank">https://lists.=
yoctoproject.org/g/yocto-patches/message/2515</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/116273402/505=
2612" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/m=
t/116273402/5052612</a><br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leav=
e/13170708/5052612/1504338242/xyzzy" rel=3D"noreferrer" target=3D"_blank">h=
ttps://lists.yoctoproject.org/g/yocto-patches/leave/13170708/5052612/150433=
8242/xyzzy</a> [<a href=3D"mailto:quaresma.jose@gmail.com" target=3D"_blank=
">quaresma.jose@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr">Best regards,<div><br>Jos=C3=A9 Quaresma</div></=
div></div>

--00000000000074017806438c8c70--

