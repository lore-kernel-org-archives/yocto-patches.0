Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B324CD98C7
	for <webhook@archiver.kernel.org>; Wed, 10 Jun 2026 18:52:24 +0000 (UTC)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.28464.1781117540912474438
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 10 Jun 2026 11:52:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=A4aeXQKk;
 spf=pass (domain: konsulko.com, ip: 209.85.128.169, mailfrom: tim.orling@konsulko.com)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7dc2b658544so61400187b3.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 10 Jun 2026 11:52:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781117540; cv=none;
        d=google.com; s=arc-20240605;
        b=BzN6dHiwHcYx39ARIeDpVX/R+qYRtwSi0xegZhZmFY9CiQGH7NK0J9vkELCmn9SQ97
         ibhqVCKb28xI3pVKSX5AbqvuhOczX1IQ888yoahTOTRAe6QuCnnGPJlQsGfp3etOSuF1
         zn2+/t/YFdxQk7MS4eLmVPgkNJNiVdAoj9drUOwxpsRvhmzacmEr6DxNP0uwtryI4hvp
         H1kMRIsQs3C9A2kA+jkp0CIleI/mUIxNww/GBaVYcqGi4eWHclHzEtWEcibCTmjvSOBJ
         Mn/DQMoC0vpXXn1+pqKZYRGOvQGAC8aEPJ/qNh9Y4V7iecmxa7yFol+qiICBHv4YjNpW
         UL0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ngpIdYWiPEZ5uMEtOex0ZXJE+nwvcchHL3EVuw8rlew=;
        fh=oelZnrg5dmur//Cq9EZ6v+RhAeHGCj2nFzzrUJxuFwI=;
        b=DR5b4pygN+Vq4B6dPGfaWgRKRA7HcP6Hsfit1J719HCu/rW2ARKliFfgsHboXmmMIz
         E8fkDItMfPeZ6BJufE6gCefm2Ct+lNLvoH1xFHJkW3Ta8gANBLzGo11m7bCRZTR7RhsX
         ztfP42tUZJxa78FMABNRcmwH2CYDhBuNO9DgbaOr6cb7rFcLci1hsk5L1BTigmvardSo
         rhC2KVPoOWEKnHRsYtgOiQ6n5fOvt9Y3fzzLNu+bo9TFtxiGc+nDF127q0PMOwpML2hq
         qfSTutCC1QcUsLbMXAgWWix8wjvk+MiQz67Hsc2XIlpTDPsas2GZuMPpw79FggvHOmQ8
         V1YQ==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1781117540; x=1781722340; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ngpIdYWiPEZ5uMEtOex0ZXJE+nwvcchHL3EVuw8rlew=;
        b=A4aeXQKkKoTKNrWsCTbNFo2nsxeIQFGBY9QmJRMoEbVNFu7BHavU9QUPj3sRBQh0RM
         84LGbHuFu9juNvGY67yikxv9Wa52NDp93KcLpOhmEZ3qJuFd7Ul2HqvjEhuKqd1XcGcS
         Kvjg2btRjhQmuU+JRfh4UTmOdlbVl+hYh/LQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781117540; x=1781722340;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngpIdYWiPEZ5uMEtOex0ZXJE+nwvcchHL3EVuw8rlew=;
        b=OH2Sz+D9UtWitQb37MrGopUG9Dzpgc+hJ83Dgob1AmNQMM/tpoz8GxPKXDQmrEkKs8
         esqAB1Q4niMc+RQI3REnPx1UXsXM0McprR0NLoqonNEwLGMGuEGZ7BYB6xKiIzVq1dEx
         lBsg5/6itgxVU1EVO/vSnrEoKTJhez+w54zICqNe2MfcCezeZyneb5BtroAqa/91oqQ8
         pDXcRVLD38bWSxXfA0gVy+OgnUSWuD1QeS/K2ASauwxQCWZ+aniAlBdYn4LnAD2UkOQV
         T1kg3Cn+Rj5pi/yiHLQBiHxLNrlclPNeN+NMAk16kXUis+gWf9IKV5y6obcCa4wb0Xxa
         eAPQ==
X-Gm-Message-State: AOJu0YzPCXUZ7AcIT0BfNWBc6OF8kxwFfMG7OjYHeO3dLoZ15pzQ6rRk
	jJR+/wvo9Et3XHktJjxYELftR8RPWEpFhVB/B9qXnhXxeQ7B+6UTuc9CC/M/dbehcRxWGklfz7s
	Tkne+W616maYdNZlfr9wAAaiE8Gj9nVtyLMTGbPinVQ==
X-Gm-Gg: Acq92OH3JcA6R+yuVmW4RZ08IuKBrppXW9vohKkIs9yqmyvPs/H93rQLADJnnR/QqUS
	wH61MuRznUd9xUviTflw+uaSv/fHpnolRP6vrXsCMCIuExWYJtpWHkr7ZPonpcrsinHwgcMLlYM
	uP63ZVR4GFMH/0qODwANa+80MkHVcdOtIvlV0AvGm2xz/vsdbWmrFbtBNHnFil/r8JgthhIrIhw
	MPkhjZXby7fWhk9DYQhgUiz/RsgI4+Zj++WB+vUDSNWlgCTzU6s84EGgr8zKPfRzr96vzwdHE1q
	LpOvfyKbU+SEVdOy6g==
X-Received: by 2002:a05:690c:6c8e:b0:7b2:dad2:5dee with SMTP id
 00721157ae682-7f616f1f798mr5201517b3.2.1781117540003; Wed, 10 Jun 2026
 11:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260609164032.1415124-1-sandeep.gundlupet-raju@amd.com> <20260609164032.1415124-4-sandeep.gundlupet-raju@amd.com>
In-Reply-To: <20260609164032.1415124-4-sandeep.gundlupet-raju@amd.com>
From: Tim Orling <tim.orling@konsulko.com>
Date: Wed, 10 Jun 2026 11:52:09 -0700
X-Gm-Features: AVVi8CfcpTvOIE1WL7Px69ZqfhN26gnKO6kiz0qmbFl9nat-q0eqOadYto87lEM
Message-ID: <CAOyo-86SX3_JD3KzZjj-sJZC85uNXm9BdkrESJfaJZFn-hiVEg@mail.gmail.com>
Subject: Re: [yocto-patches] [layerindex-web][PATCH v3 3/4] README.devel:
 Replace deprecated libmariadb package
To: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
Cc: yocto-patches@lists.yoctoproject.org, mark.hatle@kernel.crashing.org, 
	piotr@qbee.io
Content-Type: multipart/alternative; boundary="000000000000467e710653eabef2"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 10 Jun 2026 18:52:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4204

--000000000000467e710653eabef2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Merged. This is a change in upstream Ubuntu packaging.

On Tue, Jun 9, 2026 at 9:40=E2=80=AFAM Sandeep Gundlupet Raju <
sandeep.gundlupet-raju@amd.com> wrote:

> Replace deprecated libmariadb-client-lgpl-dev with libmariadb-dev
> package in README.devel instructions.
>
> AI-Generated: GitHub Copilot (Claude Sonnet 4.6)
>
> Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
> ---
>  README.devel | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/README.devel b/README.devel
> index 78fbfbb..de370e5 100644
> --- a/README.devel
> +++ b/README.devel
> @@ -40,7 +40,7 @@ distros).
>     the database backend):
>
>     sudo apt-get update
> -   sudo apt-get install python3-venv libmariadb-client-lgpl-dev
> build-essential python3-dev libjpeg-dev libz-dev libfreetype6-dev
> libssl-dev mariadb-server rabbitmq-server
> +   sudo apt-get install python3-venv libmariadb-dev build-essential
> python3-dev libjpeg-dev libz-dev libfreetype6-dev libssl-dev mariadb-serv=
er
> rabbitmq-server
>
>  2. Work around path issues (you may not need this):
>
> --
> 2.43.0
>
>

--000000000000467e710653eabef2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Merged. This is a change in upstream Ubuntu packaging.</di=
v><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">On Tue, Jun 9, 2026 at 9:40=E2=80=AFAM Sandeep Gundlupet =
Raju &lt;<a href=3D"mailto:sandeep.gundlupet-raju@amd.com">sandeep.gundlupe=
t-raju@amd.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">Replace deprecated libmariadb-client-lgpl-dev with libmariadb=
-dev<br>
package in README.devel instructions.<br>
<br>
AI-Generated: GitHub Copilot (Claude Sonnet 4.6)<br>
<br>
Signed-off-by: Sandeep Gundlupet Raju &lt;<a href=3D"mailto:sandeep.gundlup=
et-raju@amd.com" target=3D"_blank">sandeep.gundlupet-raju@amd.com</a>&gt;<b=
r>
---<br>
=C2=A0README.devel | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/README.devel b/README.devel<br>
index 78fbfbb..de370e5 100644<br>
--- a/README.devel<br>
+++ b/README.devel<br>
@@ -40,7 +40,7 @@ distros).<br>
=C2=A0 =C2=A0 the database backend):<br>
<br>
=C2=A0 =C2=A0 sudo apt-get update<br>
-=C2=A0 =C2=A0sudo apt-get install python3-venv libmariadb-client-lgpl-dev =
build-essential python3-dev libjpeg-dev libz-dev libfreetype6-dev libssl-de=
v mariadb-server rabbitmq-server<br>
+=C2=A0 =C2=A0sudo apt-get install python3-venv libmariadb-dev build-essent=
ial python3-dev libjpeg-dev libz-dev libfreetype6-dev libssl-dev mariadb-se=
rver rabbitmq-server<br>
<br>
=C2=A02. Work around path issues (you may not need this):<br>
<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div>

--000000000000467e710653eabef2--

