Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38125E909D3
	for <webhook@archiver.kernel.org>; Tue, 17 Feb 2026 16:38:48 +0000 (UTC)
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16314.1771346317967892282
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 17 Feb 2026 08:38:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ITFDOmyd;
 spf=pass (domain: gmail.com, ip: 74.125.224.41, mailfrom: raj.khem@gmail.com)
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64ad019bbd4so4288431d50.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 17 Feb 2026 08:38:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771346317; cv=none;
        d=google.com; s=arc-20240605;
        b=cYwiis+09ntML3Cs3EJ22RiveFo8rMX5nIN5BcQ5c23LOUl17TFtMrvLp4zuyx9vXx
         I/OfaoDuO+eLw7JHix0lZRBA4/lJUdRcbX9/n52GAQuiMr3yTQp2y1Ew+qKD7Sj+E7eH
         14xobyx0FMNzzuFTO92yyk4v2v2l+2aBhrYO7XesGclzegxakOq/IipTsizYkRmWCX82
         hDZOP4lAgeAI08XsdbFH0BqPgFzAtNR+fdCNT2rO7bG5LNvLC2f2VsDG1y+b6yZqoZV3
         zMtEhwFvMgbLBt0NOfAojXGX9AAcvHH3kZVYVnpl0l85rAOqsGtkgoLt6gbtb9lrKMt+
         t5dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=W2RqGnqUyPlkDZoh1jDuBKVOoewOq3gBo7vKgW0jneo=;
        fh=iQm91xFQUBbDJgUsk3JL+epfGsh5C+lNegyohSZUpgk=;
        b=hQRoRmhABsg+0KZJrujuyKD7XbB6qgYIbEn/oZxKXNY/Uydx1RaEV7rW5IHqqDW6M7
         V1tIum/vHQSI2k7ld0xpu27Q9OI2AU5D9GqYIuBJr962+JLWsCIrO1j6XwHWXUDviO94
         hpIEJdWlXhoTZZFUadTuyohIjyGCzLnXXvihJ4I9jTKXdKmqjTknBaCAY4Mi6/uP2f5F
         d+GK3hQo6WrzPm9R2b/CuHcgSiEEO2KyR0i69wysv/8om84j2RFXD90geRxET/7Dm2z9
         4SIOeNuAZ4b/QVj1SeGkB1mzrNt50nh0ZCg1xLOGkXV/3DIjlIIFYmUNN8A9OSB4vYmH
         6jWg==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771346317; x=1771951117; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W2RqGnqUyPlkDZoh1jDuBKVOoewOq3gBo7vKgW0jneo=;
        b=ITFDOmyd9DcRST+RrgOkPhWFzQyFwywJ/SB+Hd0KZzaZAS9cQkYXwxvMg7Ks5ZgqHH
         ePkzxS5cqCLV+mwqEPyUz3JKQNSFcrOikLjW1q2fwmIFKAHOrVtCZUWqODsVlAFZPl4i
         qQ8rpFbQlScmYfiKSeDKtT2Cm2PbLgpaR1LlnnmJQIujA+jxtirblCThYb5GkONfhhVJ
         WkXs7KVKSTtWl24nn/k9mY2zaF3wlUjX/0/BLfFDu8eXuqEeRaQ8FardMONBLqcBCm2i
         ABfNwPEZXzT6HVSKQb6sAatwuiwTgxQuBQCkhv0rvatuUnfhbgXyFC62AQeuVVd0JpBv
         sLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771346317; x=1771951117;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2RqGnqUyPlkDZoh1jDuBKVOoewOq3gBo7vKgW0jneo=;
        b=LC4G0RAo1kPySU7+j25vZWVyLDb3AsR6BAXmgySV394srBHVIEPDVxnnc1XQu/wLmc
         Xrv13NR/7/jL38oJXnjgt/oSbmGRKYotGaPA49OxJfrImA6pEClrlrAJAFvIony38VJ6
         OPV1utZJpBFDDFSOR0gBk7rHYJUOZPxdREfRfkCgNWYAR8exT6+V3rSJDlMzL1sMXiOM
         7s+QIQOVuICYQJbGIVfWZ0J2IudZ+Xt2msUapYxGHQmpAiyAgxHdOH55qA87x+GQ8PwK
         2FohM2zLG0t++Ctq/lAeQ+t56m/5OtPreDMiR7oUwY3v33/dmJG3y+0aB31QQRG99216
         F9zA==
X-Gm-Message-State: AOJu0Yzqyrof5TMNMZmORBbM+jMT7CcWpQIAjUmPWXaPKbNlmSvGnlPa
	l3aFnP8bnGExVP8sNs0U5E1OC0MfJ156MKoFHApEHPxcCOwsJx6t9sdjMoJmdHwVexiR0yH3DS0
	DnBnvjq9/VUU3hpTdVfX+Cs9KrjRRseDXPua5HM0=
X-Gm-Gg: AZuq6aKiEy7I38xlpe8D+Bgl/AXpLWEYBGa1+KhzLj5Q+YcfjVHQHzlleO832DkNQO7
	/4iHrKCA6YN04Sm4YGkIXklUoLQSfPlqKer7JjfMn7DYaxuVebmi57zVjq/40j87a5EdWYRKNNM
	DtW7HmYxgOFISrzVv3PVa2oRKAZ/PPmZV5SYVCsYN8H3m8XKSoOWoMT5/GaDBljyT08QjxHdJ3N
	kx/84Ok0wQMPt6chCIlCZXhq/fNckLDsSAZzes2jnui5+oGHvv+wmiPl4qRf2l/TnhFmLdjspa3
	Ke1X1NfDIcleayqaSA9/G30SBulv4gYK1GjVU8vOAreAiOdMil0QaH1aL7CSY2XQw59qAll1qQA
	qCFiTt6R1RW3+DSFVZBIR/ccAhzna63hHWKop
X-Received: by 2002:a05:690e:4196:b0:649:ef87:5bc8 with SMTP id
 956f58d0204a3-64c21a442d9mr7872584d50.7.1771346316621; Tue, 17 Feb 2026
 08:38:36 -0800 (PST)
MIME-Version: 1.0
References: <20260217154814.483670-1-yoann.congal@smile.fr>
In-Reply-To: <20260217154814.483670-1-yoann.congal@smile.fr>
From: Khem Raj <raj.khem@gmail.com>
Date: Tue, 17 Feb 2026 08:38:09 -0800
X-Gm-Features: AZwV_QjtN78p1ORH_mAviCYIM7RZkn2nU8sSq52U0Ek5TEnKwuP5guQHLvtHn_A
Message-ID: <CAMKF1soOjJDt_UaK4e2wjn6anusCAaa0NnNXzEpkBESnsDVEuw@mail.gmail.com>
Subject: Re: [yocto-patches] [pseudo] [PATCH] ports/linux: define __NR_openat2
 if missing
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Content-Type: multipart/alternative; boundary="000000000000f9ff89064b07b3d8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 17 Feb 2026 16:38:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3249

--000000000000f9ff89064b07b3d8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 7:48=E2=80=AFAM Yoann Congal via lists.yoctoproject=
.org
<yoann.congal=3Dsmile.fr@lists.yoctoproject.org> wrote:

> From: Yoann Congal <yoann.congal@smile.fr>
>
> On kernel <5.6, __NR_openat2 is not defined. To support build on these
> older kernel, define __NR_openat2 at the value it has on every kernel
> since 5.6: 437 [0].
>
> [0]:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Dfddb5d430ad9fa91b49b1d34d0202ffe2fa0e179
>
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> ---
>  ports/linux/portdefs.h | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/ports/linux/portdefs.h b/ports/linux/portdefs.h
> index a8b2be6..32b95ba 100644
> --- a/ports/linux/portdefs.h
> +++ b/ports/linux/portdefs.h
> @@ -54,7 +54,15 @@ GLIBC_COMPAT_SYMBOL(memcpy,2.0);
>  #endif
>  #endif
>
> -/* Debian 11 and Opensuse 15.5 need this */
> +/* Ubuntu 20.04, Debian 11 and Opensuse 15.5 need this */
>  #ifndef SYS_openat2
> +
> +/* On kernel <5.6, __NR_openat2 is not defined. Import the definition
> from
> + *
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Dfddb5d430ad9fa91b49b1d34d0202ffe2fa0e179
> + */
> +#ifndef __NR_openat2
> +#define __NR_openat2 437
> +#endif
>

it will fix compile time problems but I wonder if it will run okay on
kernels < 5.6 ?


> +
>  #define SYS_openat2 __NR_openat2
>  #endif
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3248):
> https://lists.yoctoproject.org/g/yocto-patches/message/3248
> Mute This Topic: https://lists.yoctoproject.org/mt/117858536/1997914
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://lists.yoctoproject.org/g/yocto-patches/leave/13340786/1997914/645=
821814/xyzzy
> [raj.khem@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--000000000000f9ff89064b07b3d8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 17,=
 2026 at 7:48=E2=80=AFAM Yoann Congal via <a href=3D"http://lists.yoctoproj=
ect.org">lists.yoctoproject.org</a> &lt;yoann.congal=3D<a href=3D"mailto:sm=
ile.fr@lists.yoctoproject.org">smile.fr@lists.yoctoproject.org</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: Yoann C=
ongal &lt;<a href=3D"mailto:yoann.congal@smile.fr" target=3D"_blank">yoann.=
congal@smile.fr</a>&gt;<br>
<br>
On kernel &lt;5.6, __NR_openat2 is not defined. To support build on these<b=
r>
older kernel, define __NR_openat2 at the value it has on every kernel<br>
since 5.6: 437 [0].<br>
<br>
[0]: <a href=3D"https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git/commit/?id=3Dfddb5d430ad9fa91b49b1d34d0202ffe2fa0e179" rel=3D"noref=
errer" target=3D"_blank">https://git.kernel.org/pub/scm/linux/kernel/git/to=
rvalds/linux.git/commit/?id=3Dfddb5d430ad9fa91b49b1d34d0202ffe2fa0e179</a><=
br>
<br>
Signed-off-by: Yoann Congal &lt;<a href=3D"mailto:yoann.congal@smile.fr" ta=
rget=3D"_blank">yoann.congal@smile.fr</a>&gt;<br>
---<br>
=C2=A0ports/linux/portdefs.h | 10 +++++++++-<br>
=C2=A01 file changed, 9 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/ports/linux/portdefs.h b/ports/linux/portdefs.h<br>
index a8b2be6..32b95ba 100644<br>
--- a/ports/linux/portdefs.h<br>
+++ b/ports/linux/portdefs.h<br>
@@ -54,7 +54,15 @@ GLIBC_COMPAT_SYMBOL(memcpy,2.0);<br>
=C2=A0#endif<br>
=C2=A0#endif<br>
<br>
-/* Debian 11 and Opensuse 15.5 need this */<br>
+/* Ubuntu 20.04, Debian 11 and Opensuse 15.5 need this */<br>
=C2=A0#ifndef SYS_openat2<br>
+<br>
+/* On kernel &lt;5.6, __NR_openat2 is not defined. Import the definition f=
rom <br>
+ * <a href=3D"https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/lin=
ux.git/commit/?id=3Dfddb5d430ad9fa91b49b1d34d0202ffe2fa0e179" rel=3D"norefe=
rrer" target=3D"_blank">https://git.kernel.org/pub/scm/linux/kernel/git/tor=
valds/linux.git/commit/?id=3Dfddb5d430ad9fa91b49b1d34d0202ffe2fa0e179</a><b=
r>
+ */<br>
+#ifndef __NR_openat2<br>
+#define __NR_openat2 437<br>
+#endif<br></blockquote><div><br></div><div>it will fix compile time proble=
ms but I wonder if it will run okay on kernels &lt; 5.6 ?</div><div>=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
=C2=A0#define SYS_openat2 __NR_openat2<br>
=C2=A0#endif<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#3248): <a href=3D"https://lists.yoctoproject.org/g/yoct=
o-patches/message/3248" rel=3D"noreferrer" target=3D"_blank">https://lists.=
yoctoproject.org/g/yocto-patches/message/3248</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/117858536/199=
7914" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/m=
t/117858536/1997914</a><br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leav=
e/13340786/1997914/645821814/xyzzy" rel=3D"noreferrer" target=3D"_blank">ht=
tps://lists.yoctoproject.org/g/yocto-patches/leave/13340786/1997914/6458218=
14/xyzzy</a> [<a href=3D"mailto:raj.khem@gmail.com" target=3D"_blank">raj.k=
hem@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
</blockquote></div></div>

--000000000000f9ff89064b07b3d8--

