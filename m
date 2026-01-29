Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E66D61031
	for <webhook@archiver.kernel.org>; Thu, 29 Jan 2026 17:07:41 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19887.1769706454071382166
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 29 Jan 2026 09:07:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=ABhukXaq;
 spf=pass (domain: smile.fr, ip: 209.85.221.48, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-432d2c7a8b9so1205235f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 29 Jan 2026 09:07:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769706452; cv=none;
        d=google.com; s=arc-20240605;
        b=NFG/00FN2tuCMdnb2HX22/+DwRMQt3/xWoRRc84ePrGKrbFfxFrpO6LOFP7zy67B7q
         u9Z3bGmqJLdC9rUhLpQoxP5B7HwJmi0e5DnyA+4w3huS76RjrvcN1tJNdzmu4Mzu7IjN
         Vw/drCRdzUtsW0GbEZX/2HjPZPcp6umuEOWhAL/uRM/DbLnRebw0LOKTpdjJO1xaY38m
         Efx0uIgEv4SP9OdbqOT3TZlaL5WcoEJxERSVwwxvmtL6stnk8VZYur/SINrLStaqUKUO
         kVL++9iHOyvqzl7twZ5d2cHJigmzR3C4HNyMWfpYfr4NvEuJkTC/GfWvqKQ5ve5O9G8X
         vZ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=pJ9UsGzDRMeRNVIbVJBkFyBCnqLtuRMk1VH5Jx5PEmI=;
        fh=moagCLbVVFQO5kw1aLdWVpJz+dpYgsdIWNCHzBu4K0w=;
        b=R+gajNWDD7gP/z8NkMdiETv7P7oYzX6Y+zZ/ivjUUrulY7R3OFjGugO+IcpgSeZmaq
         hL6HeK5AzDUZawJdHBS5ZungczivPwg5AeZYz4SowABvXgsz48gc1CpcWEz9lTPVRvI8
         Tl8mMpQDfqKuu4sOVdhsFmHoWyNvCJZXJv6wKRfmGxCi2mQFnyej/UQEhbSbiGLerLU4
         ZueKZTjeEQoo3z8zcZwm93eXonAlopDZAzoCeEV13JPot0rQtQf94FnFhFW0wVphB5PC
         4YgG15sFAgpINp4r6YTY0D6g7lyWYwhsyQEIasau2PhWpxiV9rjpzfduwO1ElRh3GvnN
         QjQg==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1769706452; x=1770311252; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pJ9UsGzDRMeRNVIbVJBkFyBCnqLtuRMk1VH5Jx5PEmI=;
        b=ABhukXaqcg+CkyVeXQfR+gVBz96T9S+QMxmMYlBJw/pYjxa4rQhmdKZ9W/OqEbWrQI
         NdpbXMt6Yq8g9Noc/ivEytV8o/+ilQnv60VKoe27yF75dHAflmk5G0NTq+uwBBYmyEsO
         naktAi48oXZiAMJjH/wJUeqMYjQbY8Y305hFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769706452; x=1770311252;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pJ9UsGzDRMeRNVIbVJBkFyBCnqLtuRMk1VH5Jx5PEmI=;
        b=qpivozmoZx+PD5R85up5Xuma3FsBQq/XyiGB9RvpNnW5rrsvAXIL4Q/G/8AQVCsVWE
         Crr3yi3YXV2N5sSJo4IE88uCox2hdmO80cOwDzvRWdlJxsCFEo8zJRaqAf+qOQcnDZC4
         FhlDeD6zu/1E+VMsSdISK+jLF3NKR6/g+DhNh1yEHoj1my6Tfrq1NP1X5cavy65b7xkS
         CBmgnt2qiE9MQtX+Pb6P4Wdf+vY/LQ26gZ54j/90Gb4LJbMKglY9yTVLoaWgv3Ps9hNC
         E+efPSk49RJqTrVlbAknlOLEkRZjNfxG1/uuj6B0M0C98ATdz/+H65mZcp2yWHs6u2b3
         S3iw==
X-Gm-Message-State: AOJu0YzLJbUCoRGorriPFQEW3Q3zelZ2BX56hRqN07RnRiR5nFsmoMSf
	stwJbubWv3dCboRi828InKq8yA7xHAqr5YFMhKUYkyVnnG8tgrsgXU1qQgto2hVv74d2mPACV9a
	enIuNRHvMb9l2N+R0/9i9l32kNOtfMmJRiRjFbN9iwCmUfhCgKD4/2G4=
X-Gm-Gg: AZuq6aIfqgY/nyIgRSKqFINP5gnXLBZNWqxCNeSKN26ADVz+Nj4rk0M96+kxTwDkLB+
	PmG5bMhPdqHPA7bUEBq633npEO5SvgYwIhzL3GmKWgw/lS/8Wfk+syzKH3nuwU9GorVnIL1boC5
	0F6D0ViXSBHNQt/NrQkJF2XjOu3Lo0xLq4xo3wUhGiwSFmj4ySaFXHpZpArGpim/6+VUTGccs80
	A0YxoBwv9yzJibdOieT6yPe9KIIdpOFmF5wYj47q8vZwMLUP1h2xLqnB2QhNM/33Iv4htwdvwMG
	2jkvnOJzbbtiajeIXFu+Ohe6GoLV
X-Received: by 2002:a5d:5f54:0:b0:432:dd71:8f2c with SMTP id
 ffacd0b85a97d-435f3a6aba7mr447834f8f.10.1769706451836; Thu, 29 Jan 2026
 09:07:31 -0800 (PST)
MIME-Version: 1.0
References: <20260129163632.1660116-1-ross.burton@arm.com>
In-Reply-To: <20260129163632.1660116-1-ross.burton@arm.com>
From: Yoann Congal <yoann.congal@smile.fr>
Date: Thu, 29 Jan 2026 18:07:04 +0100
X-Gm-Features: AZwV_Qhd_y4jLadrZ--SU_Ur515w4UIgVG8X16mziBCo6cLnexpg__C8amUF76U
Message-ID: <CAMSfU+59XSRn+Zg=CtW2L5LVrVZybNS1bQZaW0RJxcELYkX-_Q@mail.gmail.com>
Subject: Re: [yocto-patches] [PATCH yocto-autobuilder-helper kirkstone]
 scripts: rebase before pushing patch and CVE metrics
To: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="0000000000006b3d90064989e4ac"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 29 Jan 2026 17:07:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3144

--0000000000006b3d90064989e4ac
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 29 janv. 2026 =C3=A0 17:37, Ross Burton via lists.yoctoproject.org
<ross.burton=3Darm.com@lists.yoctoproject.org> a =C3=A9crit :

> There's a chance that run-cvecheck and run-patchmetrics fail to push
> because the remote repository has changed. Try to resolve this by pulling
> and rebasing immediately before the push, and failing if we can't rebase.
>
> Backport of 60e2011 from master.
>
> [ YOCTO #15686 ]
>
> Signed-off-by: Ross Burton <ross.burton@arm.com>
>

Thanks Ross,

I missed that when fixing
https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D16111 (on Dunfell)

There is a now obsolete comment to remove/rephrase:

# Do another pull to make sure we're as up to date as possible.  This
is# preferable to committing and rebasing before pushing as it would
be better to# waste some time repeating work than commit potentially
corrupted files from a# git merge gone wrong.


But, this is also the case on master. I plan to send a patch someday.

---
>  scripts/run-cvecheck     | 4 ++++
>  scripts/run-patchmetrics | 5 +++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/scripts/run-cvecheck b/scripts/run-cvecheck
> index d22dc825..c6b00660 100755
> --- a/scripts/run-cvecheck
> +++ b/scripts/run-cvecheck
> @@ -90,6 +90,10 @@ if [ -e tmp/log/cve/cve-summary.json ]; then
>      git -C $METRICSDIR add cve-check/$BRANCH/$TIMESTAMP.json
>      git -C $METRICSDIR commit -asm "Autobuilder adding new CVE data for
> branch $BRANCH" || true
>      if [ "$PUSH" =3D "1" ]; then
> +        if ! git -C $METRICSDIR pull --rebase; then
> +            echo "Aborting push, metrics repo has updated and cannot
> rebase cleanly"
> +            exit 1
> +        fi
>          git -C $METRICSDIR push
>      fi
>      $OURDIR/cve-report.py tmp/log/cve/cve-summary.json >
> $RESULTSDIR/cve-status-$BRANCH.txt
> diff --git a/scripts/run-patchmetrics b/scripts/run-patchmetrics
> index 391ac45a..5fe3d8f3 100755
> --- a/scripts/run-patchmetrics
> +++ b/scripts/run-patchmetrics
> @@ -24,6 +24,11 @@ if [ ! -e $PARENTDIR/yocto-metrics ]; then
>  fi
>  $OURDIR/patchmetrics-update --repo $PARENTDIR --patchscript
> $PARENTDIR/scripts/contrib/patchreview.py --metadata $TARGETDIR --json
> $PARENTDIR/yocto-metrics/patch-status.json
>  git -C $PARENTDIR/yocto-metrics commit -asm "Autobuilder adding new patc=
h
> stats"
> +
> +if ! git -C $PARENTDIR/yocto-metrics pull --rebase; then
> +    echo "Aborting push, metrics repo has updated and cannot rebase
> cleanly"
> +    exit 1
> +fi
>  git -C $PARENTDIR/yocto-metrics push
>
>  if [ ! -d $RESULTSDIR ]; then
> --
> 2.43.0
>
>
>
> ------------
> Links: You receive all messages sent to this group.
> View/Reply Online (#3143):
> https://lists.yoctoproject.org/g/yocto-patches/message/3143
> Mute This Topic: https://lists.yoctoproject.org/mt/117528934/4316185
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://lists.yoctoproject.org/g/yocto-patches/leave/13179410/4316185/929=
767106/xyzzy
> [yoann.congal@smile.fr]
> ------------
>
>
>

--=20
Yoann Congal
Smile ECS

--0000000000006b3d90064989e4ac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Le=C2=A0jeu. 29=
 janv. 2026 =C3=A0=C2=A017:37, Ross Burton via <a href=3D"http://lists.yoct=
oproject.org">lists.yoctoproject.org</a> &lt;ross.burton=3D<a href=3D"mailt=
o:arm.com@lists.yoctoproject.org">arm.com@lists.yoctoproject.org</a>&gt; a =
=C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">There&#39;s a chance that run-cvecheck and run-patchmetrics fail to push<=
br>
because the remote repository has changed. Try to resolve this by pulling<b=
r>
and rebasing immediately before the push, and failing if we can&#39;t rebas=
e.<br>
<br>
Backport of 60e2011 from master.<br>
<br>
[ YOCTO #15686 ]<br>
<br>
Signed-off-by: Ross Burton &lt;<a href=3D"mailto:ross.burton@arm.com" targe=
t=3D"_blank">ross.burton@arm.com</a>&gt;<br>
</blockquote><div><br></div><div>Thanks Ross,</div><div><br></div><div>I mi=
ssed that when fixing=C2=A0<a href=3D"https://bugzilla.yoctoproject.org/sho=
w_bug.cgi?id=3D16111">https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D1=
6111</a> (on Dunfell)</div><div><br></div><div>There is a now obsolete comm=
ent to remove/rephrase:</div><div><pre><code><pre><span class=3D"gmail-c1">=
# Do another pull to make sure we&#39;re as up to date as possible.  This i=
s</span>
<span class=3D"gmail-c1"># preferable to committing and rebasing before pus=
hing as it would be better to</span>
<span class=3D"gmail-c1"># waste some time repeating work than commit poten=
tially corrupted files from a</span>
<span class=3D"gmail-c1"># git merge gone wrong.</span></pre></code></pre><=
br></div><div>But, this is also the case on master. I plan=C2=A0to send a p=
atch someday.</div><div><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">---<br>
=C2=A0scripts/run-cvecheck=C2=A0 =C2=A0 =C2=A0| 4 ++++<br>
=C2=A0scripts/run-patchmetrics | 5 +++++<br>
=C2=A02 files changed, 9 insertions(+)<br>
<br>
diff --git a/scripts/run-cvecheck b/scripts/run-cvecheck<br>
index d22dc825..c6b00660 100755<br>
--- a/scripts/run-cvecheck<br>
+++ b/scripts/run-cvecheck<br>
@@ -90,6 +90,10 @@ if [ -e tmp/log/cve/cve-summary.json ]; then<br>
=C2=A0 =C2=A0 =C2=A0git -C $METRICSDIR add cve-check/$BRANCH/$TIMESTAMP.jso=
n<br>
=C2=A0 =C2=A0 =C2=A0git -C $METRICSDIR commit -asm &quot;Autobuilder adding=
 new CVE data for branch $BRANCH&quot; || true<br>
=C2=A0 =C2=A0 =C2=A0if [ &quot;$PUSH&quot; =3D &quot;1&quot; ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ! git -C $METRICSDIR pull --rebase; then<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &quot;Aborting push, metric=
s repo has updated and cannot rebase cleanly&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git -C $METRICSDIR push<br>
=C2=A0 =C2=A0 =C2=A0fi<br>
=C2=A0 =C2=A0 =C2=A0$OURDIR/cve-report.py tmp/log/cve/cve-summary.json &gt;=
 $RESULTSDIR/cve-status-$BRANCH.txt<br>
diff --git a/scripts/run-patchmetrics b/scripts/run-patchmetrics<br>
index 391ac45a..5fe3d8f3 100755<br>
--- a/scripts/run-patchmetrics<br>
+++ b/scripts/run-patchmetrics<br>
@@ -24,6 +24,11 @@ if [ ! -e $PARENTDIR/yocto-metrics ]; then<br>
=C2=A0fi<br>
=C2=A0$OURDIR/patchmetrics-update --repo $PARENTDIR --patchscript $PARENTDI=
R/scripts/contrib/patchreview.py --metadata $TARGETDIR --json $PARENTDIR/yo=
cto-metrics/patch-status.json<br>
=C2=A0git -C $PARENTDIR/yocto-metrics commit -asm &quot;Autobuilder adding =
new patch stats&quot;<br>
+<br>
+if ! git -C $PARENTDIR/yocto-metrics pull --rebase; then<br>
+=C2=A0 =C2=A0 echo &quot;Aborting push, metrics repo has updated and canno=
t rebase cleanly&quot;<br>
+=C2=A0 =C2=A0 exit 1<br>
+fi<br>
=C2=A0git -C $PARENTDIR/yocto-metrics push<br>
<br>
=C2=A0if [ ! -d $RESULTSDIR ]; then<br>
-- <br>
2.43.0<br>
<br>
<br>
<br>
------------<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#3143): <a href=3D"https://lists.yoctoproject.org/g/yoct=
o-patches/message/3143" rel=3D"noreferrer" target=3D"_blank">https://lists.=
yoctoproject.org/g/yocto-patches/message/3143</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/117528934/431=
6185" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/m=
t/117528934/4316185</a><br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leav=
e/13179410/4316185/929767106/xyzzy" rel=3D"noreferrer" target=3D"_blank">ht=
tps://lists.yoctoproject.org/g/yocto-patches/leave/13179410/4316185/9297671=
06/xyzzy</a> [<a href=3D"mailto:yoann.congal@smile.fr" target=3D"_blank">yo=
ann.congal@smile.fr</a>]<br>
------------<br>
<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"Raleway, regular">Yoann Congal</font><div><fon=
t face=3D"Raleway, regular">Smile ECS</font></div></div></div></div>

--0000000000006b3d90064989e4ac--

