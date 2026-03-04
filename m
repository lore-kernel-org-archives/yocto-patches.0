Return-Path: <anibal@limonsoftware.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4713EFCE4B
	for <webhook@archiver.kernel.org>; Wed,  4 Mar 2026 20:57:10 +0000 (UTC)
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.28774.1772657828531428329
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 04 Mar 2026 12:57:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@limonsoftware-com.20230601.gappssmtp.com header.s=20230601 header.b=pkJD7BrO;
 spf=pass (domain: limonsoftware.com, ip: 74.125.224.47, mailfrom: anibal@limonsoftware.com)
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64ad8435f46so6959560d50.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 04 Mar 2026 12:57:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772657827; cv=none;
        d=google.com; s=arc-20240605;
        b=RlgPY//5tQ1mHESOksFp4z+AsVOTCBMoFPaSLxTTNeBN2iavbhu2yDFcSDTwU8uJg8
         1ywCIDb2jNpOgd8Lr82hhH8r+ooXkUpienmnBeNJYrjGRCCi/3kgCnD2e1cp6f9bfOE1
         Ep2z1XL32FvUd+yJVLsYurOdueKKz59+uYGm2unreMjl98YUSf4H0MpwMa6E84dxaEI9
         MDehJw0IgpDzKDfFVjo2Au7q6eHiogJSkegkXTIvff3mK27pwHVYaHIZ1KbEWmcb9qs5
         P0QCPk89lmEhu2WaT4gK2Rduu13YCi1Hta6C+Ytt/gMrhagjLC+g4mNfCm+ZiQMTMgT3
         nuLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qpo4N4oU26FF44VHm32cZVYP8TuW4ffPoOSzkFp40f0=;
        fh=8XdCfJCTG57yxLOnISsP7H+e49tsWEu8sv/4mHOZlt4=;
        b=jLLOept/oO3c5YukTMa3fH2qfM8ywbKmrcPgC3iTTTrukJ8lQSUGOK9w+CnYYqofsW
         0hMX/5Tl76DAhP+va1+aKcMPOe8+MAUt4gBhYSI3wVdDmJPvoIn0O6mFnLNkIs3YXWjU
         NewnD8jVmKHU21sAqpsRR5RPWCNgPlGLF/KMWiKL+FVV5N4Bm2KQsCqWs7y6IGBOyM+5
         U1SFvRxrEiCdQuA/iM4bZ06bCQp+O2j/5WXnxhmv6s45qrSFea4FIqGlc/LsFUK+JIf4
         S6nGH9m3jGcp3aXN9sln4/SuTRs1kwS6LAcPzLkJuA15wr9T4u8l/bFakbSj2RtGOWi/
         vKhg==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=limonsoftware-com.20230601.gappssmtp.com; s=20230601; t=1772657827; x=1773262627; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qpo4N4oU26FF44VHm32cZVYP8TuW4ffPoOSzkFp40f0=;
        b=pkJD7BrO2hOac/ZOKJhW6Re/pKZuqdrxHTPnjQQEV63KwVegiLgB2Lp1xn5snSdZHp
         m8iCuqW3I41PjQ6kubLU41KK+Y841k3uBtKc/8F6vQFd70mQq+zOpZ+5zO7o7VbEPdNG
         KSzqpZqm16gyeW9SjqhotQwXM5LE6hQQD1ZpyUVRQcC3mIuFZTy4Up2Jp5y0NJu+xfX5
         DaRXhWVCy3ULqNbKAEVuwbPTlfAMvH2KEhzkmb/LPryBcFMuoBcQvq5p+QqNi9nzZ//o
         JRVrWoUci2ZLmgZhf8XYVeQJMGeu3OzUI163eK5nDJIYYF4vAPNRFjmqv3F362FxV4kw
         YLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772657827; x=1773262627;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpo4N4oU26FF44VHm32cZVYP8TuW4ffPoOSzkFp40f0=;
        b=YpiSADOVpj/jfkx/frv7qbPYC8Kj/gWEikY99c1C66b46WufFCydaTH4zhbr/Ub7rf
         arqegCNbCjYrO3N7NIrlmBjiIaxgimfLIcwqiwUs/vwEUsZwdr2x3exYWPbUK+6a8GBR
         jub4GjvjkyfwXzc1lgMJNQ7uLGtamGvdn9zfjCum9Jr3iop7Mmn6uBFfRwVHEo0olWUU
         GLImQvCw4VSjkuDtuPzfqHXGPJFyI0XN27dvazJx8kcy567dThiS42Dw9ilOHnOUhmPI
         dVzpxQc9fJ9Ngd5M4SS4ZSlh+bma38x0Ja8DIU15pGFK9otPc/aOnMFeVpEcLyq6lXjz
         mTxQ==
X-Gm-Message-State: AOJu0YwKm3RONel+xrlBw4R2xOCcJCZ+sEsbWYGGZ/wVboOFSf3R8CL0
	KkOdqSXTvBaqsUs77+SCMrVkQrElkiYSLhHUtDUwu8+TGNdpz2BmyqF6u3qCOmtP6f5UqmhdmiK
	SrtWlDTexY9b/BJRioPhz1/qMCwCSQoW9eByJsdQNXgqXG2QhMVVy
X-Gm-Gg: ATEYQzwOaNueIxXs6Qjq6T5FMF51x8zSqF80M2viKIhYoqt8Tsw2rqNZEreTrPaB5mS
	2u/vwmMQXP0A4/ZhQOtPCQASFvdT4DfN6N3/kTMYTs7JVrmRzXKVl/RiTZhVf6G3lLy1ZD3Y36o
	peSu5hWocbq0mrJtYyKQJxihvf3yVeNev0DG2/TuxNxjmw3bjUQxk9v4+zDgbSEnW2WGJtEQkrr
	Jq+V5Iopv3IMHYOGE9HaUG3ZIBRuZAasm0Yidtw/CPKaeq0uHfS3pGPhcavbWP1+vD9RkrCysYw
	Xgdpj81D1Y5yxbgq5LDAQ31dLKawOVaeN+nVVGGvdASF/RQFNjtrpCYNHSIQOtIuIw5AYg==
X-Received: by 2002:a05:690e:1901:b0:64c:eab2:e4a6 with SMTP id
 956f58d0204a3-64cf9b2f0camr2857342d50.13.1772657827421; Wed, 04 Mar 2026
 12:57:07 -0800 (PST)
MIME-Version: 1.0
References: <20260304155922.1121052-1-yoann.congal@smile.fr>
In-Reply-To: <20260304155922.1121052-1-yoann.congal@smile.fr>
From: Anibal Limon <anibal@limonsoftware.com>
Date: Wed, 4 Mar 2026 14:56:56 -0600
X-Gm-Features: AaiRm535U6xGsp8Cs0zQ1Ac3Ze_X0nM9O6XMLJ2jgg8ly8fBKj_71oaMWsXVipU
Message-ID: <CAOU5ZMuD5TuRmi6+WfcrJYTJ1RB0OgEeujwWajSWymxnOu7bbg@mail.gmail.com>
Subject: Re: [yocto-patches] [ptest-runner][PATCH v2] ptest-runner-collect-system-data:
 add info to logs
To: yocto-patches@lists.yoctoproject.org
Cc: Alexander Kanavin <alex@linutronix.de>, Yoann Congal <yoann.congal@smile.fr>
Content-Type: multipart/alternative; boundary="0000000000001caee7064c39101a"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 04 Mar 2026 20:57:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3334

--0000000000001caee7064c39101a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thank you!

On Wed, Mar 4, 2026 at 9:59=E2=80=AFAM Yoann Congal via lists.yoctoproject.=
org
<yoann.congal=3Dsmile.fr@lists.yoctoproject.org> wrote:

> From: Yoann Congal <yoann.congal@smile.fr>
>
> Print a banner to make it more clear what is happening when reading the
> logs.
>
> Add used commands to stdout by using shell's "set -x" (which prints used
> commands to stderr, so, also redirect stderr to stdout).
>
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
>
> ---
> v1->v2: add comment for "exec 2>&1; set -x"
> ---
>  ptest-runner-collect-system-data | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/ptest-runner-collect-system-data
> b/ptest-runner-collect-system-data
> index ba335da..8023a74 100755
> --- a/ptest-runner-collect-system-data
> +++ b/ptest-runner-collect-system-data
> @@ -1,5 +1,14 @@
>  #!/bin/sh
>  # Other ideas on what to do when a ptest gets stuck welcome.
> +
> +echo "Collected system state:"
> +
> +# Use set -x to print used command.
> +# Since "set -x" prints on stderr and we log stdout, redirect stderr to
> stdout
> +# first.
> +exec 2>&1
> +set -x
> +
>  dmesg
>  pstree -a -l
>  df
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3330):
> https://lists.yoctoproject.org/g/yocto-patches/message/3330
> Mute This Topic: https://lists.yoctoproject.org/mt/118134754/8181911
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://lists.yoctoproject.org/g/yocto-patches/leave/13235916/8181911/179=
31940/xyzzy
> [anibal@limonsoftware.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--0000000000001caee7064c39101a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Applied, thank you!</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 4, 20=
26 at 9:59=E2=80=AFAM Yoann Congal via <a href=3D"http://lists.yoctoproject=
.org">lists.yoctoproject.org</a> &lt;yoann.congal=3D<a href=3D"mailto:smile=
.fr@lists.yoctoproject.org">smile.fr@lists.yoctoproject.org</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: Yoann Cong=
al &lt;<a href=3D"mailto:yoann.congal@smile.fr" target=3D"_blank">yoann.con=
gal@smile.fr</a>&gt;<br>
<br>
Print a banner to make it more clear what is happening when reading the<br>
logs.<br>
<br>
Add used commands to stdout by using shell&#39;s &quot;set -x&quot; (which =
prints used<br>
commands to stderr, so, also redirect stderr to stdout).<br>
<br>
Signed-off-by: Yoann Congal &lt;<a href=3D"mailto:yoann.congal@smile.fr" ta=
rget=3D"_blank">yoann.congal@smile.fr</a>&gt;<br>
<br>
---<br>
v1-&gt;v2: add comment for &quot;exec 2&gt;&amp;1; set -x&quot;<br>
---<br>
=C2=A0ptest-runner-collect-system-data | 9 +++++++++<br>
=C2=A01 file changed, 9 insertions(+)<br>
<br>
diff --git a/ptest-runner-collect-system-data b/ptest-runner-collect-system=
-data<br>
index ba335da..8023a74 100755<br>
--- a/ptest-runner-collect-system-data<br>
+++ b/ptest-runner-collect-system-data<br>
@@ -1,5 +1,14 @@<br>
=C2=A0#!/bin/sh<br>
=C2=A0# Other ideas on what to do when a ptest gets stuck welcome.<br>
+<br>
+echo &quot;Collected system state:&quot;<br>
+<br>
+# Use set -x to print used command.<br>
+# Since &quot;set -x&quot; prints on stderr and we log stdout, redirect st=
derr to stdout<br>
+# first.<br>
+exec 2&gt;&amp;1<br>
+set -x<br>
+<br>
=C2=A0dmesg<br>
=C2=A0pstree -a -l<br>
=C2=A0df<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#3330): <a href=3D"https://lists.yoctoproject.org/g/yoct=
o-patches/message/3330" rel=3D"noreferrer" target=3D"_blank">https://lists.=
yoctoproject.org/g/yocto-patches/message/3330</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/118134754/818=
1911" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/m=
t/118134754/8181911</a><br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leav=
e/13235916/8181911/17931940/xyzzy" rel=3D"noreferrer" target=3D"_blank">htt=
ps://lists.yoctoproject.org/g/yocto-patches/leave/13235916/8181911/17931940=
/xyzzy</a> [<a href=3D"mailto:anibal@limonsoftware.com" target=3D"_blank">a=
nibal@limonsoftware.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
</blockquote></div>

--0000000000001caee7064c39101a--

