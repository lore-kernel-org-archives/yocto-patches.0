Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC754E73152
	for <webhook@archiver.kernel.org>; Mon,  2 Feb 2026 10:15:06 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.49828.1770027300786891161
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 02 Feb 2026 02:15:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=NCQGH4HG;
 spf=pass (domain: snapchat.com, ip: 209.85.128.47, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4805ef35864so35698275e9.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 02 Feb 2026 02:15:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770027298; cv=none;
        d=google.com; s=arc-20240605;
        b=AdPemvImHJvhsTUchO+5ChPHHH1M3fZ7TgAgWtB6IvaYXz5t5/wjye83xpAMEitnL1
         Rs9tx4ZFKvkbv5Bf4nLVl9IJSSTP1wG8Z7osyOjt0oNxYunLTrfU2w2eKeKKDpN5ClS3
         LlFJbRz+O3YJU3hteYdRkILC40bYn8Lo2Z6Q6v9cX9CQe5qFfQInyVRZ52BOZ4OyVTAO
         4wvwaviXdQUCD//T/kQ1da34PCv5Vu1eTItl7YjhPtpSmdEkvweDhRpWzSr2sN0wPPsD
         o9zEP7LLH/a4jZGBS3JkL4R20/40k31/FZqtBJCk1rtkY5QHo2qzDOuqK/p/7UvbCH9C
         +0OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sjxOeTtic/zC2FDL81oX+CXSaWsmcPfFmOscnNgDp4I=;
        fh=vnwvjJBmT4xP5bZnotRs811IpgK/To6PNpBe4whKe/M=;
        b=Z522GbKzjeVBPUDyhwE6Rx3mD4fFJTdYSQceW/0JHluHcstjItaC2EoNsVn5nVJ96V
         rMD7+E3sVFIoyFWZ7YR6OjJH06XgZ9xvguknuB8i9uv62dEUfm1Gam+1bh5O+R9f998T
         nLTIk+nLY/UFj7FINBjuM31xCvgQkwuAASJB+J10H3yQnjlXaCKlsfdUfz64M9eaA5Je
         d1isyFbq68v4bQwUxnC1myNXebRtB/KNJ7XhcZXV6gKxsAs6bESAT/qMh1zUXoxArkwg
         muHjgMtsJ6QnLVOi5KM43H+MP9zbm1Q8swQys7rw6qsHAqvkLpCOOIeObxO+zh+9y+FY
         ZFFA==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1770027298; x=1770632098; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sjxOeTtic/zC2FDL81oX+CXSaWsmcPfFmOscnNgDp4I=;
        b=NCQGH4HGg1YSYNduzdwDPDOHnEWCOZXRA2P0AXGBBTs4R9oAHKHoADkKXH3W+bK7dP
         fmnEWKqist8usHvU2KQnXGAE+CGQ40HQbD4kMgtImjs/RnkLlZf2JcTZS9WPF6eQ3cRL
         gfNjBCejEsPYRU8JFazBPyxyB6HSorlv7M9X0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770027298; x=1770632098;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjxOeTtic/zC2FDL81oX+CXSaWsmcPfFmOscnNgDp4I=;
        b=PR4jUniC4vY7hnc4da1GfErPIx/5B0Xtp0irqKDCFXvVZBpySrgeZRHH/0OuS2lbBB
         LMp/SUj+2qFAOaWlWr8dzsZkC2hnJVQcnRyOr9Qe0/WEbRXkA3bPVMOBdWcqzVy0FM0o
         2G6Ca4cd27/VtC2ZaFDSXpKSItKcH0vx9px5YqGXmRPyt1T/PyZMoe9GCfQ7FiDCfN26
         cLIwUqep04hgtfiLyOd6Etu7Opx3ZgmQlTlTR4ATCr8Str5qLVxwwLplxuHMJQ1OB79x
         7WKTw6GRygNwp/LIPDCkzI+pS2y6vkYAXxEQa39T67jb6er/hcqB0wO3F+MP1PkpoSKV
         jB5w==
X-Gm-Message-State: AOJu0Ywf2aAPAC0TxL/Aqo0owmpN1yuJbLHnX13FibXZ4CrjLhKE+LLF
	8OM/xLSCdFqW3DQ/qXJE4FvIMsNkePaxIkaTn3UVpe2kLHa65cQOAWWcj+A7SBWXSEXXAWD/Jcj
	DuD3avQzMOBeiMGga0GFK1JlLy/YoQCiHvHNsWaeFyqH+w2cDD3Jj4yXxIg==
X-Gm-Gg: AZuq6aI2e8yCAsoWsFO3yTQ1+FW+wRFWMqPYJUbQ82vr4+LvklGvvxyzIaqvPwgTG8P
	SKFouXqvTADG7sCOmMnGrhBun0i+YkdLKM9J59Db7HEZf8TD2e+VxcTaS2c83KqeSmtHv7KS8fs
	wOLtfyJKmDIorxvt2FzSnkxZsRvF8VbGzBhPzyB1ZCGj5Urd0DmAosjNtb3J1mP8A1IsYYKqoz4
	GkISxgesZnLxUfXz5DV8uKCJkhFEPpTb5Z4I2kJ627mpNUFdIdBxdaWf9UFq/Dlq79kDyq5wkug
	vHaavg1fDOts+4PmyscWGlW9P5I=
X-Received: by 2002:a05:600c:3e1b:b0:477:afc5:fb02 with SMTP id
 5b1f17b1804b1-482db47cd93mr116643005e9.21.1770027298030; Mon, 02 Feb 2026
 02:14:58 -0800 (PST)
MIME-Version: 1.0
References: <20260201043133.20872-1-dev@qinc.tv>
In-Reply-To: <20260201043133.20872-1-dev@qinc.tv>
From: Etienne Cordonnier <ecordonnier@snap.com>
Date: Mon, 2 Feb 2026 11:14:47 +0100
X-Gm-Features: AZwV_QgEE8HfPrbDVDv3Jha70wXuMSgKChrMGRIHEwRUFQ_BKsv2K-wsVnKF7ag
Message-ID: <CAHUKmYYk9qwmbuOj-ODXp1LEo+i6WkZ1UOw5va7o_2S0Y8njLQ@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-darwin][PATCH] add hfsprogs (for mkfs.hfsplus)
To: yocto-patches@lists.yoctoproject.org
Cc: "Eric L. Hernes" <dev@qinc.tv>
Content-Type: multipart/alternative; boundary="00000000000057c0b90649d498f2"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 02 Feb 2026 10:15:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3166

--00000000000057c0b90649d498f2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,
I've applied the patch as
https://git.yoctoproject.org/meta-darwin/commit/?id=3Da1fa09adf78fba1bee892=
13945aa5791bb8bd693
Note that as far as I know, BBCLASSEXTEND and "inherit native" are normally
mutually exclusive. "inherit native" communicates that the recipe is
available for native only (and by convention those recipes are usually
renamed to foobar-native.bb), while "BBCLASSEXTEND +=3D "native" communicat=
es
that the recipe is available for target and for native.

On Sun, Feb 1, 2026 at 5:31=E2=80=AFAM Eric L. Hernes via lists.yoctoprojec=
t.org
<dev=3Dqinc.tv@lists.yoctoproject.org> wrote:

> mkfs.hfsplus is used to create the .dmg with hfsplus filesystem image
> ---
>  recipes-support/hfsprogs/hfsprogs_git.bb | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 recipes-support/hfsprogs/hfsprogs_git.bb
>
> diff --git a/recipes-support/hfsprogs/hfsprogs_git.bb
> b/recipes-support/hfsprogs/hfsprogs_git.bb
> new file mode 100644
> index 0000000..9dfdfbc
> --- /dev/null
> +++ b/recipes-support/hfsprogs/hfsprogs_git.bb
> @@ -0,0 +1,18 @@
> +SUMMARY =3D "HFS+ filesystem utilities for Linux"
> +DESCRIPTION =3D "Apple's HFS+ filesystem utilities (mkfs.hfsplus,
> fsck.hfsplus) \
> +adapted to work on Linux systems. Based on Apple's diskdev-cmds source
> code."
> +HOMEPAGE =3D "https://github.com/Artoria2e5/hfsprogs "
> +
> +LICENSE =3D "APSL-2.0"
> +LIC_FILES_CHKSUM =3D "file://README.md;md5=3Dea27fd14a7e575753270cc5527d=
29023"
> +
> +SRCREV =3D "064b7fece00d069f206fd2d4a9a4493dd2777d9f"
> +SRC_URI =3D "git://
> github.com/elhernes/hfsprogs.git;branch=3Dmaster;protocol=3Dhttps"
> +
> +S =3D "${WORKDIR}/git"
> +
> +DEPENDS =3D "openssl libbsd"
> +
> +inherit cmake native
> +
> +BBCLASSEXTEND +=3D "native"
> --
> 2.50.1 (Apple Git-155)
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3163):
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_g_yocto-2Dpatches_message_3163&d=3DDwIFAg&c=3DncDTmphkJTvjIDPh0hpF_4vC=
HvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3Dw3f=
XRU69Z5YfElM4ICjRW-4XowSrPXOFx7xKFaWJYwfNjcMesuqHG1ex2fgScca4&s=3Di-ALotW9A=
2WLEr9bgyU1V7yoSoTLkFKYZwWSRJ8Y6Xc&e=3D
> Mute This Topic:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_mt_117572941_7048771&d=3DDwIFAg&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC=
2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3Dw3fXRU69Z5YfE=
lM4ICjRW-4XowSrPXOFx7xKFaWJYwfNjcMesuqHG1ex2fgScca4&s=3DtePwR6PHpMGhurcs9-U=
0YifO1ynZy4pVpP5u8bJxBNM&e=3D
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_g_yocto-2Dpatches_leave_13184993_7048771_1814342232_xyzzy&d=3DDwIFAg&c=
=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRi=
h1DULJTKUkSGa66m67E&m=3Dw3fXRU69Z5YfElM4ICjRW-4XowSrPXOFx7xKFaWJYwfNjcMesuq=
HG1ex2fgScca4&s=3DbMvEzR8YJhudiFd_0mzLa6689n94eK7MLTdgPH9W6m8&e=3D
> [ecordonnier@snap.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--00000000000057c0b90649d498f2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Eric,<br>I&#39;ve applied=C2=A0the patch as=C2=A0<a hre=
f=3D"https://git.yoctoproject.org/meta-darwin/commit/?id=3Da1fa09adf78fba1b=
ee89213945aa5791bb8bd693">https://git.yoctoproject.org/meta-darwin/commit/?=
id=3Da1fa09adf78fba1bee89213945aa5791bb8bd693</a><br>Note that as far as I =
know, BBCLASSEXTEND and &quot;inherit native&quot; are normally mutually ex=
clusive. &quot;inherit native&quot; communicates that the recipe is availab=
le for native only (and by convention those recipes are usually renamed to =
<a href=3D"http://foobar-native.bb">foobar-native.bb</a>), while &quot;BBCL=
ASSEXTEND=C2=A0+=3D &quot;native&quot; communicates that the recipe is avai=
lable for target and for native.</div><br><div class=3D"gmail_quote gmail_q=
uote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Feb 1, 2026 a=
t 5:31=E2=80=AFAM Eric L. Hernes via <a href=3D"http://lists.yoctoproject.o=
rg">lists.yoctoproject.org</a> &lt;dev=3D<a href=3D"mailto:qinc.tv@lists.yo=
ctoproject.org">qinc.tv@lists.yoctoproject.org</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">mkfs.hfsplus is used to creat=
e the .dmg with hfsplus filesystem image<br>
---<br>
=C2=A0recipes-support/hfsprogs/<a href=3D"http://hfsprogs_git.bb" rel=3D"no=
referrer" target=3D"_blank">hfsprogs_git.bb</a> | 18 ++++++++++++++++++<br>
=C2=A01 file changed, 18 insertions(+)<br>
=C2=A0create mode 100644 recipes-support/hfsprogs/<a href=3D"http://hfsprog=
s_git.bb" rel=3D"noreferrer" target=3D"_blank">hfsprogs_git.bb</a><br>
<br>
diff --git a/recipes-support/hfsprogs/<a href=3D"http://hfsprogs_git.bb" re=
l=3D"noreferrer" target=3D"_blank">hfsprogs_git.bb</a> b/recipes-support/hf=
sprogs/<a href=3D"http://hfsprogs_git.bb" rel=3D"noreferrer" target=3D"_bla=
nk">hfsprogs_git.bb</a><br>
new file mode 100644<br>
index 0000000..9dfdfbc<br>
--- /dev/null<br>
+++ b/recipes-support/hfsprogs/<a href=3D"http://hfsprogs_git.bb" rel=3D"no=
referrer" target=3D"_blank">hfsprogs_git.bb</a><br>
@@ -0,0 +1,18 @@<br>
+SUMMARY =3D &quot;HFS+ filesystem utilities for Linux&quot;<br>
+DESCRIPTION =3D &quot;Apple&#39;s HFS+ filesystem utilities (mkfs.hfsplus,=
 fsck.hfsplus) \<br>
+adapted to work on Linux systems. Based on Apple&#39;s diskdev-cmds source=
 code.&quot;<br>
+HOMEPAGE =3D &quot;<a href=3D"https://github.com/Artoria2e5/hfsprogs" rel=
=3D"noreferrer" target=3D"_blank">https://github.com/Artoria2e5/hfsprogs</a=
> &quot;<br>
+<br>
+LICENSE =3D &quot;APSL-2.0&quot;<br>
+LIC_FILES_CHKSUM =3D &quot;file://README.md;md5=3Dea27fd14a7e575753270cc55=
27d29023&quot;<br>
+<br>
+SRCREV =3D &quot;064b7fece00d069f206fd2d4a9a4493dd2777d9f&quot;<br>
+SRC_URI =3D &quot;git://<a href=3D"http://github.com/elhernes/hfsprogs.git=
;branch=3Dmaster;protocol=3Dhttps" rel=3D"noreferrer" target=3D"_blank">git=
hub.com/elhernes/hfsprogs.git;branch=3Dmaster;protocol=3Dhttps</a>&quot;<br=
>
+<br>
+S =3D &quot;${WORKDIR}/git&quot;<br>
+<br>
+DEPENDS =3D &quot;openssl libbsd&quot;<br>
+<br>
+inherit cmake native<br>
+<br>
+BBCLASSEXTEND +=3D &quot;native&quot;<br>
-- <br>
2.50.1 (Apple Git-155)<br>
<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#3163): <a href=3D"https://urldefense.proofpoint.com/v2/=
url?u=3Dhttps-3A__lists.yoctoproject.org_g_yocto-2Dpatches_message_3163&amp=
;d=3DDwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhk=
bNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3Dw3fXRU69Z5YfElM4ICjRW-4Xow=
SrPXOFx7xKFaWJYwfNjcMesuqHG1ex2fgScca4&amp;s=3Di-ALotW9A2WLEr9bgyU1V7yoSoTL=
kFKYZwWSRJ8Y6Xc&amp;e=3D" rel=3D"noreferrer" target=3D"_blank">https://urld=
efense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject.org_g_yocto-2=
Dpatches_message_3163&amp;d=3DDwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgG=
kICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3Dw=
3fXRU69Z5YfElM4ICjRW-4XowSrPXOFx7xKFaWJYwfNjcMesuqHG1ex2fgScca4&amp;s=3Di-A=
LotW9A2WLEr9bgyU1V7yoSoTLkFKYZwWSRJ8Y6Xc&amp;e=3D</a> <br>
Mute This Topic: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dht=
tps-3A__lists.yoctoproject.org_mt_117572941_7048771&amp;d=3DDwIFAg&amp;c=3D=
ncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsR=
ih1DULJTKUkSGa66m67E&amp;m=3Dw3fXRU69Z5YfElM4ICjRW-4XowSrPXOFx7xKFaWJYwfNjc=
MesuqHG1ex2fgScca4&amp;s=3DtePwR6PHpMGhurcs9-U0YifO1ynZy4pVpP5u8bJxBNM&amp;=
e=3D" rel=3D"noreferrer" target=3D"_blank">https://urldefense.proofpoint.co=
m/v2/url?u=3Dhttps-3A__lists.yoctoproject.org_mt_117572941_7048771&amp;d=3D=
DwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonV=
uMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3Dw3fXRU69Z5YfElM4ICjRW-4XowSrPXO=
Fx7xKFaWJYwfNjcMesuqHG1ex2fgScca4&amp;s=3DtePwR6PHpMGhurcs9-U0YifO1ynZy4pVp=
P5u8bJxBNM&amp;e=3D</a> <br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-=
3A__lists.yoctoproject.org_g_yocto-2Dpatches_leave_13184993_7048771_1814342=
232_xyzzy&amp;d=3DDwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdi=
w&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3Dw3fXRU69Z5YfE=
lM4ICjRW-4XowSrPXOFx7xKFaWJYwfNjcMesuqHG1ex2fgScca4&amp;s=3DbMvEzR8YJhudiFd=
_0mzLa6689n94eK7MLTdgPH9W6m8&amp;e=3D" rel=3D"noreferrer" target=3D"_blank"=
>https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject.=
org_g_yocto-2Dpatches_leave_13184993_7048771_1814342232_xyzzy&amp;d=3DDwIFA=
g&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGR=
fPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3Dw3fXRU69Z5YfElM4ICjRW-4XowSrPXOFx7xK=
FaWJYwfNjcMesuqHG1ex2fgScca4&amp;s=3DbMvEzR8YJhudiFd_0mzLa6689n94eK7MLTdgPH=
9W6m8&amp;e=3D</a>=C2=A0 [<a href=3D"mailto:ecordonnier@snap.com" target=3D=
"_blank">ecordonnier@snap.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
</blockquote></div>

--00000000000057c0b90649d498f2--

