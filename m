Return-Path: <vanusuri@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9956ECCFA05
	for <webhook@archiver.kernel.org>; Fri,  7 Nov 2025 05:33:07 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5169.1762493584641007045
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 06 Nov 2025 21:33:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=Itof7IoK;
 spf=pass (domain: mvista.com, ip: 209.85.208.43, mailfrom: vanusuri@mvista.com)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6409e985505so573137a12.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 06 Nov 2025 21:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1762493582; x=1763098382; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UAcXbPflcyoNzWhXDJeHPM6B7Aqu4kw9fZq1DjaXKIE=;
        b=Itof7IoKcYE8+9wbCKt1JgFENYRCTjNix2L2R0W2SoOZHbaJo+7cG5X5WTheYndhvG
         qumjVv6HrsYQ2LC/LQI9xuXrnshxCvOQXROM0beJ95mSWMLlJbRLYZj4thlZLWK3qAzI
         kZrKuciFmOZGKdR1ha3B8qb4gF3C1NbMQGeXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762493582; x=1763098382;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAcXbPflcyoNzWhXDJeHPM6B7Aqu4kw9fZq1DjaXKIE=;
        b=IRXxcfztPe9LJtiKoYNXQ1cI6RF0Qg0F3gOpqcjzOzaOleI6MCUfb4s/rlAjLL4KUa
         Aeb+EKK9MPRM5jZKQy2UTpF31tuLnWmifJGw2Ux/3eD+2gzM7EPhzPxuin2xPJWcVpXI
         JfE8B3fvvNSF6Oxm8OtFjxEay0vm8G2l1CwTFaU5mzPzcGuzjg7pr7qcsft9DgXRY7B2
         YE1B14xTUb/skdbUeOYSsQJW6SgVJxHBRBslpmHxdbpgP+UEazDV+ciAD3IhrfBT0Nus
         LFm1NQ15jvQVyzp0Ahp3csY8BMK5gSbcoRBPrD//IMnavMYYG5dfXDkwLE/XBWbQOwIB
         rvAw==
X-Gm-Message-State: AOJu0YwsrQr2n3+ZsgVBlLA4P48sghLFYg/G5uIiVEdikgtfhbHkVLa9
	j7iZYBqtQ2JcxXgRn/VnkY7Vz4xrV3rFaPONTPKKcHidmoI5ZRE8+H8NXddNt61ctfAxfbBcLqm
	KaVzxTejYNwDWXpJKzLw7NvgTpqxxAM7cGqr4CEbHQOf+VUQyaLso
X-Gm-Gg: ASbGncsc599mhs2E6csunuYknOIVdc5FE3uVDEIAbarshxbdZeIbx90oSmtxpndvK5S
	6uAqRlRRD6PAraSHOBRBKWqNQnPLe6qvbHJ8FyPbfdQA8+Tk0AuA16CNJzsMAaS7Zp6oPqYGemp
	hcjQTt7Ewnp5oXTErbJRS6Gw28rdJYVuCF2tMLK+HiemsUSI/dzscBkx2zym9HKqLUlbL4GhBuQ
	pN3Tkg1/FAPvzh+ogB8d5s7k2sIYoZ5mh35nQJP4Raz6UG4UjEJQC4E7LrZ9NeyMVjRZCCZYUL0
	m0auLqsJQC90kXEeVso=
X-Google-Smtp-Source: AGHT+IE+5/JM0tvaS0+bgESuy2SnE8CyR+uNRq7ufAuc/s2pJpoycqqseNJULpoiNObFy562y8a4lVbXSORMI0F8WSI=
X-Received: by 2002:a17:907:7f86:b0:b3f:ccac:af47 with SMTP id
 a640c23a62f3a-b72c0cebee0mr183613466b.31.1762493582310; Thu, 06 Nov 2025
 21:33:02 -0800 (PST)
MIME-Version: 1.0
References: <20250909065853.1959573-1-yi.zhao@windriver.com>
In-Reply-To: <20250909065853.1959573-1-yi.zhao@windriver.com>
From: Vijay Anusuri <vanusuri@mvista.com>
Date: Fri, 7 Nov 2025 11:02:50 +0530
X-Gm-Features: AWmQ_bkTI9AHtJwSmabb6S7X9kLEwP2VpLEN6pFRQXRNiJPY-WkoqocePH_GjJQ
Message-ID: <CANQUz1_YMw4=cg=6RMqJfPSou-ns5dPVO6uXNqeJNz5Be9ycaQ@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-security][scarthgap][PATCH] fail2ban:
 update to 1.1.0+
To: yocto-patches@lists.yoctoproject.org
Cc: scott.murray@konsulko.com, rybczynska@gmail.com
Content-Type: multipart/alternative; boundary="000000000000e4931f0642fa8320"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 07 Nov 2025 05:33:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2428

--000000000000e4931f0642fa8320
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Team,

Any update on this ?

Thanks & Regards,
Vijay

On Tue, Sep 9, 2025 at 12:29=E2=80=AFPM Yi Zhao via lists.yoctoproject.org =
<yi.zhao=3D
eng.windriver.com@lists.yoctoproject.org> wrote:

> From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
>
> Current 1.0.2 version does not work with scarthgap or later releases,
> as the asynchat module has been removed (as scheduled) from python's
> stdlib as of v3.12.
>
> fail2ban 1.1.0 also does not work out-of-the-box, as the distutils
> module which the pyinotify and systemd backends depend has also been
> removed.
>
> So update the recipe to point at commit ac62658c10f4, which fixes
> those two backends to no longer depend on distutils.
>
> Upstream's out-of-the-box ban action now uses the 'nft'
> command. People can still override and customize that in
> jail.conf/jail.local, but to make the recipe useful without
> customizing things back to use iptables, change the dependency
> iptables->nftables.
>
> Since 1.1.0, fail2ban has been python3-only, so the recipe becomes
> somewhat simpler since the whole do_compile preparation step can be
> removed.
>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Signed-off-by: Armin Kuster <akuster808@gmail.com>
> Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
> ---
>  ...fail2ban_1.0.2.bb =3D> python3-fail2ban_git.bb} | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>  rename dynamic-layers/meta-python/recipes-security/fail2ban/{
> python3-fail2ban_1.0.2.bb =3D> python3-fail2ban_git.bb} (89%)
>
> diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/
> python3-fail2ban_1.0.2.bb
> b/dynamic-layers/meta-python/recipes-security/fail2ban/
> python3-fail2ban_git.bb
> similarity index 89%
> rename from dynamic-layers/meta-python/recipes-security/fail2ban/
> python3-fail2ban_1.0.2.bb
> rename to dynamic-layers/meta-python/recipes-security/fail2ban/
> python3-fail2ban_git.bb
> index bf5f87d..1d0fb62 100644
> --- a/dynamic-layers/meta-python/recipes-security/fail2ban/
> python3-fail2ban_1.0.2.bb
> +++ b/dynamic-layers/meta-python/recipes-security/fail2ban/
> python3-fail2ban_git.bb
> @@ -11,12 +11,14 @@ LIC_FILES_CHKSUM =3D
> "file://COPYING;md5=3Decabc31e90311da843753ba772885d9f"
>
>  DEPENDS =3D "python3-native"
>
> -SRCREV =3D "e1d3006b0330e9777705a7baafe3989d442ed120"
> +SRCREV =3D "ac62658c10f492911f8a0037a0bcf97c8521cd78"
>  SRC_URI =3D "git://
> github.com/fail2ban/fail2ban.git;branch=3Dmaster;protocol=3Dhttps \
>             file://initd \
>             file://run-ptest \
>             "
>
> +PV =3D "1.1.0+git"
> +
>  UPSTREAM_CHECK_GITTAGREGEX =3D "(?P<pver>\d+(\.\d+)+)"
>
>  inherit update-rc.d ptest setuptools3_legacy
> @@ -26,16 +28,6 @@ SYSTEMD_SERVICE:${PN} =3D "fail2ban.service"
>
>  S =3D "${WORKDIR}/git"
>
> -do_compile () {
> -    cd ${S}
> -
> -    #remove symlink to python3
> -    # otherwise 2to3 is run against it
> -    rm -f bin/fail2ban-python
> -
> -    ./fail2ban-2to3
> -}
> -
>  do_install:append () {
>      rm  -f ${D}/${bindir}/fail2ban-python
>      install -d ${D}/${sysconfdir}/fail2ban
> @@ -66,7 +58,7 @@ INITSCRIPT_PARAMS =3D "defaults 25"
>
>  INSANE_SKIP:${PN}:append =3D "already-stripped"
>
> -RDEPENDS:${PN} =3D "${VIRTUAL-RUNTIME_base-utils-syslog} iptables
> python3-core python3-pyinotify"
> +RDEPENDS:${PN} =3D "${VIRTUAL-RUNTIME_base-utils-syslog} nftables
> python3-core python3-pyinotify"
>  RDEPENDS:${PN} +=3D "python3-sqlite3"
>  RDEPENDS:${PN} +=3D " python3-logging python3-fcntl python3-json"
>  RDEPENDS:${PN}-ptest =3D "python3-core python3-io python3-modules
> python3-fail2ban"
> --
> 2.34.1
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#2148):
> https://lists.yoctoproject.org/g/yocto-patches/message/2148
> Mute This Topic: https://lists.yoctoproject.org/mt/115146393/7301997
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://lists.yoctoproject.org/g/yocto-patches/leave/13419208/7301997/133=
5553898/xyzzy
> [vanusuri@mvista.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--000000000000e4931f0642fa8320
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hi Team,<br><br></div>Any update on this ?<=
br><br></div>Thanks &amp; Regards,<br></div>Vijay</div><br><div class=3D"gm=
ail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On T=
ue, Sep 9, 2025 at 12:29=E2=80=AFPM Yi Zhao via <a href=3D"http://lists.yoc=
toproject.org">lists.yoctoproject.org</a> &lt;yi.zhao=3D<a href=3D"mailto:e=
ng.windriver.com@lists.yoctoproject.org">eng.windriver.com@lists.yoctoproje=
ct.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">From: Rasmus Villemoes &lt;<a href=3D"mailto:rasmus.villemoes@prevas.=
dk" target=3D"_blank">rasmus.villemoes@prevas.dk</a>&gt;<br>
<br>
Current 1.0.2 version does not work with scarthgap or later releases,<br>
as the asynchat module has been removed (as scheduled) from python&#39;s<br=
>
stdlib as of v3.12.<br>
<br>
fail2ban 1.1.0 also does not work out-of-the-box, as the distutils<br>
module which the pyinotify and systemd backends depend has also been<br>
removed.<br>
<br>
So update the recipe to point at commit ac62658c10f4, which fixes<br>
those two backends to no longer depend on distutils.<br>
<br>
Upstream&#39;s out-of-the-box ban action now uses the &#39;nft&#39;<br>
command. People can still override and customize that in<br>
jail.conf/jail.local, but to make the recipe useful without<br>
customizing things back to use iptables, change the dependency<br>
iptables-&gt;nftables.<br>
<br>
Since 1.1.0, fail2ban has been python3-only, so the recipe becomes<br>
somewhat simpler since the whole do_compile preparation step can be<br>
removed.<br>
<br>
Signed-off-by: Rasmus Villemoes &lt;<a href=3D"mailto:rasmus.villemoes@prev=
as.dk" target=3D"_blank">rasmus.villemoes@prevas.dk</a>&gt;<br>
Signed-off-by: Armin Kuster &lt;<a href=3D"mailto:akuster808@gmail.com" tar=
get=3D"_blank">akuster808@gmail.com</a>&gt;<br>
Signed-off-by: Yi Zhao &lt;<a href=3D"mailto:yi.zhao@windriver.com" target=
=3D"_blank">yi.zhao@windriver.com</a>&gt;<br>
---<br>
=C2=A0...<a href=3D"http://fail2ban_1.0.2.bb" rel=3D"noreferrer" target=3D"=
_blank">fail2ban_1.0.2.bb</a> =3D&gt; <a href=3D"http://python3-fail2ban_gi=
t.bb" rel=3D"noreferrer" target=3D"_blank">python3-fail2ban_git.bb</a>} | 1=
6 ++++------------<br>
=C2=A01 file changed, 4 insertions(+), 12 deletions(-)<br>
=C2=A0rename dynamic-layers/meta-python/recipes-security/fail2ban/{<a href=
=3D"http://python3-fail2ban_1.0.2.bb" rel=3D"noreferrer" target=3D"_blank">=
python3-fail2ban_1.0.2.bb</a> =3D&gt; <a href=3D"http://python3-fail2ban_gi=
t.bb" rel=3D"noreferrer" target=3D"_blank">python3-fail2ban_git.bb</a>} (89=
%)<br>
<br>
diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/<a href=
=3D"http://python3-fail2ban_1.0.2.bb" rel=3D"noreferrer" target=3D"_blank">=
python3-fail2ban_1.0.2.bb</a> b/dynamic-layers/meta-python/recipes-security=
/fail2ban/<a href=3D"http://python3-fail2ban_git.bb" rel=3D"noreferrer" tar=
get=3D"_blank">python3-fail2ban_git.bb</a><br>
similarity index 89%<br>
rename from dynamic-layers/meta-python/recipes-security/fail2ban/<a href=3D=
"http://python3-fail2ban_1.0.2.bb" rel=3D"noreferrer" target=3D"_blank">pyt=
hon3-fail2ban_1.0.2.bb</a><br>
rename to dynamic-layers/meta-python/recipes-security/fail2ban/<a href=3D"h=
ttp://python3-fail2ban_git.bb" rel=3D"noreferrer" target=3D"_blank">python3=
-fail2ban_git.bb</a><br>
index bf5f87d..1d0fb62 100644<br>
--- a/dynamic-layers/meta-python/recipes-security/fail2ban/<a href=3D"http:=
//python3-fail2ban_1.0.2.bb" rel=3D"noreferrer" target=3D"_blank">python3-f=
ail2ban_1.0.2.bb</a><br>
+++ b/dynamic-layers/meta-python/recipes-security/fail2ban/<a href=3D"http:=
//python3-fail2ban_git.bb" rel=3D"noreferrer" target=3D"_blank">python3-fai=
l2ban_git.bb</a><br>
@@ -11,12 +11,14 @@ LIC_FILES_CHKSUM =3D &quot;file://COPYING;md5=3Decabc31=
e90311da843753ba772885d9f&quot;<br>
<br>
=C2=A0DEPENDS =3D &quot;python3-native&quot;<br>
<br>
-SRCREV =3D &quot;e1d3006b0330e9777705a7baafe3989d442ed120&quot;<br>
+SRCREV =3D &quot;ac62658c10f492911f8a0037a0bcf97c8521cd78&quot;<br>
=C2=A0SRC_URI =3D &quot;git://<a href=3D"http://github.com/fail2ban/fail2ba=
n.git;branch=3Dmaster;protocol=3Dhttps" rel=3D"noreferrer" target=3D"_blank=
">github.com/fail2ban/fail2ban.git;branch=3Dmaster;protocol=3Dhttps</a> \<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 file://initd \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 file://run-ptest \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;<br>
<br>
+PV =3D &quot;1.1.0+git&quot;<br>
+<br>
=C2=A0UPSTREAM_CHECK_GITTAGREGEX =3D &quot;(?P&lt;pver&gt;\d+(\.\d+)+)&quot=
;<br>
<br>
=C2=A0inherit update-rc.d ptest setuptools3_legacy<br>
@@ -26,16 +28,6 @@ SYSTEMD_SERVICE:${PN} =3D &quot;fail2ban.service&quot;<b=
r>
<br>
=C2=A0S =3D &quot;${WORKDIR}/git&quot;<br>
<br>
-do_compile () {<br>
-=C2=A0 =C2=A0 cd ${S}<br>
-<br>
-=C2=A0 =C2=A0 #remove symlink to python3<br>
-=C2=A0 =C2=A0 # otherwise 2to3 is run against it<br>
-=C2=A0 =C2=A0 rm -f bin/fail2ban-python<br>
-<br>
-=C2=A0 =C2=A0 ./fail2ban-2to3<br>
-}<br>
-<br>
=C2=A0do_install:append () {<br>
=C2=A0 =C2=A0 =C2=A0rm=C2=A0 -f ${D}/${bindir}/fail2ban-python<br>
=C2=A0 =C2=A0 =C2=A0install -d ${D}/${sysconfdir}/fail2ban<br>
@@ -66,7 +58,7 @@ INITSCRIPT_PARAMS =3D &quot;defaults 25&quot;<br>
<br>
=C2=A0INSANE_SKIP:${PN}:append =3D &quot;already-stripped&quot;<br>
<br>
-RDEPENDS:${PN} =3D &quot;${VIRTUAL-RUNTIME_base-utils-syslog} iptables pyt=
hon3-core python3-pyinotify&quot;<br>
+RDEPENDS:${PN} =3D &quot;${VIRTUAL-RUNTIME_base-utils-syslog} nftables pyt=
hon3-core python3-pyinotify&quot;<br>
=C2=A0RDEPENDS:${PN} +=3D &quot;python3-sqlite3&quot;<br>
=C2=A0RDEPENDS:${PN} +=3D &quot; python3-logging python3-fcntl python3-json=
&quot;<br>
=C2=A0RDEPENDS:${PN}-ptest =3D &quot;python3-core python3-io python3-module=
s python3-fail2ban&quot;<br>
-- <br>
2.34.1<br>
<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#2148): <a href=3D"https://lists.yoctoproject.org/g/yoct=
o-patches/message/2148" rel=3D"noreferrer" target=3D"_blank">https://lists.=
yoctoproject.org/g/yocto-patches/message/2148</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/115146393/730=
1997" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/m=
t/115146393/7301997</a><br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leav=
e/13419208/7301997/1335553898/xyzzy" rel=3D"noreferrer" target=3D"_blank">h=
ttps://lists.yoctoproject.org/g/yocto-patches/leave/13419208/7301997/133555=
3898/xyzzy</a> [<a href=3D"mailto:vanusuri@mvista.com" target=3D"_blank">va=
nusuri@mvista.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
</blockquote></div>

--000000000000e4931f0642fa8320--

