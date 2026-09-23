Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D63CC98302
	for <webhook@archiver.kernel.org>; Wed, 23 Sep 2026 14:47:35 +0000 (UTC)
Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.137.1790174854130415396
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Sep 2026 07:47:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Ocu1Ua4Y;
 spf=pass (domain: gmail.com, ip: 74.125.224.140, mailfrom: alex.kanavin@gmail.com)
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66fb93aee5eso1089211d50.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Sep 2026 07:47:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790174853; cv=none;
        d=google.com; s=arc-20260327;
        b=GJi1/9WFgPw/Ss/O+ZKXHmp3vFmDrbT2WPv98aMr79kS70RsjQIOgTO5sXRuVLWs+J
         xF1GlEAdhQopcnankTm/DxRORoH2y4zPq5e0GkfCYnmgWSmcfDCS0rEYqHNk/m5+iBDL
         +m3CJWdk0HGiOkgioPQBeWbPqr0lrkMKWz+fK+NH2Mv91TKF9f1pFcFM1K+tktYxp9q8
         AqsRhODXrbop270xF+kK//y4eIT8E2ZHQ7wvnauymF+JbvXxNLJ615VGv+3ouLnzZ4mP
         Bt5HXPg8Cyg/Q7rZfh3YVfwZ35hbXfrtHG60oHZ8B7AvTNdMMYYJNAV2UyjI2umyVaW3
         QxCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JFcRXyhN9D8kftvirrbCwrboBRRPggbdQeA+AmNR6oU=;
        fh=28JQhdK5h5mLF5DLv2fLR8YFHEF0yTvH5opUNnJ6Zzo=;
        b=fPH+4Ogge871OVYM8/TxYuXT74yE9mXnN3VFONXozVYaj7Gn7NhKO6fgvMikSV5FoW
         ZbW1AOmSwoIrJqRF5bRH8ImXS2GN/60bOMwlwQrfNGN9+I94vhTUPISbzG8ptWF1d74y
         qDY12/WKe8R7xhbYDNLf1ju+RAR0E8mEsVEeXXAlA8XDhlaheNhba21dL2QFBfDzysYg
         cAGmAb/imsikwLOR0R3723DVj+TG3bDbRTwsfVR9Y5ZFSdoHtyrREgMq8gTJX8O8fiDr
         2pw/t+ZbzbpYrEkN4dlFO6gX20ep/uFll9QL5HLW+P0+QCD/P9QLyWEKqrFNzXNQGKjj
         fqlQ==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790174853; x=1790779653; darn=lists.yoctoproject.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JFcRXyhN9D8kftvirrbCwrboBRRPggbdQeA+AmNR6oU=;
        b=Ocu1Ua4YyBigp/IkVf3f6R0o5FA8CweIwKwA7U1hoxffaeGG1ODu7njJzSBmpHysnF
         f0fO2ZHAC5EyyIVbIy+5vy0GWpWRsTjgx/QJOTCmsA7ESsoDgLky81Iu6S9ljySkyYrG
         3P5J/RjKy5/luzphUjQC2w3XBzHYgCAKH55ID+haPzh8rWBNAiiKKETIQCOQ26cDwv3o
         GiHRp2xkLk2K5TZB5rnnbGIvfSiHLC6kUqwVMxGddhFkZi9gBsNBTDgM93PED//tLTNj
         RJA0EZVkctkpXNTtK355q455yLE/P+IyyRtQd25eLdNWa0NAP3U73GighD40MH9HV7kS
         n1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790174853; x=1790779653;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JFcRXyhN9D8kftvirrbCwrboBRRPggbdQeA+AmNR6oU=;
        b=Z9fKMUFb2CGs24V7eW8Lgznyctkf/ZvUi+EoeO5FtMXozf0NpT4EK2NCXaTmCy9Xyd
         kLBvcVZAvWssM9Hz/EmJDUtz5KhGpCx7K1sBZ1V95bNIa+e5qngr5ATNU61OVSdtTZ5B
         6sg7hghqvXI8x6E1mCm+JDL21C1vaTDrrqv0l1w/VdbRMKru46WGFM0pbcc3OyOd9lRG
         n+tPQ+FSmCnj7iIzvG4mTDPlUg6l1rJba4NTiYkK8fst+Bv6dP/Lt3UsDQLAKTB/GEch
         8gA1p97IX1MEFGx0r0w9rWP0H3yMq0KyBPYo5MobG8VxWIGdg3gF4faFngXIuOQo95oj
         /7Iw==
X-Gm-Message-State: AFuF++n943iFxQmFnCXwMx0TmNckSd0VeVhftP1Aam77yenz8FN7atha
	DmMfkhjqfUewEadBKxhEKOF2iH59EfONfYfLK0PdS47H2wRP68LPjaqAZxb+tWmIqeP3AyMoB8Z
	mx0M+K5gyO1MN1clX5HWCcwd9DAMhe3s=
X-Gm-Gg: AYBFou1Tuc4Dr38jpgYkw1iXlO0LMElfDtcTyi2zkgWbbi7kEBxC4xoPWtIKME8hQV8
	3xma5ua5Oj0nItzTg+eaWXIch6MfFV5mC6pqm4jZeCpDgm1sdTl6XXtOzXJR0+qom095BJTqBvY
	f1pCLCkxr/eAlFDv/4+/k29dhapZcB3/IfL9zPVNZCb0NMPArkAERZrG3JLoBUB+CGJU7dyMIru
	cl4hODnUi3JSCCagZh8JNwzvmnivECsxvV58JyTUdD1kP49ghQAess7R6t8iv2YVw7KoGP8m0eZ
	/zWhMJ339/HMDvyUjWApCEvTYOByW30LBh6kdw9HLReWzSGGDfDEhjMhAogcZjptuninMFDA7T4
	UELFPb7V1eRaWdQ==
X-Received: by 2002:a05:690e:11c7:b0:66f:c1be:317c with SMTP id
 956f58d0204a3-672d59bcff2mr1379567d50.83.1790174853070; Wed, 23 Sep 2026
 07:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260923085528.88881-1-daniel.turull@ericsson.com> <20260923085528.88881-2-daniel.turull@ericsson.com>
In-Reply-To: <20260923085528.88881-2-daniel.turull@ericsson.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 23 Sep 2026 16:47:21 +0200
X-Gm-Features: AclHuK9rdET7L8GPBou7JcvEvDTRJtilZA7fRgMJ3UWa4aJprq2Otmo829t2aEQ
Message-ID: <CANNYZj9+ZxcggVEqfjHM_+O5kz-qH9UQiwx1L+E2x33xpZuhWg@mail.gmail.com>
Subject: Re: [auh][PATCH v2 2/2] upgrade-helper: deduplicate identical
 versions in email subject
To: daniel.turull@ericsson.com
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="00000000000034050a065c279000"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Sep 2026 14:47:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4941

--00000000000034050a065c279000
Content-Type: text/plain; charset="UTF-8"

Thanks, both patches applied and pushed.

Alex

On Wed, 23 Sept 2026 at 10:55, <daniel.turull@ericsson.com> wrote:

> From: Daniel Turull <daniel.turull@ericsson.com>
>
> Recipe groups where every recipe upgrades to the same version (e.g.
> systemd, systemd-tools-native, systemd-boot, systemd-boot-native all
> to 262) produced a repeated version list in the notification email
> subject and body, e.g. 'upgrading to 262,262,262,262'. Deduplicate
> identical versions, same as _make_commit_msg() already does for the
> commit message subject.
>
> Assisted-by: kiro:claude-sonnet-5
> Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
> ---
>  upgrade-helper.py | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/upgrade-helper.py b/upgrade-helper.py
> index 86e1a93..56b1f02 100755
> --- a/upgrade-helper.py
> +++ b/upgrade-helper.py
> @@ -353,7 +353,9 @@ class Updater(object):
>              else:
>                  cc_addr = settings["cc_recipients"].split()
>
> -        newversions = ",".join([pkg_ctx['NPV'] if not
> pkg_ctx['NPV'].endswith("new-commits-available") else pkg_ctx['NSRCREV']
> for pkg_ctx in g['pkgs']])
> +        newversions = ",".join(dict.fromkeys(
> +                pkg_ctx['NPV'] if not
> pkg_ctx['NPV'].endswith("new-commits-available") else pkg_ctx['NSRCREV']
> +                for pkg_ctx in g['pkgs']))
>          pns = ",".join([pkg_ctx['PN'] for pkg_ctx in g['pkgs']])
>          subject = "[AUH] " + pns + ": upgrading to " + newversions
>          if not g['error']:
>

--00000000000034050a065c279000
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thanks, both patches applied and pushed.</div><div><b=
r></div><div>Alex</div></div><br><div class=3D"gmail_quote gmail_quote_cont=
ainer"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, 23 Sept 2026 at 10:55,=
 &lt;<a href=3D"mailto:daniel.turull@ericsson.com">daniel.turull@ericsson.c=
om</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">From: Daniel Turull &lt;<a href=3D"mailto:daniel.turull@ericsson.com" tar=
get=3D"_blank">daniel.turull@ericsson.com</a>&gt;<br>
<br>
Recipe groups where every recipe upgrades to the same version (e.g.<br>
systemd, systemd-tools-native, systemd-boot, systemd-boot-native all<br>
to 262) produced a repeated version list in the notification email<br>
subject and body, e.g. &#39;upgrading to 262,262,262,262&#39;. Deduplicate<=
br>
identical versions, same as _make_commit_msg() already does for the<br>
commit message subject.<br>
<br>
Assisted-by: kiro:claude-sonnet-5<br>
Signed-off-by: Daniel Turull &lt;<a href=3D"mailto:daniel.turull@ericsson.c=
om" target=3D"_blank">daniel.turull@ericsson.com</a>&gt;<br>
---<br>
=C2=A0upgrade-helper.py | 4 +++-<br>
=C2=A01 file changed, 3 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/upgrade-helper.py b/upgrade-helper.py<br>
index 86e1a93..56b1f02 100755<br>
--- a/upgrade-helper.py<br>
+++ b/upgrade-helper.py<br>
@@ -353,7 +353,9 @@ class Updater(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cc_addr =3D s=
ettings[&quot;cc_recipients&quot;].split()<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 newversions =3D &quot;,&quot;.join([pkg_ctx[&#=
39;NPV&#39;] if not pkg_ctx[&#39;NPV&#39;].endswith(&quot;new-commits-avail=
able&quot;) else pkg_ctx[&#39;NSRCREV&#39;] for pkg_ctx in g[&#39;pkgs&#39;=
]])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 newversions =3D &quot;,&quot;.join(dict.fromke=
ys(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pkg_ctx[&#39;NPV&#=
39;] if not pkg_ctx[&#39;NPV&#39;].endswith(&quot;new-commits-available&quo=
t;) else pkg_ctx[&#39;NSRCREV&#39;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for pkg_ctx in g[&=
#39;pkgs&#39;]))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pns =3D &quot;,&quot;.join([pkg_ctx[&#39;=
PN&#39;] for pkg_ctx in g[&#39;pkgs&#39;]])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0subject =3D &quot;[AUH] &quot; + pns + &q=
uot;: upgrading to &quot; + newversions<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not g[&#39;error&#39;]:<br>
</blockquote></div>

--00000000000034050a065c279000--

