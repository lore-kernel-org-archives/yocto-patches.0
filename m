Return-Path: <anibal@limonsoftware.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1205EF8FF9
	for <webhook@archiver.kernel.org>; Wed,  4 Mar 2026 15:39:04 +0000 (UTC)
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21126.1772638742434666371
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 04 Mar 2026 07:39:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@limonsoftware-com.20230601.gappssmtp.com header.s=20230601 header.b=16ZqO944;
 spf=pass (domain: limonsoftware.com, ip: 74.125.224.51, mailfrom: anibal@limonsoftware.com)
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64c9a398bc7so6611303d50.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 04 Mar 2026 07:39:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772638741; cv=none;
        d=google.com; s=arc-20240605;
        b=A+Bo7SvHWUnXaTPHN4m9nyDfM9kgTUjLcIEc1SkI+8dZRaZuslTaLcOTkIcdL1Mp+o
         FCXHmZD+EDlT3GcJgaa/mtPuLEFWZRcSWF+FyxcUdewQ5/OS/mTxroqBmKV9G6udph4H
         sQNi4hgkB4ZeTtt1eMPbVFxG5n/zhdgduOkFqO/7lNfq83Az5E5t5Z8K9tfwRdzqD4Uf
         gYBd5ER7KSJwBKtZw3vSUhkevaRfkn3ePr/bu5ho+s3gAAPxNBVmwuHGJiJsum3bUioZ
         tTjlTyvDePbo6c8fYDOTIwHkv/KdhrvfqSul46YqrISXZSWgAW30ZwzRblkvlKzH7GvR
         aB1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VmVeHl40aKUjwClFOy8KoGqMBP08Qpsx7jmKu8Ey95s=;
        fh=IY6oELPMgM7DMlSMKOF/3fTYL2xIQSbopO2HlozVJmE=;
        b=UrEXosBee43AjHPeG3M45Gqr2zOnWt5i3U5g7wXRtfEuMF6P+LnoLoDRyelWv6erve
         TdLOWuZ2Vy7xHOtyUADEkLpMnyl3Up/DAtz5TW8oOWg2ZFxNjkssWb1zgbUhsGtWYvp4
         zgzYksn6Z5zeY6RPuCwDS6hiMB+4fuoByry37hH622fs9qTG2PDHqt2AoNEN1B0uw570
         mHYpZnauwQS9OZASw/SvDlNQGzOy1EekJgnP+CmHSZnk5FRNAWtm0oqB/+yzFsmT/shZ
         yCSAURYsM0N/aoE3hWkN+whEY1iLllQ8LywXhVKnBf5MSzWPTl+ify1A5EsSbYmXMBPj
         BD9Q==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=limonsoftware-com.20230601.gappssmtp.com; s=20230601; t=1772638741; x=1773243541; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VmVeHl40aKUjwClFOy8KoGqMBP08Qpsx7jmKu8Ey95s=;
        b=16ZqO944joTVpJhu3fswoErbOWejvZHmX4EDnIew4PfuNXftwUlrBN/CmMuuop/7GV
         dyMzoNpfDaBD9IUx4S3kn7aYNSfbtqFQF6K/vsU5FbS9zhxJeHt9VE5pzLzNVdeIr5J0
         DuIDL/nJaKkTmsXuTJ8OqxU22S84Ll6MLrfmexX1XFEiXOi4zioFPzZINo17iccAOQ0T
         t8++XVAfJDWO0KcaGIBvIFbVhmSHT9NzXOaagHnMLgTfqS0K0qrRsiXJclkNtPpZbPKu
         nzG52SwE0LjIkzE3Wi8yO5VNiIMNcZmOt6H+NbjQN641HgGSjnFuKLDAWVg7WfmMmDfv
         tM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772638741; x=1773243541;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmVeHl40aKUjwClFOy8KoGqMBP08Qpsx7jmKu8Ey95s=;
        b=SrICdaWz/cowOxwRBHWwuh++2ZV5CBkEfWpdQohLtcYKi2XooXheSxjmmoc//CN1AS
         l9kPqVIfVN2elG/2R2QxohvKJrh2goGb7VzgD8HHujOz9xd8HUR4sOFFCl25N1L9fCO0
         FcDi4aThzS1PmHddFgdMlgaKYYy3gw0prNCpkHQwEfj14fkWSnmU+/OR7a0prtxoZzYO
         f1YK16IFktZCht3gd+21SsOvr9EbwKxtyFKtBxzbZ8rYiNHU2uHGimBOy04DUklLOSav
         jx4hTgipwy3vfFeaRsZwH7cXGoXB6M/yTYHtUem7MM7v07QC07ZwjRoQNLeUn6TcHJpc
         DhFg==
X-Gm-Message-State: AOJu0Ywnpf380jjY0X9uu/olvxDelqAr1mdoLXzxCDDBz6/mdvNUHypN
	BgNIb07mtITa24LHRu6rSJIEcZp22lKC88qWMQE9fNG+6BF/l9y49wox6g8MT45IEV6dx9pPlu0
	OqonLEThj6W6NUB+tfemqMw+Zr27jLjkxAWeeL4wLsLSmhfYgd+eR
X-Gm-Gg: ATEYQzzOTNcibhDkSJZn+tOWJYmYGNWmZMnwl63wDm4orWkLYVs3AL5HxqZSKY6nM5S
	adCm3H2KMxAJp8ZypZqonnk2Pmi6bhbpxZ0Ozds8CwBf8Ss0ZFc5+sH8DEOlDUZANm2odhswgsV
	AS5KsY3HxPSFTQpypEgiFMpzVdgPfVxIZXhzTii3CNfJADinzAN1j+evNMJccvynPUstnPIM/nL
	CNWRivTM5LqYjGOyN+H/y0CN9soYmL2TLSPWunDl5/C+Ol6kDJ4u0+WBLWX2RnlOkxpD2CznPdO
	+1QOoPov1Ddi30F5FVuOSdkGCNxftEC7AccGMETaycaWjIVsrjluEBlepP+bgYPBj/iguVnG67e
	lyZW1
X-Received: by 2002:a05:690e:1343:b0:649:ca5c:5990 with SMTP id
 956f58d0204a3-64cf9ff36dfmr1653519d50.66.1772638741501; Wed, 04 Mar 2026
 07:39:01 -0800 (PST)
MIME-Version: 1.0
References: <20260302174500.357368-1-yoann.congal@smile.fr>
In-Reply-To: <20260302174500.357368-1-yoann.congal@smile.fr>
From: Anibal Limon <anibal@limonsoftware.com>
Date: Wed, 4 Mar 2026 09:38:50 -0600
X-Gm-Features: AaiRm50TyrlfD82maNtpxdl_Tps7mBxbdxU6SjY4O2fy_QMxkg6zSbl1UIBp2t8
Message-ID: <CAOU5ZMtGChGdXChKgHU1X1daSa3erVOC-8wbAHaGmJkmSXOkvw@mail.gmail.com>
Subject: Re: [ptest-runner][PATCH 1/2] ptest-runner-collect-system-data: add
 info to logs
To: Yoann Congal <yoann.congal@smile.fr>
Cc: yocto-patches@lists.yoctoproject.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: multipart/alternative; boundary="00000000000080aa88064c349e70"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 04 Mar 2026 15:39:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3328

--00000000000080aa88064c349e70
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yoann,

Adding Alexander, comment below,

On Mon, Mar 2, 2026 at 11:45=E2=80=AFAM Yoann Congal <yoann.congal@smile.fr=
> wrote:

> From: Yoann Congal <yoann.congal@smile.fr>
>
> Print a banner to make it more clear what is happening when reading the
> logs.
>
> Add used commands to stdout by using shell's "set -x" (which prints used
> commands to stderr, so, also redirect stderr to stdout).
>
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> ---
>  ptest-runner-collect-system-data | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/ptest-runner-collect-system-data
> b/ptest-runner-collect-system-data
> index ba335da..15205f1 100755
> --- a/ptest-runner-collect-system-data
> +++ b/ptest-runner-collect-system-data
> @@ -1,5 +1,9 @@
>  #!/bin/sh
>  # Other ideas on what to do when a ptest gets stuck welcome.
> +
> +echo "Collected system state:"
>

Can you add a comment here explaining why `exec` and `set` are used?

+exec 2>&1
> +set -x
>  dmesg
>  pstree -a -l
>  df
>

--00000000000080aa88064c349e70
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Yoann,<div><br></div><div>Adding Alexa=
nder, comment below,</div></div><br><div class=3D"gmail_quote gmail_quote_c=
ontainer"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 2, 2026 at 11:4=
5=E2=80=AFAM Yoann Congal &lt;<a href=3D"mailto:yoann.congal@smile.fr">yoan=
n.congal@smile.fr</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">From: Yoann Congal &lt;<a href=3D"mailto:yoann.congal@smil=
e.fr" target=3D"_blank">yoann.congal@smile.fr</a>&gt;<br>
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
---<br>
=C2=A0ptest-runner-collect-system-data | 4 ++++<br>
=C2=A01 file changed, 4 insertions(+)<br>
<br>
diff --git a/ptest-runner-collect-system-data b/ptest-runner-collect-system=
-data<br>
index ba335da..15205f1 100755<br>
--- a/ptest-runner-collect-system-data<br>
+++ b/ptest-runner-collect-system-data<br>
@@ -1,5 +1,9 @@<br>
=C2=A0#!/bin/sh<br>
=C2=A0# Other ideas on what to do when a ptest gets stuck welcome.<br>
+<br>
+echo &quot;Collected system state:&quot;<br></blockquote><div><br></div><d=
iv>Can you add a comment here explaining why `exec` and `set` are used?=C2=
=A0</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+exec 2&gt;&amp;1<br>
+set -x<br>
=C2=A0dmesg<br>
=C2=A0pstree -a -l<br>
=C2=A0df<br>
</blockquote></div></div>

--00000000000080aa88064c349e70--

